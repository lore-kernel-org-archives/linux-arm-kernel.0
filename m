From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Tue, 09 Sep 2014 15:40:32 -0300
Subject: [PATCH 2/3] [media] s5p-jpeg: Fix compilation with COMPILE_TEST
In-Reply-To: <60097822.tu6OncvLxQ@wuerfel>
References: <20140909124306.2d5a0d76@canb.auug.org.au>
 <540F15B2.3000902@samsung.com> <20140909120936.527bd852.m.chehab@samsung.com>
 <60097822.tu6OncvLxQ@wuerfel>
Message-ID: <20140909154032.01625bb0.m.chehab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 09 Sep 2014 19:54:19 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

> On Tuesday 09 September 2014 12:09:36 Mauro Carvalho Chehab wrote:
> > -exynos4.c
> > > > index e51c078360f5..01eeacf28843 100644
> > > > --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> > > > +++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> > > > @@ -23,7 +23,9 @@ void exynos4_jpeg_sw_reset(void __iomem *base)
> > > >     reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
> > > >     writel(reg & ~EXYNOS4_SOFT_RESET_HI, base + EXYNOS4_JPEG_CNTL_REG);
> > > >  
> > > > +#ifndef CONFIG_COMPILE_TEST
> > > >     ndelay(100000);
> > > > +#endif
> > > 
> > > Wouldn't be a better fix to replace ndelay(100000); with udelay(100),
> > > rather than sticking in a not so pretty #ifndef ?
> > 
> > Works for me. I'll submit a new version.
> 
> New version looks good to me. On a more general level, I would argue
> that we should not disable code based on COMPILE_TEST. The typical
> use of this symbol is to make it possible to compile more code, not
> to change the behavior of code on machines that were able to build
> it already.

Yeah, agreed as a general concept. In this case, however, it were
causing a compilation breakage on X86 (as it generates a non-existing
_bad_ndelay() symbol, if the time is bigger than 20000). See
include/asm-generic/delay.h.

Btw, I suspect that the only reason why ndelay(100000) causes a
compilation breakage is to avoid a big number, as the maximum limit
check ndelay() code (20000) at asm-generic is identical to the one
for udelay(). So, for ndelay, it means 20us, while, for udelay,
it means 20ms. Even so, both calls the very same implementation code.

Perhaps we should fix it, for both to accept a maximum time of 20ms.

Regards,
Mauro
