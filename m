From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 1 Mar 2011 15:35:29 +0800
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <1298961018-8988-1-git-send-email-b02280@freescale.com>
References: <1298961018-8988-1-git-send-email-b02280@freescale.com>
Message-ID: <AANLkTinSgmeKtmHSoLiGaqMbWV+68FabgjtbE_ODMcan@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2011 at 2:30 PM, Jason Chen <b02280@freescale.com> wrote:
> Signed-off-by: Jason Chen <b02280@freescale.com>

Looks perfect to me. Sascha?

> ---
> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ?| ? ?2 ++
> ?arch/arm/mach-mx5/devices-imx53.h ? ? ? ? ? ?| ? ?4 ++++
> ?arch/arm/mach-mx5/devices.c ? ? ? ? ? ? ? ? ?| ? 10 ++++++++++
> ?arch/arm/mach-mx5/devices.h ? ? ? ? ? ? ? ? ?| ? ?2 ++
> ?arch/arm/plat-mxc/devices/Kconfig ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-mxc/devices/platform-mxc_pwm.c | ? ?9 +++++++++
> ?arch/arm/plat-mxc/pwm.c ? ? ? ? ? ? ? ? ? ? ?| ? ?3 ++-
> ?7 files changed, 30 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 8164b1d..e18807b 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1338,6 +1338,8 @@ static struct clk_lookup mx53_lookups[] = {
> ? ? ? ?_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
> ? ? ? ?_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> ? ? ? ?_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> + ? ? ? _REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
> + ? ? ? _REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
> ?};
>
> ?static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
> index 9251008..5a1d6c9 100644
> --- a/arch/arm/mach-mx5/devices-imx53.h
> +++ b/arch/arm/mach-mx5/devices-imx53.h
> @@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
> ?extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
> ?#define imx53_add_imx2_wdt(id, pdata) ?\
> ? ? ? ?imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
> +
> +extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
> +#define imx53_add_mxc_pwm(id) ?\
> + ? ? ? imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
> diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
> index 153ada5..74aec2b 100644
> --- a/arch/arm/mach-mx5/devices.c
> +++ b/arch/arm/mach-mx5/devices.c
> @@ -120,6 +120,16 @@ struct platform_device mxc_usbh2_device = {
> ? ? ? ?},
> ?};
>
> +struct platform_device mxc_pwm1_backlight_device = {
> + ? ? ? .name = "pwm-backlight",
> + ? ? ? .id = 0,
> +};
> +
> +struct platform_device mxc_pwm2_backlight_device = {
> + ? ? ? .name = "pwm-backlight",
> + ? ? ? .id = 1,
> +};
> +
> ?static struct mxc_gpio_port mxc_gpio_ports[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.chip.label = "gpio-0",
> diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
> index 55a5129..a74cd97 100644
> --- a/arch/arm/mach-mx5/devices.h
> +++ b/arch/arm/mach-mx5/devices.h
> @@ -3,3 +3,5 @@ extern struct platform_device mxc_usbh1_device;
> ?extern struct platform_device mxc_usbh2_device;
> ?extern struct platform_device mxc_usbdr_udc_device;
> ?extern struct platform_device mxc_hsi2c_device;
> +extern struct platform_device mxc_pwm1_backlight_device;
> +extern struct platform_device mxc_pwm2_backlight_device;
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index b9ab1d5..aee9f4b 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -58,6 +58,7 @@ config IMX_HAVE_PLATFORM_MXC_NAND
>
> ?config IMX_HAVE_PLATFORM_MXC_PWM
> ? ? ? ?bool
> + ? ? ? default y if ARCH_MX21 || ARCH_MX25 || SOC_IMX27 || SOC_IMX51 || SOC_IMX53
>
> ?config IMX_HAVE_PLATFORM_MXC_RNGA
> ? ? ? ?bool
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> index b0c4ae2..18cfd07 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> @@ -49,6 +49,15 @@ const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
> ?};
> ?#endif /* ifdef CONFIG_SOC_IMX51 */
>
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst = {
> +#define imx53_mxc_pwm_data_entry(_id, _hwid) ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? imx_mxc_pwm_data_entry(MX53, _id, _hwid, SZ_16K)
> + ? ? ? imx53_mxc_pwm_data_entry(0, 1),
> + ? ? ? imx53_mxc_pwm_data_entry(1, 2),
> +};
> +#endif /* ifdef CONFIG_SOC_IMX53 */
> +
> ?struct platform_device *__init imx_add_mxc_pwm(
> ? ? ? ? ? ? ? ?const struct imx_mxc_pwm_data *data)
> ?{
> diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
> index 7a61ef8..61dd8fb 100644
> --- a/arch/arm/plat-mxc/pwm.c
> +++ b/arch/arm/plat-mxc/pwm.c
> @@ -57,7 +57,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> ? ? ? ?if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> + ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51() ||
> + ? ? ? ? ? ? ? cpu_is_mx53()) {

This might be improved in the future by using platform_device_id,
or by introducing some flags from platform_data, or when registering
the pwm devices.

> ? ? ? ? ? ? ? ?unsigned long long c;
> ? ? ? ? ? ? ? ?unsigned long period_cycles, duty_cycles, prescale;
> ? ? ? ? ? ? ? ?u32 cr;
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
