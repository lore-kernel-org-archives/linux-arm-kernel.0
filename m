From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 16:58:17 +0200
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <1299206935-10953-1-git-send-email-b02280@freescale.com>
References: <1299206935-10953-1-git-send-email-b02280@freescale.com>
Message-ID: <20110404145817.GA13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 10:48:55AM +0800, Jason Chen wrote:
> Signed-off-by: Jason Chen <b02280@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c          |    2 ++
>  arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
>  arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    9 +++++++++
>  arch/arm/plat-mxc/pwm.c                      |    3 ++-
>  4 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 8164b1d..8a2b8de 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1338,6 +1338,8 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
>  	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> +	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
> +	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
there are already lines

	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)

further up in the list. I guess your definition is better, so can you
please remove the existing ones?

>  };
>  
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
> index 9251008..5a1d6c9 100644
> --- a/arch/arm/mach-mx5/devices-imx53.h
> +++ b/arch/arm/mach-mx5/devices-imx53.h
> @@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
>  extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
>  #define imx53_add_imx2_wdt(id, pdata)	\
>  	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
> +
> +extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
> +#define imx53_add_mxc_pwm(id)	\
> +	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> index b0c4ae2..18cfd07 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> @@ -49,6 +49,15 @@ const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX51 */
>  
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst = {
> +#define imx53_mxc_pwm_data_entry(_id, _hwid)				\
> +	imx_mxc_pwm_data_entry(MX53, _id, _hwid, SZ_16K)
> +	imx53_mxc_pwm_data_entry(0, 1),
> +	imx53_mxc_pwm_data_entry(1, 2),

You can shorten this a bit:
	imx_mxc_pwm_data_entry(MX53, 0, 1, SZ_16K)
	imx_mxc_pwm_data_entry(MX53, 1, 2, SZ_16K)

I don't care much, but Sascha considers this better.

> +};
> +#endif /* ifdef CONFIG_SOC_IMX53 */
> +
>  struct platform_device *__init imx_add_mxc_pwm(
>  		const struct imx_mxc_pwm_data *data)
>  {
> diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
> index 7a61ef8..61dd8fb 100644
> --- a/arch/arm/plat-mxc/pwm.c
> +++ b/arch/arm/plat-mxc/pwm.c
> @@ -57,7 +57,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>  	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
>  		return -EINVAL;
>  
> -	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> +	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51() ||
> +		cpu_is_mx53()) {
>  		unsigned long long c;
>  		unsigned long period_cycles, duty_cycles, prescale;
>  		u32 cr;
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
