From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Nov 2010 14:12:39 -0700
Subject: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356AEEDE2@dbde02.ent.ti.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
	<1285594634-19277-2-git-send-email-s-ghorai@ti.com>
	<20100928222727.GS3117@atomide.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356AEEDE2@dbde02.ent.ti.com>
Message-ID: <20101105211238.GT9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ghorai, Sukumar <s-ghorai@ti.com> [101028 07:02]:
> Tony,
> 
> > -----Original Message-----
> > From: Ghorai, Sukumar
> > Sent: Wednesday, September 29, 2010 12:08 PM
> > To: 'Tony Lindgren'
> > Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: RE: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
> > 
> > 
> [..snip..]
> 
> > > > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> > > omap2/board-3430sdp.c
> > > > index 67b95b5..549cd62 100644
> > > > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > > > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > > > @@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
> > > >  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> > > >  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
> > > >  	omap_init_irq();
> > > > +	gpmc_init();
> > > >  	omap_gpio_init();
> > > >  }
> > > ...
> > >
> > > You can avoid adding gpmc_init() by making it a subsys_initcall().
> > > Just make sure you return early from it with if (!cpu_class_is_omap2()).
> > [Ghorai] will do
> > >
> [Ghorai] I was trying this and no success, as nand_init() get called before  subsys_initcall(gpmc_init);
> 
> 126 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board") 
> ..
> 130         .init_irq       = omap_zoom_init_irq,
> 131         .init_machine   = omap_zoom_init,
> ..
> 
> Step-(n):
> 	kernel_init() -> customize_machine() 
>              -> omap_zoom_init() -> gpmc_nand_init() -> which call gpmc
>                 functions, that's crashing, as gpmc is not initialized.
> 
> Step-(n+1):
> 	Followed by subsys_initcall(gpmc_init)
> 
> So I will incorporate the other input and will re-submit.
> [..snip..]

I don't see why you could not make gpmc_nand_init happen later?
Also, some of these calls can be moved to omap2_init_common_hw()?

Tony
