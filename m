From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 31 Dec 2011 17:21:49 +0800
Subject: [PATCH] ARM: imx6: fix v7_invalidate_l1 by adding I-Cache
 invalidation
In-Reply-To: <CAB4PhKexxJM+rWhgdQfu9vB16KVT6QpN1ye4kH88pNiLnEyL+Q@mail.gmail.com>
References: <1325237200-10610-1-git-send-email-shawn.guo@linaro.org>
 <CAB4PhKexxJM+rWhgdQfu9vB16KVT6QpN1ye4kH88pNiLnEyL+Q@mail.gmail.com>
Message-ID: <20111231092148.GG12182@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 06:47:05PM +0800, Jason Liu wrote:
> 2011/12/30 Shawn Guo <shawn.guo@linaro.org>:
> > The recent suspend/resume and reset testing on imx6q discovers that
> > not only D-Cache but also I-Cache has random data and validity when
> > the core comes out of a power recycle.
> >
> > This patch adds I-Cache invalidation into v7_invalidate_l1 to make
> > sure both D-Cache and I-Cache invalidated on power-up.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > ?arch/arm/mach-imx/head-v7.S | ? ?1 +
> > ?1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> > index 6229efb..c844112 100644
> > --- a/arch/arm/mach-imx/head-v7.S
> > +++ b/arch/arm/mach-imx/head-v7.S
> > @@ -33,6 +33,7 @@
> > ?*/
> > ?ENTRY(v7_invalidate_l1)
> > ? ? ? ?mov ? ? r0, #0
> > + ? ? ? mcr ? ? p15, 0, r0, c7, c5, 0 ? @ invalidate I cache
> > ? ? ? ?mcr ? ? p15, 2, r0, c0, c0, 0
> > ? ? ? ?mrc ? ? p15, 1, r0, c0, c0, 0
> 
> I'm wondering why arm linux init core code does not try to invalidate
> i/d-cache before enable it?
> As a formal procedure, we need invalidate i/d cache before actually
> enable it. right?

I was ever told by Russell that ARM_ARM permits that cache holds random
data out of a power-up.  But I'm not sure if the validity mark can also
be randomized.  If it can, this issue may need to be addressed in common
place, otherwise it's really just a imx6q specific problem.

Regards,
Shawn

> 
> I looked the code: arch/arm/mm/proc-v7.S:
> 
> #ifdef HARVARD_CACHE
>         mcr     p15, 0, r10, c7, c5, 0          @ I+BTB cache invalidate
> #endif
>         dsb
> #ifdef CONFIG_MMU
>         mcr     p15, 0, r10, c8, c7, 0          @ invalidate I + D TLBs
>         mcr     p15, 0, r10, c2, c0, 2          @ TTB control register
>         ALT_SMP(orr     r4, r4, #TTB_FLAGS_SMP)
>         ALT_UP(orr      r4, r4, #TTB_FLAGS_UP)
>         mcr     p15, 0, r4, c2, c0, 1           @ load TTB1
> 
> It seems that it will try to invalidate when HARVARD_CACHE define. But
> HARVARD_CACHE
> only defined in v6, why?
> 
