From: jonathan@raspberrypi.org (Jonathan Bell)
Date: Thu, 20 Mar 2014 19:54:02 +0000
Subject: [arm arch] local_irq_restore() does not play well with
 local_fiq_enable()
Message-ID: <op.xc1dkcblfh00o9@enterprised.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

I believe I've found an edge case where the FIQ enable bit in the CPSR for  
armv6 can get trampled through the use of a combination of the standard  
kernel interfaces and the arch-specific local_fiq_enable/local_fiq_disable  
macros.

We have an out-of-tree set of drivers on our mach-bcm2708 port that result  
in a bad interaction which disables FIQs for extended periods of time.

The below cliffnotes version is for readability, the full set of relevant  
code can be found at:

https://github.com/raspberrypi/linux/blob/rpi-3.10.y-next/drivers/misc/vc04_services/interface/vchiq_arm/
and
https://github.com/raspberrypi/linux/blob/rpi-3.10.y-next/drivers/usb/host/dwc_otg/dwc_otg_hcd_linux.c

In driver #1 (BRCM vchiq messagebox/GPU message passing handler) we do  
this:

vchiq_doorbell_irq:
	- Has the doorbell been poked from the GPU?
	- If yes
		up(vhciq_semaphore)
		return IRQ_HANDLED


in the corresponding "bottom half" we do something a bit silly but  
basically:


vchiq_worker_kthread:
	while (1)
		down_interruptible(vchiq_semaphore)
		process_gpu_messages()
		do_some_other_stuff()


In driver #2 (our dwc_otg/dwc2 implementation)	 we do the following on  
init:

hcd_init:
	setup the FIQ state
	install the fiq handler
	enable_fiq(USB)
	local_fiq_enable()
	usb_add_hcd()

Because the vchiq_worker_thread is waiting on a mailbox interrupt from the  
GPU, it initialises and goes to sleep almost immediately. In  
down_interruptible, there is a sequence of events (if the sem->count is  
<=0) that basically does

local_irq_save(flags)
local_irq_enable()
schedule();
local_irq_disable()
local_irq_restore(flags)

which then continues with the rest of the boot process, and probes USB  
which enables the FIQ.

The problem we get is that on boot, the vchiq services are probed and  
initialised before the USB driver is. A stale flags variable (with F bit  
set) borks things up as far as the FIQ is concerned.

On the first GPU interrupt, the vchiq_doorbell_irq increments the  
semaphore and wakes up the vchiq_worker_thread. Which then promptly  
overwrites the FIQ bit in the CPSR because the flags were saved before the  
FIQ was enabled.

The stale F bit then has the potential to propagate through other threads  
using similar mechanisms and causes no end of trouble to a FIQ handler  
that expects never to be disabled.

In our out-of-tree arch, I've "fixed" this by making local_irq_restore  
never touch the FIQ bit in CPSR.

See
https://github.com/raspberrypi/linux/commit/a0f47344e286768e3ce96268eed1ad0f6cfd9f2c
for the modification to arm/irqflags.h.

Should this be classed as a bug? The root cause is that the same register  
is used to enable priority FIQs as well as normal IRQs - thus the  
save(flags) and restore(flags) mechanisms trample on something that they  
don't know about.
