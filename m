From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Dec 2010 17:20:59 -0200
Subject: [PATCH v6 1/2] ARM: mx5: dynamically allocate pwm devices
In-Reply-To: <1291209107-2256-1-git-send-email-fabio.estevam@freescale.com>
References: <1291209107-2256-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <AANLkTi=rTbL2SHCPtn5sGQ4O1x+DgOHfJOEi3fG7ZrZy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Does this series look OK now?

Thanks,

Fabio Estevam


On Wed, Dec 1, 2010 at 11:11 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ?| ? ?4 ++++
> ?arch/arm/plat-mxc/devices/platform-mxc_pwm.c | ? ?9 +++++++++
> ?arch/arm/plat-mxc/include/mach/mx51.h ? ? ? ?| ? ?4 ++--
> ?3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
> index 939d2e8..e4bc426 100644
> --- a/arch/arm/mach-mx5/devices-imx51.h
> +++ b/arch/arm/mach-mx5/devices-imx51.h
> @@ -47,3 +47,7 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
> ?extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data __initconst;
> ?#define imx51_imx2_wdt_data(pdata) ? ? \
> ? ? ? ?imx_add_imx2_wdt_data(&imx51_imx2_wdt_data, pdata)
> +
> +extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst;
> +#define imx51_add_mxc_pwm(id, pdata) ? \
> + ? ? ? imx_add_mxc_pwm(&imx51_mxc_pwm_data[id], pdata)
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> index 3d8ebdb..b0c4ae2 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> @@ -40,6 +40,15 @@ const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
> ? ? ? ?imx_mxc_pwm_data_entry_single(MX27, 0, , SZ_4K);
> ?#endif /* ifdef CONFIG_SOC_IMX27 */
>
> +#ifdef CONFIG_SOC_IMX51
> +const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
> +#define imx51_mxc_pwm_data_entry(_id, _hwid) ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? imx_mxc_pwm_data_entry(MX51, _id, _hwid, SZ_16K)
> + ? ? ? imx51_mxc_pwm_data_entry(0, 1),
> + ? ? ? imx51_mxc_pwm_data_entry(1, 2),
> +};
> +#endif /* ifdef CONFIG_SOC_IMX51 */
> +
> ?struct platform_device *__init imx_add_mxc_pwm(
> ? ? ? ? ? ? ? ?const struct imx_mxc_pwm_data *data)
> ?{
> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index 8fddfef..54b58a0 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -302,7 +302,7 @@
> ?#define MX51_MXC_INT_WDOG1 ? ? ? ? ? ? 58
> ?#define MX51_MXC_INT_WDOG2 ? ? ? ? ? ? 59
> ?#define MX51_MXC_INT_KPP ? ? ? ? ? ? ? 60
> -#define MX51_MXC_INT_PWM1 ? ? ? ? ? ? ?61
> +#define MX51_INT_PWM1 ? ? ? ? ? ? ? ? ?61
> ?#define MX51_INT_I2C1 ? ? ? ? ? ? ? ? ?62
> ?#define MX51_INT_I2C2 ? ? ? ? ? ? ? ? ?63
> ?#define MX51_MXC_INT_HS_I2C ? ? ? ? ? ?64
> @@ -335,7 +335,7 @@
> ?#define MX51_MXC_INT_SPDIF ? ? ? ? ? ? 91
> ?#define MX51_MXC_INT_TVE ? ? ? ? ? ? ? 92
> ?#define MX51_MXC_INT_FIRI ? ? ? ? ? ? ?93
> -#define MX51_MXC_INT_PWM2 ? ? ? ? ? ? ?94
> +#define MX51_INT_PWM2 ? ? ? ? ? ? ? ? ?94
> ?#define MX51_MXC_INT_SLIM_EXP ? ? ? ? ?95
> ?#define MX51_MXC_INT_SSI3 ? ? ? ? ? ? ?96
> ?#define MX51_MXC_INT_EMI_BOOT ? ? ? ? ?97
> --
> 1.6.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
