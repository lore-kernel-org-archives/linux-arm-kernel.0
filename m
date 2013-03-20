From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 20 Mar 2013 18:26:39 +0800
Subject: [PATCH V4 4/9] ARM: tegra: pm: add platform suspend support
In-Reply-To: <51489B5D.3050101@wwwdotorg.org>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
 <1363594400-11663-5-git-send-email-josephl@nvidia.com>
 <51489B5D.3050101@wwwdotorg.org>
Message-ID: <1363775199.5697.31.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 01:07 +0800, Stephen Warren wrote:
> On 03/18/2013 02:13 AM, Joseph Lo wrote:
> > Adding suspend to RAM support for Tegra platform. There are three suspend
> > mode for Tegra. The difference were below.
> > 
> > * LP2: CPU voltage off
> > * LP1: CPU voltage off, DRAM in self-refresh
> > * LP0: CPU + Core voltage off, DRAM in self-refresh
> > 
> > After this patch, the LP2 suspend mode will be supported.
> 
> > diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> > index c84505c..024f355 100644
> > --- a/arch/arm/mach-tegra/common.c
> > +++ b/arch/arm/mach-tegra/common.c
> > @@ -66,6 +66,7 @@ void __init tegra_dt_init_irq(void)
> >  	tegra_init_irq();
> >  	irqchip_init();
> >  	tegra_legacy_irq_syscore_init();
> > +	tegra_init_suspend();
> 
> Does that have to be part of tegra_dt_init_irq()? Can't we initialize
> suspend support in some later hook. init_irq() should just initialize IRQs.
> 
I can re-check the sequence later.

> > diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> 
> > -void set_power_timers(unsigned long us_on, unsigned long us_off)
> > +static void set_power_timers(u32 us_on, u32 us_off, unsigned long rate)
> >  {
> >  	unsigned long long ticks;
> >  	unsigned long long pclk;
> > -	unsigned long rate;
> >  	static unsigned long tegra_last_pclk;
> >  
> > -	rate = clk_get_rate(tegra_pclk);
> > -
> >  	if (WARN_ON_ONCE(rate <= 0))
> >  		pclk = 100000000;
> >  	else
> 
> I don't think the code compiles after that?
> 
> The code must both compile and execute correctly after each patch is
> applied, without relying on any future patches.
> 
It's OK. I had checked this before sending the patch.

> > +void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
> > +{
> > +	u32 reg;
> > +	unsigned long rate = 0;
> > +
> > +	reg = tegra_pmc_readl(PMC_CTRL);
> > +	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
> > +	reg &= ~TEGRA_POWER_EFFECT_LP0;
> > +
> > +	switch (mode) {
> > +	case TEGRA_SUSPEND_LP2:
> > +		rate = clk_get_rate(tegra_pclk);
> 
> That isn't used anywhere.
> 
It will pass to set_power_timers().

> > +void tegra_pmc_suspend_init(void)
> > +{
> > +	u32 reg;
> > +
> > +	/* Always enable CPU power request; just normal polarity is supported */
> > +	reg = tegra_pmc_readl(PMC_CTRL);
> > +	BUG_ON(reg & TEGRA_POWER_CPU_PWRREQ_POLARITY);
> 
> Why is that comment true? What does it take to support arbitrary
> polarity; just flipping the OE bit in the register?

Hmm. You are right. I think this is redundant if we support different
polarity setting. We should also add it into DT binding. So we can just
flip the OE bit here.
