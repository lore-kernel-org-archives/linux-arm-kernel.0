From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 8 Nov 2011 13:03:02 +0100 (CET)
Subject: [PATCH] fix compilation breakage in entry-armv.S
In-Reply-To: <20111108114050.GC12913@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
 <20111108114050.GC12913@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1111081258240.10851@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Nov 2011, Russell King - ARM Linux wrote:

> On Tue, Nov 08, 2011 at 12:36:36PM +0100, Guennadi Liakhovetski wrote:
> > Compilation of Linus' tree of today without THUMB support for V7 machines 
> > breaks:
> > 
> > linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
> > linux-2.6/arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
> > linux-2.6/arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
> > make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > 
> > Fix this by adding a check for CONFIG_ARM_THUMB.
> 
> This still looks wrong.  The code for '2' and '3' is included when:
> 
> #if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
> 
> is true - so the condition on including it in the exception tables should
> be the same as that.

Yes, I saw those, but, aren't they superfluous? Let's see:

arch/arm/mm/Kconfig:

config CPU_V7
	...
	select CPU_32v7

arch/arm/Makefile:

arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)

So, looks like CPU_V7 implies __LINUX_ARM_ARCH__=7? Ok, I picked up the 
wrong pair, so, should this be enough:

#if CONFIG_ARM_THUMB && CONFIG_CPU_V7

and the original condition, where the labels are defined, that you 
quoted, can be reduced too?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
