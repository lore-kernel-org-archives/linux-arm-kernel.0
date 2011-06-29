From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Jun 2011 20:44:59 +0800
Subject: [PATCH 1/2] ARM:mach-mx5/board-mx51_babbage: Add CD and WP GPIOs
In-Reply-To: <1307722520-12952-2-git-send-email-andre.silva@freescale.com>
References: <1307722520-12952-1-git-send-email-andre.silva@freescale.com>
	<1307722520-12952-2-git-send-email-andre.silva@freescale.com>
Message-ID: <20110629124458.GA25931@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Just let you know that SD/MMC driver on your for-next is broken for
all mx5 based boards, because adding esdhc platform data for mx5 will
get sdhci-esdhc-imx driver probe function fail on "goto not_supported".

Hopefully, Chris will get the series below applied soon, which will
get the driver back to work for mx5.

  [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
  support for mx5

Regards,
Shawn

On Fri, Jun 10, 2011 at 01:15:20PM -0300, Andre Silva wrote:
> Signed-off-by: Andre Silva <andre.silva@freescale.com>
> 
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |   24 +++++++++++++++++++++---
>  1 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 770f74b..3e58d5d 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -41,6 +41,10 @@
>  #define BABBAGE_POWER_KEY	IMX_GPIO_NR(2, 21)
>  #define BABBAGE_ECSPI1_CS0	IMX_GPIO_NR(4, 24)
>  #define BABBAGE_ECSPI1_CS1	IMX_GPIO_NR(4, 25)
> +#define BABBAGE_SD1_CD		IMX_GPIO_NR(1, 0)
> +#define BABBAGE_SD1_WP		IMX_GPIO_NR(1, 1)
> +#define BABBAGE_SD2_CD		IMX_GPIO_NR(1, 6)
> +#define BABBAGE_SD2_WP		IMX_GPIO_NR(1, 5)
>  
>  /* USB_CTRL_1 */
>  #define MX51_USB_CTRL_1_OFFSET			0x10
> @@ -142,7 +146,9 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
>  	MX51_PAD_SD1_DATA1__SD1_DATA1,
>  	MX51_PAD_SD1_DATA2__SD1_DATA2,
>  	MX51_PAD_SD1_DATA3__SD1_DATA3,
> -
> +	MX51_PAD_GPIO1_0__GPIO1_0,
> +	MX51_PAD_GPIO1_1__GPIO1_1,
> +
>  	/* SD 2 */
>  	MX51_PAD_SD2_CMD__SD2_CMD,
>  	MX51_PAD_SD2_CLK__SD2_CLK,
> @@ -150,6 +156,8 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
>  	MX51_PAD_SD2_DATA1__SD2_DATA1,
>  	MX51_PAD_SD2_DATA2__SD2_DATA2,
>  	MX51_PAD_SD2_DATA3__SD2_DATA3,
> +	MX51_PAD_GPIO1_6__GPIO1_6,
> +	MX51_PAD_GPIO1_5__GPIO1_5,
>  
>  	/* eCSPI1 */
>  	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
> @@ -331,6 +339,16 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
>  	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
>  };
>  
> +static const struct esdhc_platform_data mx51_babbage_sd1_data __initconst = {
> +	.cd_gpio = BABBAGE_SD1_CD,
> +	.wp_gpio = BABBAGE_SD1_WP,
> +};
> +
> +static const struct esdhc_platform_data mx51_babbage_sd2_data __initconst = {
> +	.cd_gpio = BABBAGE_SD2_CD,
> +	.wp_gpio = BABBAGE_SD2_WP,
> +};
> +
>  /*
>   * Board specific initialization.
>   */
> @@ -374,8 +392,8 @@ static void __init mx51_babbage_init(void)
>  	mxc_iomux_v3_setup_pad(usbh1stp);
>  	babbage_usbhub_reset();
>  
> -	imx51_add_sdhci_esdhc_imx(0, NULL);
> -	imx51_add_sdhci_esdhc_imx(1, NULL);
> +	imx51_add_sdhci_esdhc_imx(0, &mx51_babbage_sd1_data);
> +	imx51_add_sdhci_esdhc_imx(1, &mx51_babbage_sd2_data);
>  
>  	spi_register_board_info(mx51_babbage_spi_board_info,
>  		ARRAY_SIZE(mx51_babbage_spi_board_info));
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
