From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 22:22:48 +0000
Subject: [PATCH v3 1/2] ARM: pl2x0/pl310: Refactor Kconfig to be more
 maintainable
In-Reply-To: <20111212165323.GF2296@linaro.org>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-2-git-send-email-dave.martin@linaro.org>
 <20111212140836.GY14542@n2100.arm.linux.org.uk>
 <20111212145738.GA2296@linaro.org>
 <20111212160437.GC20178@n2100.arm.linux.org.uk>
 <20111212165323.GF2296@linaro.org>
Message-ID: <20111212222248.GH20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 04:53:23PM +0000, Dave Martin wrote:
> On Mon, Dec 12, 2011 at 04:04:37PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 12, 2011 at 03:01:58PM +0000, Dave Martin wrote:
> > > On Mon, Dec 12, 2011 at 02:08:37PM +0000, Russell King - ARM Linux wrote:
> > > > On Mon, Dec 12, 2011 at 11:47:05AM +0000, Dave Martin wrote:
> > > > > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > > > > index 724ec0f..c4c9acf 100644
> > > > > --- a/arch/arm/mach-exynos/Kconfig
> > > > > +++ b/arch/arm/mach-exynos/Kconfig
> > > > > @@ -17,6 +17,7 @@ choice
> > > > >  
> > > > >  config ARCH_EXYNOS4
> > > > >  	bool "SAMSUNG EXYNOS4"
> > > > > +	select CACHE_L2X0
> > > > 
> > > > Doesn't this need to select HAVE_L2X0_L2CC as well?
> > > 
> > > Probably not -- due to a moment of madness, it looks like I somehow
> > > mistranslated "highbank" as "exynos4".
> > 
> > Well, you have CACHE_L2X0 depending on HAVE_L2X0_L2CC.  Selecting
> > CACHE_L2X0 without HAVE_L2X0_L2CC being selected will make Kconfig
> > produce a message about unmet dependencies.
> > 
> > The other solution to this is:
> > 
> > config CACHE_L2X0
> > 	bool "Enable the L2x0 outer cache controller" if HAVE_L2X0_L2CC
> > 
> > and I think that's more in keeping with what Rob mentioned in his
> > message - it makes this a non-user selectable option unless
> > HAVE_L2X0_L2CC is enabled.
> > 
> > However, in this case it would be more sensible to name the option
> > 'MIGHT_HAVE_CACHE_L2X0'.  (btw, please name the option after the
> > option it relates to.)
> 
> We still want CACHE_L2X0 to default to y even in the
> MIGHT_HAVE_CACHE_L2X0 case, since it is not usually desirable to turn it
> off except for debugging purposes.
> 
> Would the correct thing be:
> 
> config CACHE_L2X0
> 	bool "Enable the L2x0 outer cache controller" if MIGHT_HAVE_CACHE_L2X0
> 	default MIGHT_HAVE_CACHE_L2X0
> 
> That way, select CACHE_L2X0=y, MIGHT_HAVE_CACHE_L2X0=y and both=y will
> all produce sensible results, if I understand correctly how this works.
> 
> ...or is there a better way?

I think that's a good compromise (and improvement).
