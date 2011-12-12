From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 16:04:37 +0000
Subject: [PATCH v3 1/2] ARM: pl2x0/pl310: Refactor Kconfig to be more
 maintainable
In-Reply-To: <20111212145738.GA2296@linaro.org>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-2-git-send-email-dave.martin@linaro.org>
 <20111212140836.GY14542@n2100.arm.linux.org.uk>
 <20111212145738.GA2296@linaro.org>
Message-ID: <20111212160437.GC20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:01:58PM +0000, Dave Martin wrote:
> On Mon, Dec 12, 2011 at 02:08:37PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 12, 2011 at 11:47:05AM +0000, Dave Martin wrote:
> > > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > > index 724ec0f..c4c9acf 100644
> > > --- a/arch/arm/mach-exynos/Kconfig
> > > +++ b/arch/arm/mach-exynos/Kconfig
> > > @@ -17,6 +17,7 @@ choice
> > >  
> > >  config ARCH_EXYNOS4
> > >  	bool "SAMSUNG EXYNOS4"
> > > +	select CACHE_L2X0
> > 
> > Doesn't this need to select HAVE_L2X0_L2CC as well?
> 
> Probably not -- due to a moment of madness, it looks like I somehow
> mistranslated "highbank" as "exynos4".

Well, you have CACHE_L2X0 depending on HAVE_L2X0_L2CC.  Selecting
CACHE_L2X0 without HAVE_L2X0_L2CC being selected will make Kconfig
produce a message about unmet dependencies.

The other solution to this is:

config CACHE_L2X0
	bool "Enable the L2x0 outer cache controller" if HAVE_L2X0_L2CC

and I think that's more in keeping with what Rob mentioned in his
message - it makes this a non-user selectable option unless
HAVE_L2X0_L2CC is enabled.

However, in this case it would be more sensible to name the option
'MIGHT_HAVE_CACHE_L2X0'.  (btw, please name the option after the
option it relates to.)

> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 5f7f9c2..4234937 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -609,12 +609,12 @@ comment "i.MX6 family:"
> > >  config SOC_IMX6Q
> > >  	bool "i.MX6 Quad support"
> > >  	select ARM_GIC
> > > -	select CACHE_L2X0
> > >  	select CPU_V7
> > >  	select HAVE_ARM_SCU
> > >  	select HAVE_IMX_GPC
> > >  	select HAVE_IMX_MMDC
> > >  	select HAVE_IMX_SRC
> > > +	select HAVE_L2X0_L2CC
> > 
> > Do you know enough about this to make L2 cache support optional on this SoC?
> 
> No.  But Shawn Guo suggested that this correct [2]

Ok.
