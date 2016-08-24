From: anson.huang@nxp.com (Yongcai Huang)
Date: Wed, 24 Aug 2016 09:53:36 +0000
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1472029735.2780.3.camel@pengutronix.de>
References: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
 <1472029735.2780.3.camel@pengutronix.de>
Message-ID: <AM3PR04MB131584BCC7F2389B8C9437C7F5EA0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: 2016-08-24 5:09 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Fabio
> Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> linux at armlinux.org.uk; kernel at pengutronix.de
> Subject: Re: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
> 
> Am Donnerstag, den 25.08.2016, 00:13 +0800 schrieb Anson Huang:
> > This patch enables cpuidle driver for i.MX6UL, it reuses i.MX6SX's
> > cpuidle driver, 3 levels of cpuidle
> > supported:
> >
> > 1. ARM WFI;
> > 2. SOC in WAIT mode;
> > 3. SOC in WAIT mode + ARM power off.
> >
> > As i.MX6UL has cortex-A7 CORE with an internal L2 cache, so need to
> > add L2 cache type check to decide if to flush L2 when entering idle
> > with ARM power off, this is different from i.MX6SX which has PL310
> > external
> > L2 cache.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sx.c | 10 ++++++++++
> >  arch/arm/mach-imx/mach-imx6ul.c    |  3 +++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > index 41cdce6..b4fcc8ae 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > @@ -9,14 +9,21 @@
> >  #include <linux/cpuidle.h>
> >  #include <linux/cpu_pm.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <asm/cacheflush.h>
> >  #include <asm/cpuidle.h>
> >  #include <asm/suspend.h>
> >
> >  #include "common.h"
> >  #include "cpuidle.h"
> >
> > +static bool pl310_available;
> > +
> >  static int imx6sx_idle_finish(unsigned long val)  {
> > +	/* check if need to flush internal L2 cache */
> > +	if (!pl310_available)
> > +		flush_cache_all();
> 
> I think this is only necessary when entering the deepest idle state with the
> ARM core powered off, right? It's a serious overhead for the shallow idle states.
> 
> Also flush_cache_all() only flushes architected/inner caches, so it should do the
> right thing for this use-case even if the outer PL310 cache is present. There is
> no need to make this conditional.
> 

Sorry, my mutt is NOT working now, so I just reply you using outlook, will work on my mutt later.

Yes, the imx6sx_idle_finish is only called when entering deepest idle with ARM powered off.

The common cpu_suspend framework already takes care of L1 cache, for i.MX6SX which is with a 
PL310 external L2 cache, as L2 cache memory is NOT powered down, so we no need to flush it.

For i.MX6UL which is cortex A7 and has integrated L2 cache, the L2 memory power will be also
turned off when ARM core is powered off, so we have to flush it before power off.

Regards,
Anson


> Regards,
> Lucas
> 
> >  	cpu_do_idle();
> >
> >  	return 0;
> > @@ -101,5 +108,8 @@ int __init imx6sx_cpuidle_init(void)
> >  	imx_gpc_set_arm_power_up_timing(2, 1);
> >  	imx_gpc_set_arm_power_down_timing(1, 1);
> >
> > +	if (of_find_compatible_node(NULL, NULL, "arm,pl310-cache"))
> > +		pl310_available = true;
> > +
> >  	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);  } diff --git
> > a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> > index c2cd61c..9c5e8f3 100644
> > --- a/arch/arm/mach-imx/mach-imx6ul.c
> > +++ b/arch/arm/mach-imx/mach-imx6ul.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/mach/map.h>
> >
> >  #include "common.h"
> > +#include "cpuidle.h"
> >
> >  static void __init imx6ul_enet_clk_init(void)  { @@ -80,6 +81,8 @@
> > static void __init imx6ul_init_irq(void)
> >
> >  static void __init imx6ul_init_late(void)  {
> > +	imx6sx_cpuidle_init();
> > +
> >  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
> >  		imx6_pm_opp_init();
> >  		platform_device_register_simple("imx6q-cpufreq", -1, NULL,
> 0);
> 
