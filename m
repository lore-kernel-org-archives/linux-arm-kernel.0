From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Nov 2010 23:06:52 +0000
Subject: arm smp support patch
In-Reply-To: <4CDC63A9.9090606@codeaurora.org>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
	<20101111044125.GA5850@mvista.com>
	<52622063180ba1627bf98811e4f56a05.squirrel@www.concentris-systems.com>
	<4CDC63A9.9090606@codeaurora.org>
Message-ID: <20101111230652.GC23785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 01:44:09PM -0800, Abhijeet Dharmapurikar wrote:
> Scott Valentine wrote:
>>> On Tue, Nov 09, 2010 at 01:33:20PM -1000, Scott Valentine wrote:
>>>> On arm multi-core platforms that have a gic, the secondary cores fail to
>>>> wake if they are booted in WFI mode, as the gic_dist_init disables all
>>>> interrupts including IPI. I've included a simple patch to the
>>>> gic_dist_init function that enables interrupts 0-15 on SMP enabled
>>>> systems. This patch was made against linux-2.6-HEAD-151f52f.
>>>>
>>>>
>>>> diff -uNr a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>>>> --- a/arch/arm/common/gic.c     2010-11-05 15:57:04.000000000 -1000
>>>> +++ b/arch/arm/common/gic.c     2010-11-09 13:08:33.000000000 -1000
>>>> @@ -262,6 +262,13 @@
>>>>         for (i = 0; i < max_irq; i += 32)
>>>>                 writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4
>>>> /
>>>> 32);
>>>>
>>>> +#ifdef CONFIG_SMP
>>>> +       /*
>>>> +        * Enable IPI interrupts on SMP systems so we can wake secondary
>>>> cores
>>>> +        */
>>>> +       writel(0x0000ffff, base + GIC_DIST_ENABLE_SET);
>
> Scott, you might want to try doing this first thing in gic_cpu_init.  
> That seems to be the right place since the ENABLE_SET is banked per
> cpu.

Secondary CPUs are placed into WFI mode by whatever preceeds the kernel
as part of the boot protocol, and it is expected that they are sent some
kind of interrupt to wake them from WFI mode.  While they are in this
state, they have no knowledge of the kernel, so they haven't run any
kernel code.

The GIC TRM does imply that these bits are banked - the upper 16 bits
are used for PPIs (private peripheral interrupts, private to the CPU)
while the lower 16 bits are used for the SGI (software generated
interrupts.)  According to the online docs, ARM IHI 0048A (Generic
Interrupt Controller Architecture Specification) it is _implementation
defined_ whether the SGI enable bits are implemented.

If your pre-kernel boot software places your secondary CPUs into WFI
mode with all sources of software interrupts disabled, then it's fairly
clear that there's no way to wake them from WFI mode via software
generated GIC interrupts.

The only way to do it is to route a real hardware IRQ to your desired
secondary CPU, and provoke the hardware into generating an IRQ.  That's
hardly a good way to go about bringing secondary CPUs online.

It seems that we have one of the first implementations which has enable
register bits provided for the SGIs.  As the enable register bits are
banked on a per-CPU basis, there's nothing that the boot CPU can do to
set those enable bits - the only thing that can enable those is the
pre-kernel boot software.

However, we also need to ensure that the kernel doesn't clear those
bits.  So:

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index ada6359..a333811 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -257,9 +257,10 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 		writel(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
 
 	/*
-	 * Disable all interrupts.
+	 * Disable all interrupts, except the software generated interrupts.
 	 */
-	for (i = 0; i < max_irq; i += 32)
+	writel(0xffff0000, base + GIC_DIST_ENABLE_CLEAR);
+	for (i = 32; i < max_irq; i += 32)
 		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
 
 	/*

and we need to have the boot software on this platform to set the
enable bits.
