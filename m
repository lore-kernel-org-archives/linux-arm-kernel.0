From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Dec 2011 18:30:31 +0000
Subject: [PATCH v4 REPOST 3/5] omap4: Unconditionally require l2x0 L2
 cache controller support
In-Reply-To: <20111214181425.GB32251@atomide.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-4-git-send-email-dave.martin@linaro.org>
 <20111214181425.GB32251@atomide.com>
Message-ID: <20111214183030.GB9331@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 10:14:25AM -0800, Tony Lindgren wrote:
> * Dave Martin <dave.martin@linaro.org> [111214 03:08]:
> > If running in the Normal World on a TrustZone-enabled SoC, Linux
> > does not have complete control over the L2 cache controller
> > configuration.  The kernel cannot work reliably on such platforms
> > without the l2x0 cache support code built in.
> 
> There are HS and GP omaps (High Security and General Purpose).
> GP omaps do have full control of the L2. Also HS omaps most likely
> provide control over enabling and disabling L2 depending how the
> secure code is implemented.
> 
> BTW, the real problem is that because the secure code is implemented
> in various ways, we don't really have any handling for it in Linux.
> 
> The SMI instruction numbers don't seem to be standardized at all,
> and can mean different things on different boards, even different
> board versions :(
> 
> Sounds like devicetree is the only safe way to deal with the L2
> control options.
> 
> Regards,
> 
> Tony
> 
>  
> > This patch unconditionally enables l2x0 support for the OMAP4 SoCs.
> > 
> > Thanks to Rob Herring for this suggestion. [1]
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
> > ---
> >  arch/arm/mach-omap2/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index bb1b670..94e568a 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -41,11 +41,11 @@ config ARCH_OMAP4
> >  	bool "TI OMAP4"
> >  	default y
> >  	depends on ARCH_OMAP2PLUS
> > +	select CACHE_L2X0
> >  	select CPU_V7
> >  	select ARM_GIC
> >  	select HAVE_SMP
> >  	select LOCAL_TIMERS if SMP
> > -	select MIGHT_HAVE_CACHE_L2X0
> >  	select PL310_ERRATA_588369
> >  	select PL310_ERRATA_727915
> >  	select ARM_ERRATA_720789
> > -- 
> > 1.7.4.1
> > 

To clarify, are you suggesting we retain this patch, or not?

(If we only know what l2x0 support will be needed once the dts is
parsed at runtime, there could be an argument for keeping the
select CACHE_L2X0 here -- unless we have specific kconfigs for
the different security variants of omap.)

Cheers
---Dave
