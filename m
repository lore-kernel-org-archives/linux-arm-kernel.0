From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 8 Sep 2011 16:58:41 +0800
Subject: [RFC PATCH 3/3] ARM: pxa/pj4: Port problematic pj4 support
	code to v7/Thumb-2
In-Reply-To: <52624752.OdLlzNdq0G@wuerfel>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<1315411158-17479-4-git-send-email-dave.martin@linaro.org>
	<CAMPhdO-wW5yfrpey7QK-F4M6t5L9zVyO5p8Vk_PFtT7aZP1hbQ@mail.gmail.com>
	<52624752.OdLlzNdq0G@wuerfel>
Message-ID: <1315472321.1985.29.camel@Lily>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-07 at 13:27 -0700, Arnd Bergmann wrote:
> On Wednesday 07 September 2011 09:18:15 Eric Miao wrote:
> > > diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
> > > index a4b1b07..5117d9d 100644
> > > --- a/arch/arm/kernel/pj4-cp0.c
> > > +++ b/arch/arm/kernel/pj4-cp0.c
> > > @@ -66,9 +66,13 @@ static void __init pj4_cp_access_write(u32 value)
> > >
> > >        __asm__ __volatile__ (
> > >                "mcr    p15, 0, %1, c1, c0, 2\n\t"
> > > +#ifdef __LINUX_ARM_ARCH__ >= 7
> > > +               "isb\n\t"
> > > +#else
> > >                "mrc    p15, 0, %0, c1, c0, 2\n\t"
> > >                "mov    %0, %0\n\t"
> > >                "sub    pc, pc, #4\n\t"
> > > +#endif
> > 
> > Haojian,
> > 
> > Could you check internally if isb() will work here as PJ4 is both v6/v7
> > compatible, and if it's in v7 mode, I guess isb() can be safely used here?
> 
PJ4 v6 mode is abandoned in real usage. So we only need to cover v7
mode.

> I thought we only support pj4 in v7 mode in Linux anyway.
> 
> 	Arnd
