From: w@1wt.eu (Willy Tarreau)
Date: Tue, 7 May 2013 23:35:24 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <51892E87.5020903@itooo.com>
References: <51890C29.8000504@itooo.com> <20130507181823.23342ffb@skate>
 <51892E87.5020903@itooo.com>
Message-ID: <20130507213524.GB5414@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, May 07, 2013 at 06:40:39PM +0200, Greg wrote:
> Le 07/05/2013 18:18, Thomas Petazzoni a ?crit :
> >Dear Greg,
> >
> >On Tue, 07 May 2013 16:14:01 +0200, Greg wrote:
> >
> >>I'm trying to boot off the the backport-3.-8 kernel with armada-xp-db DT
> >>file.
> >>
> >>When eth0 is brought up (I'm booting on NFS) the mvneta driver fails in
> >>mvneta_open, with the following error :
> >>>mvneta d0070000.ethernet eth0: cannot request irq 25
> >>The oddness is this is not the actual IRQ to be requested, and the DTS
> >>files explicitly specify the IRQ is 8 for this device.
> >>
> >>I'm not familiar with the DT system, where should I start looking to
> >>find the source of the problem ?
> >This issue should be fixed by:
> >
> >commit 7f23f62fc31c5c97947414c0937a72e08a947a41
> >Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >Date:   Wed Mar 20 16:09:35 2013 +0100
> >
> >     arm: mvebu: Use local interrupt only for the timer 0
> >     
> >     The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
> >     managed the 28th first interrupts as local interrupt to match the
> >     hardware specification. Among these interrupts there are the Gigabits
> >     Ethernet ones used by the mvneta driver. Unfortunately the state of
> >     the percpu_irq API prevents the driver to use it.
> >     
> >     Indeed the interrupts have to be freed when the .stop() function is
> >     called. As the free_percpu_irq() function don't disable the interrupt
> >     line, we have to do it on each CPU before calling this. The function
> >     disable_percpu_irq() only disable the percpu on the current CPU and
> >     there is no function which allows to disable a percpu irq on a given
> >     CPU. Waiting for the extension of the percpu_irq API, this fix allows
> >     to use again the mvneta driver.
> >     
> >     Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >     Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >     Tested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >     Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> >
> >which is part of the backport-3.8 branch, so I'm a bit confused. Are
> >you sure you're using the latest backport-3.8 branch? If so, then I'll
> >do a test here to check this.
> >
> By the way, the patch IS applied to the source tree I'm compiling.
> I can see this in arch/arm/mach-mvebu/irq-armada-370-xp.c which is using 
> ARMADA_370_XP_TIMER0_PER_CPU_IRQ instead of ARMADA_370_XP_MAX_PER_CPU_IRQS

On my OpenBlocks AX3, I'm not experiencing this issue. However it runs
a slightly different kernel, it's 3.9 in which I have merged most of
the patches you find in backport-3.8.

One thing I don't know yet is if the bootloader installed on this box
is DT compatible or not, since I always append the DT to the end of my
kernels :

  cat arch/arm/boot/zImage arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dtb > zImage.dtb

Do you know if yours is compatible ? Did you append a DTB file to your
kernel ?

BTW, we have more or less similar hardware. My CPU is a 78260 and I have
4 ports, like you, so I suspect we should have the same IRQs. The original
kernel says the board is a "DB-78460-BP rev 2.0", just in case it can help,
but I suspect that your board is probably based on a similar design.

I'm seeing something odd though : when booting with the Marvell-patched
kernel provided with the AX3, here are my IRQs :

           CPU0       CPU1       
  8:          1          1   axp_irq  mv_eth
 10:          0          0   axp_irq  mv_eth
 31:          0          0   axp_irq  mv64xxx_i2c
 32:      14193          0   axp_irq  mv64xxx_i2c
 41:        182          0   axp_irq  serial
 45:          0          0   axp_irq  ehci_hcd:usb1
 46:          0          0   axp_irq  ehci_hcd:usb2
 47:          0          0   axp_irq  ehci_hcd:usb3
 55:        317          1   axp_irq  sata_mv
107:          0          0   axp_irq  axp-temp

But when booting on 3.9+patches from the Free-Electrons' team,
I have different IRQs :

           CPU0       CPU1       
 16:        348        321  armada_370_xp_irq  armada_370_xp_per_cpu_tick
 17:        198          0  armada_370_xp_irq  serial
 24:          1          0  armada_370_xp_irq  sata_mv
 25:          0          0  armada_370_xp_irq  mvneta
 27:          0          0  armada_370_xp_irq  mv64xxx_i2c
 28:         85          0  armada_370_xp_irq  mv64xxx_i2c
 30:          0          0  armada_370_xp_irq  ehci_hcd:usb1
 31:          0          0  armada_370_xp_irq  ehci_hcd:usb2
110:          2          0  armada_370_xp_irq  d0060900.xor
111:          2          0  armada_370_xp_irq  d0060900.xor
112:          2          0  armada_370_xp_irq  d00f0900.xor
113:          2          0  armada_370_xp_irq  d00f0900.xor

And precisely your failing IRQ is 25 (as I'm having here) and you said
you saw IRQ 8 somewhere. So probably something got remapped or not
completely remapped (I don't know).

Are you interested in trying my kernel+initrd ? They're easy to boot
over tftp.

Willy
