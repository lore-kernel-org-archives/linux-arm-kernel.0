From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Jul 2011 11:25:50 -0400 (EDT)
Subject: [PATCH 08/37] ARM: mach-omap2: remove mach/memory.h
In-Reply-To: <201107071708.36668.arnd@arndb.de>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
	<1309923021-23487-8-git-send-email-nicolas.pitre@linaro.org>
	<201107071708.36668.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1107071113410.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Arnd Bergmann wrote:

> On Wednesday 06 July 2011, Nicolas Pitre wrote:
> > -/*
> > - * Physical DRAM offset.
> > - */
> > -#if defined(CONFIG_ARCH_OMAP1)
> > -#error "OMAP1 should not be including this"
> > -#else
> > -#define PLAT_PHYS_OFFSET               UL(0x80000000)
> > -#endif
> > -
> > -#endif
> 
> This breaks if you disable ARM_PATCH_PHYS_VIRT and don't know
> enter the correct PHYS_OFFSET in Kconfig, right?

Right.  However the plan is to make ARM_PATCH_PHYS_VIRT the default and 
you should really have a good reason to disable it (i.e. you must know 
what you're doing).

> I wonder if it's worth adding defaults for CONFIG_PHYS_OFFSET
> based on the platform, like
> 
> config PHYS_OFFSET
> 	depends on !ARM_PATCH_PHYS_VIRT && NO_MACH_MEMORY_H
> 	default 0x80000000 if ARCH_OMAP2 || ARCH_PNX4008 || ARCH_NETX || ARCH_LPC32XX
> 	default 0xa0000000 if ARCH_IOP32X
> 	default 0x10000000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
> 	default 0x00000000

Maybe, however this is part of the board specific info we wish to move 
out of the tree.  Gathering that info for different boards close 
together is also a potential merge conflict spot.

The only reason why you might want to use a build time PHYS_OFFSET at 
that point is for running the kernel XIP in ROM, or if you have very 
special requirements.  And for that you really must know what you're 
doing.  Some people have indicated that CONFIG_XIP_KERNEL is still 
useful for them.  So I left the ability there to preserve some 
flexibility, otherwise I probably would have made ARM_PATCH_PHYS_VIRT 
unconditional in that case.


Nicolas
