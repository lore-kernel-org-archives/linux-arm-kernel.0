From: khilman@ti.com (Kevin Hilman)
Date: Wed, 31 Aug 2011 15:24:57 -0700
Subject: [PATCH 4/7] OMAP2+: pm: Use hwmod name instead of dev pointer
In-Reply-To: <1314026347-21623-5-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:04 +0200")
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-5-git-send-email-b-cousson@ti.com>
Message-ID: <87ippd8bie.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Replace the struct device parameter of omap2_set_init_voltage
> by the hwmod name. It will avoid having to store explicitely
> the device pointer into a static variable.
> Moreover, it will be a little bit more scalable if we introduce
> new DVFS devices.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |   22 +++++++++++++++-------
>  1 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 54281e5..17725d2 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -171,18 +171,26 @@ err:
>   * in the opp entry
>   */
>  static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
> -						struct device *dev)
> +					 const char *oh_name)
>  {
>  	struct voltagedomain *voltdm;
>  	struct clk *clk;
>  	struct opp *opp;
>  	unsigned long freq, bootup_volt;
> +	struct device *dev;
>  
> -	if (!vdd_name || !clk_name || !dev) {
> +	if (!vdd_name || !clk_name || !oh_name) {
>  		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
>  		goto exit;
>  	}
>  
> +	dev = omap_hwmod_name_get_dev(oh_name);
> +	if (IS_ERR(dev)) {
> +		pr_err("%s: Unable to get dev pointer for hwmod %s\n",
> +			__func__, oh_name);
> +		goto exit;
> +	}
> +
>  	voltdm = omap_voltage_domain_lookup(vdd_name);
>  	if (IS_ERR(voltdm)) {
>  		printk(KERN_ERR "%s: Unable to get vdd pointer for vdd_%s\n",
> @@ -228,8 +236,8 @@ static void __init omap3_init_voltages(void)
>  	if (!cpu_is_omap34xx())
>  		return;
>  
> -	omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
> -	omap2_set_init_voltage("core", "l3_ick", l3_dev);
> +	omap2_set_init_voltage("mpu", "dpll1_ck", "mpu");
> +	omap2_set_init_voltage("core", "l3_ick", "l3_main");
>  }
>  
>  static void __init omap4_init_voltages(void)
> @@ -237,9 +245,9 @@ static void __init omap4_init_voltages(void)
>  	if (!cpu_is_omap44xx())
>  		return;
>  
> -	omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
> -	omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
> -	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
> +	omap2_set_init_voltage("mpu", "dpll_mpu_ck", "mpu");
> +	omap2_set_init_voltage("core", "l3_div_ck", "l3_main_1");
> +	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
>  }
>  
>  static int __init omap2_common_pm_init(void)

Looks fine.

Kevin
