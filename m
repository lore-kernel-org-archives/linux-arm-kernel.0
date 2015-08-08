From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Aug 2015 13:42:50 +0200
Subject: [BUG, RFC] MTD Execute in Place on ARM breaks build
In-Reply-To: <55C51319.2010901@tul.cz>
References: <55C51319.2010901@tul.cz>
Message-ID: <1564596.BEQS8u7XSM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 August 2015 22:20:41 Petr Cvek wrote:
> Hello,
> 
> Configuration:
> 
> 	CONFIG_MTD_XIP=y
> 
> on PXA2xx architecture causes request of undefined macros from 
> 
> 	drivers/mtd/chipscfi_cmdset_0001.c
> 
> These macros (using ICIP and ICMR) are defined here:
> 
> 	http://lxr.free-electrons.com/source/arch/arm/mach-pxa/include/mach/mtd-xip.h#L20
> 
> register definitions for ICIP and ICMR were removed by commit:
> 	
> 	5d284e353eb11ab2e8b1c5671ba06489b0bd1e0c
> 
> Similar is for macros with OSCR (lines 23 and 24), which have different type.
> Re-adding ICIP and ICMR definition and explicit type conversion will fix the build
> and the kernel boots, but I'm not yet able to test XIP functionality (too many different
> bugs to flash over windows mobile image).
>
> My temporal fix (ugly):
> 
> #define ICIP __REG(0x40D00000)  /* Interrupt Controller IRQ Pending Register */
> #define ICMR __REG(0x40D00004)  /* Interrupt Controller Mask Register */
> ...
> #define xip_currtime()		((unsigned long) OSCR)
> #define xip_elapsed_since(x)	(signed)((((unsigned long) OSCR) - (x)) / 4)


Macros that do implicit pointer dereferences are discouraged, a better way to
write them is

	#define xip_currtime()	readl_relaxed(OSCR)

with the OSCR definition from arch/arm/mach-pxa/include/mach/regs-ost.h.

> P.S. Same macros are used on omap1 and sa1100 too.

There is a (slow) effort to move both omap1 and pxa into ARCH_MULTIPLATFORM
in the long run, and at that point we have to come up with something
better. The easiest way out would be to replace the functions with
function pointers that can be set by platform specific code.

A cleaner approach might be to replace xip_currtime() with
ktime_get_ns(), and find some other generic interface to replace
xip_irqpending. That would let us eliminate the mach/mtd-xip.h
header entirely and make mtd-xip portablel to a lot of other
platforms.

For a real multiplatform kernel, you'd also need to replace the
#ifdef CONFIG_MTD_XIP instances with a runtime conditional, but that
is less urgent for real world use cases.

	Arnd
