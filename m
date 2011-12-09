From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Dec 2011 09:00:48 +0900
Subject: [PATCH v2] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <201112082355.11249.rjw@sisk.pl>
References: <1323306483-27132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112082355.11249.rjw@sisk.pl>
Message-ID: <00a701ccb605$9ba84650$d2f8d2f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw at sisk.pl]
> Sent: Friday, December 09, 2011 7:55 AM
> To: Mark Brown
> Cc: Kukjin Kim; linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org
> Subject: Re: [PATCH v2] ARM: S3C64XX: Implement basic power domain support
> 
> On Thursday, December 08, 2011, Mark Brown wrote:
> > The S3C64xx SoCs contain a set of gateable power domains which can be
> > enabled and disabled at runtime in order to save power.  Use the generic
> > power domain code to implement support for these in software, enabling
> > runtime control of most domains:
> >
> >  - ETM (not supported in mainline).
> >  - Domain G: 3D acceleration (no mainline support).
> >  - Domain V: MFC (no mainline support).
> >  - Domain I: JPEG and camera interface (no mainline support).
> >  - Domain P: 2D acceleration, TV encoder and scaler (no mainline
support)
> >  - Domain S: Security (no mainline support).
> >  - Domain F: LCD (driver already uses runtime PM), post processing and
> >    rotation (no mainline support).
> >
> > The IROM domain is marked as always enabled as we should arrange for it
> > to be enabled when we suspend which will need a bit more work.
> >
> > Due to all the conditional device registration that the platform does
> > wrap s3c_pm_init() with s3c64xx_pm_init() which actually puts the device
> > into the power domain after the machines have registered, looking for
> > platform data to tell if the device was registered. Since currently only
> > Cragganmore actually sets up PM that is the only machine updated.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Applied to linux-pm/linux-next.
> 
Hi Rafael,

