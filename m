From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Mar 2013 18:59:53 +0800
Subject: [PATCH 04/10] ARM: tegra: pm: add platform suspend support
In-Reply-To: <51363D51.6000908@wwwdotorg.org>
References: <1362397218-5675-1-git-send-email-josephl@nvidia.com>
 <51363D51.6000908@wwwdotorg.org>
Message-ID: <1362653993.1890.13.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-06 at 02:45 +0800, Stephen Warren wrote:
> On 03/04/2013 04:40 AM, Joseph Lo wrote:
> > Adding suspend to ram support for Tegra platform. There are three suspend
> 
> nit: s/ram/RAM/
> 
> > mode for Tegra. The difference were below.
> 
> Does this patch work for all 3 upstream Tegras, or just Tegra20 (or 20+30?).
> 
Only for Tegra20 and 30 now. The Tegra114's support need to wait for cpu
suspend function first.

> > diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> 
> > +	tegra_init_suspend();
> 
> That call isn't ifdef'd on anything ...
> 
Will fix.

> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> > +static void tegra_suspend_enter_lp2(void)
> > +{
> > +	tegra_set_cpu_in_lp2(0);
> > +}
> > +
> > +static void tegra_suspend_exit_lp2(void)
> > +{
> > +	tegra_clear_cpu_in_lp2(0);
> > +}
> 
> Are those two functions going to get larger? If not, why not just call
> tegra_{set,clear}_cpu_in_lp2() from tegra_suspend_enter()?
> 
> Note: I realized that the LP0/LP1 functions might be larger, and feel
> free to make them separate functions when they're implemented, but if
> those two functions specifically are always going to be a single line,
> then there's little point in separating them out, is there?
> 
No, just like you said for LP2 suspend it only just need to call
tegra_{set,clear}_cpu_in_lp2(). So I will follow your suggestion.
Thanks.

> > +void __init tegra_init_suspend(void)
> ...
> >  #endif
> 
> ... but this function is only implemented inside an ifdef ...
> 
> > diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
> 
> > +void tegra_init_suspend(void);
> 
> ... and no dummy inline is provided if the ifdef isn't defined.
> 
> So, turning off whatever that ifdef is would cause a build error.
> 
> > diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> 
> > +unsigned long tegra_pmc_get_cpu_timer(void)
> ...
> > +unsigned long tegra_pmc_get_cpu_off_timer(void)
> 
> I think you want to make those return u32, since the values they return
> should be u32 to match DT cell type.
> 
Will fix.

> > +void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
> > +{
> > +	u32 reg;
> > +
> > +	reg = tegra_pmc_readl(PMC_CTRL);
> > +	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
> > +	reg &= ~TEGRA_POWER_EFFECT_LP0;
> > +
> > +	tegra_pmc_writel(reg, PMC_CTRL);
> > +}
> 
> The "mode" parameter doesn't seem to be used here.
> 
> One overall comment: tegra_suspend_enter() only supports LP2 so far, but
> I don't see a check anywhere (e.g. tegra_init_suspend() or
> tegra_pmc_parse_dt()) which prevents suspend from being initialized if
> the user requested some other type, or on SoCs where even LP2 isn't
> supported yet (e.g. Tegra114).

OK. Will remove now.

Thanks,
Joseph
