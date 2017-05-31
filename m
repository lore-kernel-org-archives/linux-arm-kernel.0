From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 May 2017 15:55:42 +0100
Subject: [PATCH v2 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic_stby_poweroff" is set
In-Reply-To: <20170531061457.23744-3-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
 <20170531061457.23744-3-o.rempel@pengutronix.de>
Message-ID: <20170531145542.GD10351@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 08:14:53AM +0200, Oleksij Rempel wrote:
> One of the Freescale recommended sequences for power off with external
> PMIC is the following:
> ...
> 3.  SoC is programming PMIC for power off when standby is asserted.
> 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> 
> See:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> page 5083

> +static int imx6_pm_poweroff_probe(void)
> +{
> +	char symname[KSYM_NAME_LEN];
> +
> +	if (pm_power_off) {
> +		lookup_symbol_name((ulong)pm_power_off, symname);
> +		pr_warn("%s: pm_power_off already claimed  %p %s!\n",
> +			__func__, pm_power_off, symname);

Please use %pf rather than lookup_symbol_name*(,

> +		return -EBUSY;
> +	}
> +
> +	pm_power_off = imx6_pm_poweroff;
> +	return 0;
> +}
> +
>  void __init imx6_pm_ccm_init(const char *ccm_compat)
>  {
>  	struct device_node *np;
> @@ -618,6 +645,9 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
>  	val = readl_relaxed(ccm_base + CLPCR);
>  	val &= ~BM_CLPCR_LPM;
>  	writel_relaxed(val, ccm_base + CLPCR);
> +
> +	if (of_property_read_bool(np, "fsl,pmic_stby_poweroff"))
> +		imx6_pm_poweroff_probe();

This neesd s/_/-/, as commented on the binding.

My what/why query on the binding stadns, regardless.

Thanks,
Mark.