As I said, I need topic branch for merging into my tree to avoid conflicts,
but I couldn't find any branch for this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Thanks,
> Rafael
> 
> 
> > ---
> >  arch/arm/mach-s3c64xx/Kconfig           |    1 +
> >  arch/arm/mach-s3c64xx/mach-crag6410.c   |    2 +-
> >  arch/arm/mach-s3c64xx/pm.c              |  176
> ++++++++++++++++++++++++++++++-
> >  arch/arm/plat-samsung/include/plat/pm.h |    6 +
> >  4 files changed, 182 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-
> s3c64xx/Kconfig
> > index 4d8c489..5c6c22e 100644
> > --- a/arch/arm/mach-s3c64xx/Kconfig
> > +++ b/arch/arm/mach-s3c64xx/Kconfig
> > @@ -8,6 +8,7 @@ config PLAT_S3C64XX
> >  	bool
> >  	depends on ARCH_S3C64XX
> >  	select SAMSUNG_WAKEMASK
> > +	select PM_GENERIC_DOMAINS
> >  	default y
> >  	help
> >  	  Base platform code for any Samsung S3C64XX device
> > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> > index 85b79ec..63c8751 100644
> > --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > @@ -731,7 +731,7 @@ static void __init crag6410_machine_init(void)
> >
> >  	regulator_has_full_constraints();
> >
> > -	s3c_pm_init();
> > +	s3c64xx_pm_init();
> >  }
> >
> >  MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
> > diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> > index b375cd5..7d3e81b 100644
> > --- a/arch/arm/mach-s3c64xx/pm.c
> > +++ b/arch/arm/mach-s3c64xx/pm.c
> > @@ -17,10 +17,12 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/io.h>
> >  #include <linux/gpio.h>
> > +#include <linux/pm_domain.h>
> >
> >  #include <mach/map.h>
> >  #include <mach/irqs.h>
> >
> > +#include <plat/devs.h>
> >  #include <plat/pm.h>
> >  #include <plat/wakeup-mask.h>
> >
> > @@ -31,6 +33,148 @@
> >  #include <mach/regs-gpio-memport.h>
> >  #include <mach/regs-modem.h>
> >
> > +struct s3c64xx_pm_domain {
> > +	char *const name;
> > +	u32 ena;
> > +	u32 pwr_stat;
> > +	struct generic_pm_domain pd;
> > +};
> > +
> > +static int s3c64xx_pd_off(struct generic_pm_domain *domain)
> > +{
> > +	struct s3c64xx_pm_domain *pd;
> > +	u32 val;
> > +
> > +	pd = container_of(domain, struct s3c64xx_pm_domain, pd);
> > +
> > +	val = __raw_readl(S3C64XX_NORMAL_CFG);
> > +	val &= ~(pd->ena);
> > +	__raw_writel(val, S3C64XX_NORMAL_CFG);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s3c64xx_pd_on(struct generic_pm_domain *domain)
> > +{
> > +	struct s3c64xx_pm_domain *pd;
> > +	u32 val;
> > +	long retry = 1000000L;
> > +
> > +	pd = container_of(domain, struct s3c64xx_pm_domain, pd);
> > +
> > +	val = __raw_readl(S3C64XX_NORMAL_CFG);
> > +	val |= pd->ena;
> > +	__raw_writel(val, S3C64XX_NORMAL_CFG);
> > +
> > +	/* Not all domains provide power status readback */
> > +	if (pd->pwr_stat) {
> > +		do {
> > +			cpu_relax();
> > +			if (__raw_readl(S3C64XX_BLK_PWR_STAT) &
pd->pwr_stat)
> > +				break;
> > +		} while (retry--);
> > +
> > +		if (!retry) {
> > +			pr_err("Failed to start domain %s\n", pd->name);
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_irom = {
> > +	.name = "IROM",
> > +	.ena = S3C64XX_NORMALCFG_IROM_ON,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_etm = {
> > +	.name = "ETM",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_ETM_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_ETM,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_s = {
> > +	.name = "S",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_S_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_S,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_f = {
> > +	.name = "F",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_F_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_F,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_p = {
> > +	.name = "P",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_P_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_P,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_i = {
> > +	.name = "I",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_I_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_I,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_g = {
> > +	.name = "G",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_G_ON,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain s3c64xx_pm_v = {
> > +	.name = "V",
> > +	.ena = S3C64XX_NORMALCFG_DOMAIN_V_ON,
> > +	.pwr_stat = S3C64XX_BLKPWRSTAT_V,
> > +	.pd = {
> > +		.power_off = s3c64xx_pd_off,
> > +		.power_on = s3c64xx_pd_on,
> > +	},
> > +};
> > +
> > +static struct s3c64xx_pm_domain *s3c64xx_always_on_pm_domains[] = {
> > +	&s3c64xx_pm_irom,
> > +};
> > +
> > +static struct s3c64xx_pm_domain *s3c64xx_pm_domains[] = {
> > +	&s3c64xx_pm_etm,
> > +	&s3c64xx_pm_g,
> > +	&s3c64xx_pm_v,
> > +	&s3c64xx_pm_i,
> > +	&s3c64xx_pm_p,
> > +	&s3c64xx_pm_s,
> > +	&s3c64xx_pm_f,
> > +};
> > +
> >  #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
> >  void s3c_pm_debug_smdkled(u32 set, u32 clear)
> >  {
> > @@ -89,6 +233,8 @@ static struct sleep_save misc_save[] = {
> >
> >  	SAVE_ITEM(S3C64XX_SDMA_SEL),
> >  	SAVE_ITEM(S3C64XX_MODEM_MIFPCON),
> > +
> > +	SAVE_ITEM(S3C64XX_NORMAL_CFG),
> >  };
> >
> >  void s3c_pm_configure_extint(void)
> > @@ -179,7 +325,26 @@ static void s3c64xx_pm_prepare(void)
> >  	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT), S3C64XX_WAKEUP_STAT);
> >  }
> >
> > -static int s3c64xx_pm_init(void)
> > +int __init s3c64xx_pm_init(void)
> > +{
> > +	int i;
> > +
> > +	s3c_pm_init();
> > +
> > +	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
> > +		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
> > +			      &pm_domain_always_on_gov, false);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
> > +		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
> > +
> > +	if (dev_get_platdata(&s3c_device_fb.dev))
> > +		pm_genpd_add_device(&s3c64xx_pm_f.pd, &s3c_device_fb.dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static __init int s3c64xx_pm_initcall(void)
> >  {
> >  	pm_cpu_prep = s3c64xx_pm_prepare;
> >  	pm_cpu_sleep = s3c64xx_cpu_suspend;
> > @@ -198,5 +363,12 @@ static int s3c64xx_pm_init(void)
> >
> >  	return 0;
> >  }
> > +arch_initcall(s3c64xx_pm_initcall);
> > +
> > +static __init int s3c64xx_pm_late_initcall(void)
> > +{
> > +	pm_genpd_poweroff_unused();
> >
> > -arch_initcall(s3c64xx_pm_init);
> > +	return 0;
> > +}
> > +late_initcall(s3c64xx_pm_late_initcall);
> > diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-
> samsung/include/plat/pm.h
> > index dcf6870..a6bdee2 100644
> > --- a/arch/arm/plat-samsung/include/plat/pm.h
> > +++ b/arch/arm/plat-samsung/include/plat/pm.h
> > @@ -22,6 +22,7 @@ struct sys_device;
> >  #ifdef CONFIG_PM
> >
> >  extern __init int s3c_pm_init(void);
> > +extern __init int s3c64xx_pm_init(void);
> >
> >  #else
> >
> > @@ -29,6 +30,11 @@ static inline int s3c_pm_init(void)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline int s3c64xx_pm_init(void)
> > +{
> > +	return 0;
> > +}
> >  #endif
> >
> >  /* configuration for the IRQ mask over sleep */
> >
