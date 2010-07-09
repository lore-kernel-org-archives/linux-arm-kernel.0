From: pieterg@gmx.com (pieterg)
Date: Fri, 9 Jul 2010 09:03:50 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007090103.14418.marek.vasut@gmail.com>
References: <201007082249.59852.pieterg@gmx.com>
	<201007090103.14418.marek.vasut@gmail.com>
Message-ID: <201007090903.50318.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 01:03:14 Marek Vasut wrote:
> Dne ?t 8. ?ervence 2010 22:49:59 pieterg napsal(a):
> > Signed-off-by: pieter <p.grimmerink@inepro.com>
> > ---
> >  arch/arm/mach-pxa/colibri-pxa300.c       |    2 +
> >  arch/arm/mach-pxa/colibri-pxa320.c       |    1 +
> >  arch/arm/mach-pxa/colibri-pxa3xx.c       |   31
> > ++++++++++++++++++++++++++++++
> >  arch/arm/mach-pxa/include/mach/colibri.h |    6 +++++
> >  4 files changed, 40 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
> > b/arch/arm/mach-pxa/colibri-pxa300.c
> > index 27f403d..3e50466 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa300.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> > @@ -229,6 +229,8 @@ void __init colibri_pxa300_init(void)
> >  				mfp_to_gpio(MFP_PIN_GPIO13));
> >  	colibri_pxa300_init_uart();
> >  	colibri_pxa300_init_i2c();
> > +	if (cpu_is_pxa310())
> > +		colibri_pxa3xx_init_touchscreen();
> >  }
> >
> >  MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
> > diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
> > b/arch/arm/mach-pxa/colibri-pxa320.c
> > index 0755087..43fadf6 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa320.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> > @@ -229,6 +229,7 @@ void __init colibri_pxa320_init(void)
> >  				mfp_to_gpio(MFP_PIN_GPIO28));
> >  	colibri_pxa320_init_uart();
> >  	colibri_pxa320_init_i2c();
> > +	colibri_pxa3xx_init_touchscreen();
> >  }
> >
> >  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
> > diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c
> > b/arch/arm/mach-pxa/colibri-pxa3xx.c
> > index 199afa2..097aef5 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa3xx.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
> > @@ -198,3 +198,34 @@ void __init colibri_pxa3xx_init_nand(void)
> >  }
> >  #endif
> >
> > +#if defined(CONFIG_INPUT_TOUCHSCREEN)
> > +
> > +#if defined(CONFIG_TOUCHSCREEN_WM97XX) || \
> > +	defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
> > +static struct platform_device colibri_ts_wm97xx_device = {
> > +	.name	= "wm97xx-ts",
> > +	.id	= -1,
> > +};
> > +#endif
> > +
> > +#if defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> > +	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> > +static struct platform_device colibri_ts_ucb1400_device = {
> > +	.name	= "ucb1400_core",
> > +	.id	= -1,
> > +};
> > +#endif
> > +
> > +void __init colibri_pxa3xx_init_touchscreen(void)
> > +{
> > +#if defined(CONFIG_TOUCHSCREEN_WM97XX) || \
> > +	defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
> > +	platform_device_register(&colibri_ts_wm97xx_device);
> > +#endif
> > +#if defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> > +	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> > +	platform_device_register(&colibri_ts_ucb1400_device);
> > +#endif
> > +}
> > +
> > +#endif
> > diff --git a/arch/arm/mach-pxa/include/mach/colibri.h
> > b/arch/arm/mach-pxa/include/mach/colibri.h
> > index 5f2ba8d..299dab9 100644
> > --- a/arch/arm/mach-pxa/include/mach/colibri.h
> > +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> > @@ -30,6 +30,12 @@ extern void colibri_pxa3xx_init_nand(void);
> >  static inline void colibri_pxa3xx_init_nand(void) {}
> >  #endif
> >
> > +#if defined(CONFIG_INPUT_TOUCHSCREEN)
> > +extern void colibri_pxa3xx_init_touchscreen(void);
> > +#else
> > +static inline void colibri_pxa3xx_init_touchscreen(void) {}
> > +#endif
> > +
> >  /* physical memory regions */
> >  #define COLIBRI_SDRAM_BASE	0xa0000000      /* SDRAM region */
>
> What will happen if both of the TS devices are selected?

That's no problem.
I actually have both configs enabled, so I can run the same kernel on the 
310 (which is using wm97 for a while now) and the 320 (which still has 
ucb1400 at the moment)

Rgds, Pieter
