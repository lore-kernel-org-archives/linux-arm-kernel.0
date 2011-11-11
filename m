From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Nov 2011 15:15:15 +0000
Subject: [PATCH] fix compilation breakage in entry-armv.S
In-Reply-To: <Pine.LNX.4.64.1111081258240.10851@axis700.grange>
References: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
 <20111108114050.GC12913@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1111081258240.10851@axis700.grange>
Message-ID: <20111111151515.GA3099@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 01:03:02PM +0100, Guennadi Liakhovetski wrote:
> On Tue, 8 Nov 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Nov 08, 2011 at 12:36:36PM +0100, Guennadi Liakhovetski wrote:
> > > Compilation of Linus' tree of today without THUMB support for V7 machines 
> > > breaks:
> > > 
> > > linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
> > > linux-2.6/arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
> > > linux-2.6/arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
> > > make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > > 
> > > Fix this by adding a check for CONFIG_ARM_THUMB.
> > 
> > This still looks wrong.  The code for '2' and '3' is included when:
> > 
> > #if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
> > 
> > is true - so the condition on including it in the exception tables should
> > be the same as that.
> 
> Yes, I saw those, but, aren't they superfluous? Let's see:
> 
> arch/arm/mm/Kconfig:
> 
> config CPU_V7
> 	...
> 	select CPU_32v7
> 
> arch/arm/Makefile:
> 
> arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
> 
> So, looks like CPU_V7 implies __LINUX_ARM_ARCH__=7? Ok, I picked up the 
> wrong pair, so, should this be enough:
> 
> #if CONFIG_ARM_THUMB && CONFIG_CPU_V7
> 
> and the original condition, where the labels are defined, that you 
> quoted, can be reduced too?

No-- although the reason why is a bit confusing.

In arch/arm/Makefile, __LINUX_ARM_ARCH__ will be repeatedly redefined
for each CPU supported by the kernel.  This means that the value
actuslly used will be the earliest architecture supported by all
supported CPUs (i.e., it represents the architecture subset supported
by all enabled CPUs).  This happens because of the way the definitions
of __LIUNX_ARM_ARCH__ are ordered in the Makefile.

The affected code needs to be enabled whenever an ARMv7 CPU is supported
if support for Thumb userspace binaries is enabled, even if v6 CPUs
are also supported in the same kernel (in which case __LINUX_ARM_ARCH__
has the value 6, and CONFIG_CPU_V6 and CONFIG_CPU_V7 will both be
defined).

However, some cheeky assumptions are made so that we can restore the
assembler's target architecture after temporarily changing it -- so
although __LINUX_ARM_ARCH__ >= 6 is not strictly necessary (since
building pre-v6 and v7 CPUs the the same kernel is not allowed), I
kept it there in order to avoid unpleasant surprises.  Unfortunately,
the assembler doesn't allow its target architecture to be restored
reliably after temporarily overriding it.

So I think the affected #ifdef does need be:

	CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7


Arnd Bergmann had previously suggested the same change, but the
discussion went stale, and it looks like I never made an actual
patch.  Looks like my bad...

Can you update your patch and repost?


Thanks
---Dave
