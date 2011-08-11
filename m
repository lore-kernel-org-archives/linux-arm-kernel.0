From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 11 Aug 2011 14:04:49 +0100
Subject: [RFC PATCH 5/5] ARM: entry: Fix Thumb-2 undef handling for
	multi-CPU kernels
In-Reply-To: <1312977352.7800.43.camel@computer2>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
	<1312971223-28165-6-git-send-email-dave.martin@linaro.org>
	<1312977352.7800.43.camel@computer2>
Message-ID: <20110811130449.GA2336@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 12:55:52PM +0100, Tixy wrote:
> On Wed, 2011-08-10 at 11:13 +0100, Dave Martin wrote:
> > +#if __LINUX_ARM_ARCH__ < 7
> > +/* If the target CPU may not be Thumb-2-capable, a run-time check is needed: */
> > +#define NEED_CPU_ARCHITECTURE
> > +	ldr	r5, .LCcpu_architecture
> > +	ldr	r5, [r5]
> > +	cmp	r5, #CPU_ARCH_ARMv7
> > +	blo	__und_usr_unknown
> > +/*
> > + * The following code won't get run unless the running CPU really is v7, so
> > + * coding round the lack of ldrht on older arches is pointless.  Temporarily
> > + * override the assembler target arch with the minimum required instead:
> > + */
> > +	.arch	armv6t2
> > +#endif
> >  2:
> >   ARM(	ldrht	r5, [r4], #2	)
> >   THUMB(	ldrht	r5, [r4]	)
> > @@ -449,7 +470,16 @@ __und_usr:
> >  3:	ldrht	r0, [r4]
> >  	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
> >  	orr	r0, r0, r5, lsl #16
> > +
> > +#if __LINUX_ARM_ARCH__ < 7
> > +/* If the target arch was overridden, change it back: */
> > +#ifdef CONFIG_CPU_32v6K
> > +	.arch	armv6k
> >  #else
> > +	.arch	armv6
> > +#endif
> 
> Are we confident that there will be no other v6 architectures supported
> in future? Looks like a bit of a hazard otherwise.

More or less.  armv6Z is theoretically possible, but highly unlikely to
affect this file.  armv6T2 is only rarely deployed and has not gone
upstream.  Neither __LINUX_ARM_ARCH__ nor cpu_architecture has a value
corresponding to this architecture.  Without CONFIG_THUMB2_KERNEL, I
think assembling entry-armv.S will just work as-is; with
CONFIG_THUMB2_KERNEL there would be build failures, giving someone an
opportunity to fix it.  Since v6T2 would only happen in some specialised
niches anyway, it's less likely that someone would be building this into
a combined kernel, even if it were supported.

An alternative route is to change arch/arm/Makefile to pass a command-line
#define for the "real" architecture so we can restore to it.  My attempts
to do that seemed at least as fragile, though...

> 
> Looking at the assembler manual, MIPS and PowerPC have push/pop
> operations for changing things like arch settings, pity ARM doesn't.

There have been discussions with people (i.e., me) advocating a
similar option for the assembler on ARM.  I wasn't aware that it actually
existed for some arches... interesting.  My searches didn't find these.

Unfortunately, those save/restore features seem have been done in a
somewhat gross, target-specific way (maybe inherited from those targets'
native assemblers) where it could profitably have been made generic...
Either way, even if it gets implemented it will be some time before
everyone using gas has that feature, so we can't really rely on it in
ARM-land.

Cheers
---Dave
