From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Jan 2011 11:40:10 +0100
Subject: [PATCH v2 1/4] ARM: i.MX53: enable spi support
In-Reply-To: <1294750464-8660-2-git-send-email-yong.shen@freescale.com>
References: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
	<1294750464-8660-2-git-send-email-yong.shen@freescale.com>
Message-ID: <20110121104010.GE9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 08:54:21PM +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@freescale.com>
> 
> 1. register spi clock
> 2. add macro definitions for spi platform data
> 3. fix some bugs of register and iomux definition

As I merged Dinhs patch for full iomux support this one won't apply
anymore. Can you please rebase it onto imx-for-2.6.39?

Sascha

> 
> Signed-off-by: Yong Shen <yong.shen@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c          |    3 +++
>  arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
>  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 ++++++++++++
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h  |    6 +++---
>  arch/arm/plat-mxc/include/mach/mx53.h        |   10 +++++-----
>  5 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index d0f58a3..a20d0c0 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1330,6 +1330,9 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> +	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
> +	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
> +	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
>  };
>  
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
> index f7c89ef..8639735 100644
> --- a/arch/arm/mach-mx5/devices-imx53.h
> +++ b/arch/arm/mach-mx5/devices-imx53.h
> @@ -25,3 +25,7 @@ extern const struct imx_sdhci_esdhc_imx_data
>  imx53_sdhci_esdhc_imx_data[] __initconst;
>  #define imx53_add_sdhci_esdhc_imx(id, pdata)	\
>  	imx_add_sdhci_esdhc_imx(&imx53_sdhci_esdhc_imx_data[id], pdata)
> +
> +extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
> +#define imx53_add_ecspi(id, pdata)	\
> +	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
> diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> index 8ea49ad..013c85f 100644
> --- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> @@ -81,6 +81,18 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
>  };
>  #endif /* ifdef CONFIG_SOC_IMX51 */
>  
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_spi_imx_data imx53_cspi_data __initconst =
> +	imx_spi_imx_data_entry_single(MX53, CSPI, "imx53-cspi", 0, , SZ_4K);
> +
> +const struct imx_spi_imx_data imx53_ecspi_data[] __initconst = {
> +#define imx53_ecspi_data_entry(_id, _hwid)				\
> +	imx_spi_imx_data_entry(MX53, ECSPI, "imx53-ecspi", _id, _hwid, SZ_4K)
> +	imx53_ecspi_data_entry(0, 1),
> +	imx53_ecspi_data_entry(1, 2),
> +};
> +#endif /* ifdef CONFIG_SOC_IMX53 */
> +
>  struct platform_device *__init imx_add_spi_imx(
>  		const struct imx_spi_imx_data *data,
>  		const struct spi_imx_master *pdata)
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 2673007..02f1ff3 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -131,9 +131,9 @@ typedef enum iomux_config {
>  #define MX53_PAD_JTAG_TDO__JTAG_TDO		IOMUX_PAD(0x454, NON_MUX_I, IOMUX_CONFIG_ALT0, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_A25__GPIO_5_2		IOMUX_PAD(0x458, 0x110,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_EB2__GPIO_2_30		IOMUX_PAD(0x45C, 0x114,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D16__GPIO_3_16		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D17__GPIO_3_17		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D18__GPIO_3_18		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D16__GPIO_3_16		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT4, 0x79c, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D17__GPIO_3_17		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT4, 0x7a0, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D18__GPIO_3_18		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT4, 0x7a4, 3, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D19__GPIO_3_19		IOMUX_PAD(0x46C, 0x124,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D20__GPIO_3_20		IOMUX_PAD(0x470, 0x128,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D21__GPIO_3_21		IOMUX_PAD(0x474, 0x12C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
> index 340937f..d7a8e52 100644
> --- a/arch/arm/plat-mxc/include/mach/mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/mx53.h
> @@ -56,7 +56,7 @@
>  #define MX53_ESDHC1_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00004000)
>  #define MX53_ESDHC2_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00008000)
>  #define MX53_UART3_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x0000C000)
> -#define MX53_CSPI1_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00010000)
> +#define MX53_ECSPI1_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00010000)
>  #define MX53_SSI2_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00014000)
>  #define MX53_ESDHC3_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00020000)
>  #define MX53_ESDHC4_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00024000)
> @@ -117,12 +117,12 @@
>  #define MX53_ARM_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A0000)
>  #define MX53_OWIRE_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A4000)
>  #define MX53_FIRI_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A8000)
> -#define MX53_CSPI2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000AC000)
> +#define MX53_ECSPI2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000AC000)
>  #define MX53_SDMA_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B0000)
>  #define MX53_SCC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B4000)
>  #define MX53_ROMCP_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B8000)
>  #define MX53_RTIC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000BC000)
> -#define MX53_CSPI3_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C0000)
> +#define MX53_CSPI_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C0000)
>  #define MX53_I2C2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C4000)
>  #define MX53_I2C1_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C8000)
>  #define MX53_SSI1_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000CC000)
> @@ -264,8 +264,8 @@
>  #define MX53_INT_UART3	33
>  #define MX53_INT_RESV34	34
>  #define MX53_INT_RESV35	35
> -#define MX53_INT_CSPI1	36
> -#define MX53_INT_CSPI2	37
> +#define MX53_INT_ECSPI1	36
> +#define MX53_INT_ECSPI2	37
>  #define MX53_INT_CSPI	38
>  #define MX53_INT_GPT	39
>  #define MX53_INT_EPIT1	40
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
