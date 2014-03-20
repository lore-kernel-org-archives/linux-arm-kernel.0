From: jonathan@raspberrypi.org (Jonathan Bell)
Date: Thu, 20 Mar 2014 20:49:24 +0000
Subject: [arm arch] local_irq_restore() does not play well with
 local_fiq_enable()
In-Reply-To: <20140320200233.GC7528@n2100.arm.linux.org.uk>
References: <op.xc1dkcblfh00o9@enterprised.lan>
 <20140320200233.GC7528@n2100.arm.linux.org.uk>
Message-ID: <op.xc1f4mxnfh00o9@enterprised.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 20:02:34 -0000, Russell King - ARM Linux  
<linux@arm.linux.org.uk> wrote:

> On Thu, Mar 20, 2014 at 07:54:02PM +0000, Jonathan Bell wrote:
>> hcd_init:
>> 	setup the FIQ state
>> 	install the fiq handler
>> 	enable_fiq(USB)
>> 	local_fiq_enable()
>> 	usb_add_hcd()
>
> You're not supposed to use local_fiq_enable() to enable FIQs in a device
> driver - they should already be enabled by this point.
>
> There has been a hole in that where FIQs haven't been enabled in the
> idle thread, but that's a bug which needs fixing.  Otherwise, you should
> assume that FIQs are always unmasked everywhere except for any short
> code sequences that are contained within a short local_fiq_disable()..
> local_fiq_enable() block.
>

Relying on FIQs being enabled elsewhere is in fact what we used to do  
until ~3.10, whereupon some change (most likely the bug you describe)  
broke this behaviour.

Our use of local_fiq_disable() and local_fiq_enable() are indeed  
constrained to minimally small critical sections (mostly reading/writing a  
single hardware register or state variable) within the dwc_otg driver that  
"handles" the results from the FIQ.

But even if FIQs are enabled before entering the idle thread, any kernel  
thread that sleeps (and yields the CPU) with an irqflags variable that was  
saved before the call to local_fiq_enable has the potential to corrupt the  
F bit when the thread subsequently wakes up.
