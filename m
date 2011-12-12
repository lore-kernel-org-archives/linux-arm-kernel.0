From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Dec 2011 15:01:58 +0000
Subject: [PATCH v3 1/2] ARM: pl2x0/pl310: Refactor Kconfig to be more
 maintainable
In-Reply-To: <20111212140836.GY14542@n2100.arm.linux.org.uk>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-2-git-send-email-dave.martin@linaro.org>
 <20111212140836.GY14542@n2100.arm.linux.org.uk>
Message-ID: <20111212145738.GA2296@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 02:08:37PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 12, 2011 at 11:47:05AM +0000, Dave Martin wrote:
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index 724ec0f..c4c9acf 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -17,6 +17,7 @@ choice
> >  
> >  config ARCH_EXYNOS4
> >  	bool "SAMSUNG EXYNOS4"
> > +	select CACHE_L2X0
> 
> Doesn't this need to select HAVE_L2X0_L2CC as well?

Probably not -- due to a moment of madness, it looks like I somehow
mistranslated "highbank" as "exynos4".

For highbank, Rob Herring thinks that direct selection of CACHE_L2X0 is
needed [1].

I will re-roll the patch to fix this.


This may apply to other platforms too; but if they are not already
selecting CACHE_L2X0 directly, this series will make the situation no
worse.

> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 5f7f9c2..4234937 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -609,12 +609,12 @@ comment "i.MX6 family:"
> >  config SOC_IMX6Q
> >  	bool "i.MX6 Quad support"
> >  	select ARM_GIC
> > -	select CACHE_L2X0
> >  	select CPU_V7
> >  	select HAVE_ARM_SCU
> >  	select HAVE_IMX_GPC
> >  	select HAVE_IMX_MMDC
> >  	select HAVE_IMX_SRC
> > +	select HAVE_L2X0_L2CC
> 
> Do you know enough about this to make L2 cache support optional on this SoC?

No.  But Shawn Guo suggested that this correct [2]
 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 5034147..0358159 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -44,6 +44,7 @@ config ARCH_OMAP4
> >  	select CPU_V7
> >  	select ARM_GIC
> >  	select LOCAL_TIMERS if SMP
> > +	select CACHE_L2X0
> 
> HAVE_L2X0_L2CC ?

Rob Herring thinks not [1]

Cheers
---Dave


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
