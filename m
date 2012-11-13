From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Nov 2012 13:55:03 +0900
Subject: [PATCH 1/7] ARM: EXYNOS: add support for EXYNOS5440 SoC
In-Reply-To: <5432090.dpMO1fymRx@flatron>
References: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
 <1351274153-3120-2-git-send-email-kgene.kim@samsung.com>
 <5432090.dpMO1fymRx@flatron>
Message-ID: <01a201cdc15b$0b385bc0$21a91340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kgene,
> 
Hi,

[...]


> >  void exynos5_restart(char mode, const char *cmd)
> >  {
> > -	__raw_writel(0x1, EXYNOS_SWRESET);
> > +	u32 val;
> > +	void __iomem *addr;
> > +
> > +	if (of_machine_is_compatible("samsung,exynos5250")) {
> > +		val = 0x1;
> > +		addr = EXYNOS_SWRESET;
> > +	} else if (of_machine_is_compatible("samsung,exynos5440")) {
> > +		val = (0x10 << 20) | (0x1 << 16);
> > +		addr = EXYNOS5440_SWRESET;
> > +	} else {
> > +		pr_err("%s: cannot support non-DT\n", __func__);
> > +		return;
> > +	}
> 
> Why soc_is_XXX isn't used here? It should be faster and more correct than
> of_machine_is_compatible.
> 
Well...let me check again.

> I can imagine the same board available with two different SoCs, for which
> of_machine_is_compatible wouldn't work.
> 
I don't think so. Basically, the restart() depends on SoC not board in
addition, each board is supposed to have its own SoC not different SoCs.

[...]

> > -static char const *exynos5250_dt_compat[] __initdata = {
> > +static char const *exynos5_dt_compat[] __initdata = {
> >  	"samsung,exynos5250",
> > +	"samsung,exynos5440",
> >  	NULL
> >  };
> 
> Something doesn't seem right here. How do you distinguish between
> MACH_EXYNOS5_DT and MACH_EXYNOS5440_DT if both have the same compatible
> matches?
> 
I updated to support MACH_EXYNOS5440_DT with MACH_EXYNOS5_DT.

> Those machines doesn't seem to share much definitions, so maybe a separate
> mach-exynos5440-dt.c file would be a better approach?
> 
See my updated patch.

> > @@ -96,11 +100,23 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5
> > (Flattened Device Tree)") /* Maintainer: Kukjin Kim
> > <kgene.kim@samsung.com> */
> >  	.init_irq	= exynos5_init_irq,
> >  	.smp		= smp_ops(exynos_smp_ops),
> > -	.map_io		= exynos5250_dt_map_io,
> > +	.map_io		= exynos5_dt_map_io,
> >  	.handle_irq	= gic_handle_irq,
> > -	.init_machine	= exynos5250_dt_machine_init,
> > +	.init_machine	= exynos5_dt_machine_init,
> >  	.init_late	= exynos_init_late,
> >  	.timer		= &exynos4_timer,
> > -	.dt_compat	= exynos5250_dt_compat,
> > +	.dt_compat	= exynos5_dt_compat,
> > +	.restart        = exynos5_restart,
> > +MACHINE_END
> > +
> > +DT_MACHINE_START(EXYNOS5440_DT, "SAMSUNG EXYNOS5440 (Flattened Device
> > Tree)") +	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
> > +	.init_irq	= exynos5_init_irq,
> > +	.smp		= smp_ops(exynos_smp_ops),
> > +	.map_io		= exynos5_dt_map_io,
> > +	.handle_irq	= gic_handle_irq,
> > +	.init_machine	= exynos5_dt_machine_init,
> > +	.timer		= &exynos5_timer,
> > +	.dt_compat	= exynos5_dt_compat,
> >  	.restart        = exynos5_restart,
> 
> Since restarts for both differ, why not to add separate exynos5440 restart
> and use it here?
> 
As I said above, I don't think so.

[...]

> > @@ -487,6 +489,9 @@ static void __init exynos4_timer_init(void)
> >  		exynos4x12_clk_init();
> >  #endif
> >
> > +	if (of_machine_is_compatible("samsung,exynos5440"))
> > +		arch_timer_of_register();
> > +
> 
> Why exynos4_timer_init is being touched here, if exynos5_timer_init is
> being added?
> 
> I would rather keep exynos4_timer (which is used for all Exynos4 SoCs
> and for Exynos5250) as is and define new exynos5250_timer if it needs
> completely different initialization...
> 
See updated patch.

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
