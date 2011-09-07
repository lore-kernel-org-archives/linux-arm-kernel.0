From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2011 22:35:46 +0200
Subject: [RFC PATCH 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <CAMPhdO927WucyKRjbj69ahD7xmu-7L-Vt1AkGe1yZsmXv4YS8A@mail.gmail.com>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<1315411158-17479-3-git-send-email-dave.martin@linaro.org>
	<CAMPhdO927WucyKRjbj69ahD7xmu-7L-Vt1AkGe1yZsmXv4YS8A@mail.gmail.com>
Message-ID: <1790084.iooACCopcX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011 09:13:38 Eric Miao wrote:
> >
> > +/*
> > + * When enough people have binutils which support -march=...+iwmmxt, this
> > + * should change to #if __LINUX_ARM_ARCH__ < 7.
> > + */
> > +#ifndef CONFIG_THUMB2_KERNEL
> >        mrc     p15, 0, r1, c2, c0, 0
> >        sub     pc, lr, r1, lsr #32             @ cpwait and return
> > +#else
> > +       isb                                     @ ISB needed instead on ARMv7
> > +       mov     pc, lr
> > +#endif
> 
> Or maybe using ARM() and THUMB() will be a better fit here?

I think it would be logical to use XSC() and PJ4() instead, as those are used
elsehere in this file. However, that doesn't work with the only binutils.

If the !THUMB code above is actually correct for v7 in ARM mode (i.e. it performs
the equivalent of an ISB), then I think we should leave it.

It does look like it's whitespace broken though.

	Arnd
