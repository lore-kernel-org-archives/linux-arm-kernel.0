From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Mar 2014 11:05:24 +0100
Subject: [PATCH v5 2/5] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <20140305065649.GJ8784@S2101-09.ap.freescale.net>
References: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
 <1393603427-6199-3-git-send-email-p.zabel@pengutronix.de>
 <20140305065649.GJ8784@S2101-09.ap.freescale.net>
Message-ID: <1394013924.16929.14.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

thank you for the comments.

Am Mittwoch, den 05.03.2014, 14:56 +0800 schrieb Shawn Guo:
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 33567aa..3c58f2e 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -808,6 +808,7 @@ config SOC_IMX6Q
> >  	select PL310_ERRATA_727915 if CACHE_PL310
> >  	select PL310_ERRATA_769419 if CACHE_PL310
> >  	select PM_OPP if PM
> > +	select PM_GENERIC_DOMAINS if PM
> 
> Would it make more sense to have HAVE_IMX_GPC select it instead?

Yes, I'll change that.

> > +#include <linux/pm_clock.h>
> 
> Is this header still needed?

No, will remove.

[...]
> > +struct pu_domain {
> > +	struct generic_pm_domain base;
> > +	struct regulator *reg;
> > +	struct clk *clk[6];
> 
> Define a macro for this number?

#define GPC_CLK_MAX   6

[...]
> > +static int imx_gpc_probe(struct platform_device *pdev)
> > +{
> > +	struct regulator *pu_reg;
> > +	struct clk *clk;
> > +	bool is_off;
> > +	int ret, i;
> > +
> > +	pu_reg = devm_regulator_get(&pdev->dev, "pu");
> > +	if (IS_ERR(pu_reg)) {
> > +		ret = PTR_ERR(pu_reg);
> > +		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* The regulator is initially enabled */
> > +	ret = regulator_enable(pu_reg);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to enable pu regulator: %d\n", ret);
> > +		return ret;
> > +	}
> > +	imx6q_pu_domain.base.of_node = pdev->dev.of_node;
> 
> How does this work with !CONFIG_PM build?

Since I removed the regulator-always-on property from the PU regulator
in the device tree, if CONFIG_PM is disabled, we have to request and
enable pu_reg here. Otherwise the regulator framework will helpfully
turn it off (imx6q-cpufreq never enables pu_reg).
With the PU regulator disabled, the system would hang as soon as the
CODA VPU or one of the Vivante GPU cores is accessed if !CONFIG_PM.

> > +	imx6q_pu_domain.reg = pu_reg;
> > +
> > +	for (i = 0; ; i++) {
> > +		clk = of_clk_get(pdev->dev.of_node, i);
> > +		if (IS_ERR(clk))
> > +			break;

Also, I should probably add
+		if (i >= GPC_CLK_MAX) {
+			dev_err(&pdev->dev, "more than %d clocks\n",
+				GPC_CLK_MAX);
+			return -EINVAL;
+		}
here.

> > +		imx6q_pu_domain.clk[i] = clk;
> > +	}
> > +	imx6q_pu_domain.num_clks = i;
[...]

regards
Philipp
