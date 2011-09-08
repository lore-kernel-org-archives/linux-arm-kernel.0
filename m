From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 8 Sep 2011 09:58:00 +0100
Subject: [RFC PATCH 2/3] ARM: iwmmxt: Port problematic iwmmxt support
	code to v7/Thumb-2
In-Reply-To: <1790084.iooACCopcX@wuerfel>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<1315411158-17479-3-git-send-email-dave.martin@linaro.org>
	<CAMPhdO927WucyKRjbj69ahD7xmu-7L-Vt1AkGe1yZsmXv4YS8A@mail.gmail.com>
	<1790084.iooACCopcX@wuerfel>
Message-ID: <20110908085800.GB2070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 10:35:46PM +0200, Arnd Bergmann wrote:
> On Wednesday 07 September 2011 09:13:38 Eric Miao wrote:
> > >
> > > +/*
> > > + * When enough people have binutils which support -march=...+iwmmxt, this
> > > + * should change to #if __LINUX_ARM_ARCH__ < 7.
> > > + */
> > > +#ifndef CONFIG_THUMB2_KERNEL
> > >        mrc     p15, 0, r1, c2, c0, 0
> > >        sub     pc, lr, r1, lsr #32             @ cpwait and return
> > > +#else
> > > +       isb                                     @ ISB needed instead on ARMv7
> > > +       mov     pc, lr
> > > +#endif
> > 
> > Or maybe using ARM() and THUMB() will be a better fit here?
> 
> I think it would be logical to use XSC() and PJ4() instead, as those are used
> elsehere in this file. However, that doesn't work with the only binutils.

I take pj4 and older platforms can never be built in the same kernel?
Otherwise, this approach is totally broken anyway-- we'll generate code
which won't run on some of the kernel's supported platforms.

> If the !THUMB code above is actually correct for v7 in ARM mode (i.e. it performs
> the equivalent of an ISB), then I think we should leave it.

With the proposed change to use cc-option in the Makefile,
we have the option of using the v7 code whenever binutils supports
it, and printing a warning otherwise.

> It does look like it's whitespace broken though.

I'll double-check that.

Cheers
---Dave
