From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 27 Jul 2018 09:15:40 +0000
Subject: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
In-Reply-To: <20180726092220.17250-3-o.rempel@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-3-o.rempel@pengutronix.de>
Message-ID: <DB6PR04MB3223A62E5609BF6431ABEA40892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: 2018?7?26? 17:22
> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org; Andrew Morton
> <akpm@linux-foundation.org>; Liam Girdwood <lgirdwood@gmail.com>;
> Leonard Crestez <leonard.crestez@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> King <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
> "fsl,pmic-stby-poweroff" is set
> 
> One of the Freescale recommended sequences for power off with external
> PMIC is the following:
> ...
> 3.  SoC is programming PMIC for power off when standby is asserted.
> 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> 
> See:
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> nxp.com%2Fassets%2Fdocuments%2Fdata%2Fen%2Freference-manuals%2FIM
> X6DQRM.pdf&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7C193fd19e3a
> 40416ffa4a08d5f2d9583c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1
> %7C636681937661914076&amp;sdata=lICAelYpUh4%2Ft%2Fs7N9mdk2cLQMi
> cHcOqQ07vTOUoyNY%3D&amp;reserved=0
> page 5083
> 
> This patch implements step 4. of this sequence.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index 017539dd712b..2f5c643f62fb 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -601,6 +601,28 @@ static void __init imx6_pm_common_init(const struct
> imx6_pm_socdata
>  				   IMX6Q_GPR1_GINT);
>  }
> 
> +static void imx6_pm_stby_poweroff(void) {
> +	imx6_set_lpm(STOP_POWER_OFF);
> +	imx6q_suspend_finish(0);
> +
> +	mdelay(1000);
> +
> +	pr_emerg("Unable to poweroff system\n"); }
> +
> +static int imx6_pm_stby_poweroff_probe(void) {
> +	if (pm_power_off) {
> +		pr_warn("%s: pm_power_off already claimed  %p %pf!\n",
> +			__func__, pm_power_off, pm_power_off);
'syscon-poweroff' and 'pmic-stby-poweroff ' should be chosen as a single
Poweroff way for any i.mx6 board. Why not delete directly 'syscon-poweroff' in dts 
to avoid such two power off ways coexist?
> +		return -EBUSY;
> +	}
> +
> +	pm_power_off = imx6_pm_stby_poweroff;
> +	return 0;
> +}
> +
>  void __init imx6_pm_ccm_init(const char *ccm_compat)  {
>  	struct device_node *np;
> @@ -617,6 +639,9 @@ void __init imx6_pm_ccm_init(const char
> *ccm_compat)
>  	val = readl_relaxed(ccm_base + CLPCR);
>  	val &= ~BM_CLPCR_LPM;
>  	writel_relaxed(val, ccm_base + CLPCR);
> +
> +	if (of_property_read_bool(np, "fsl,pmic-stby-poweroff"))
> +		imx6_pm_stby_poweroff_probe();
>  }
> 
>  void __init imx6q_pm_init(void)
> --
> 2.18.0
