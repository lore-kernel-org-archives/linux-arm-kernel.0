From: B22958@freescale.com (Silva Andre-B22958)
Date: Sat, 11 Jun 2011 16:59:39 +0000
Subject: [PATCH 2/2] ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs
In-Reply-To: <20110611165856.GD29093@S2100-06.ap.freescale.net>
References: <1307722520-12952-1-git-send-email-andre.silva@freescale.com>,
	<20110611165856.GD29093@S2100-06.ap.freescale.net>
Message-ID: <2952C0A749B3034EA13D670115D4FEC8F1A0C4@039-SN1MPN1-005.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

The tests was done simpling inserting and removing the SD card, 
since before no parameters were passed to the  imx53_add_sdhci_esdhc_imx and the controller was able to detect the card via software. When setting up the iomux (CD) pin and passing it to the  imx53_add_sdhci_esdhc_imx function, it should be able to start detecting the card using the pin instead.

the same test was made for [PATCH1/2].

regards,

Andre
________________________________________
From: Guo Shawn-R65073
Sent: Saturday, June 11, 2011 1:58 PM
To: Silva Andre-B22958
Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de
Subject: Re: [PATCH 2/2] ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs

On Fri, Jun 10, 2011 at 01:15:19PM -0300, Andre Silva wrote:
> Signed-off-by: Andre Silva <andre.silva@freescale.com>
>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index e5e8c85..52cb150 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -39,6 +39,9 @@
>  #define MX53_LOCO_UI2                        IMX_GPIO_NR(2, 15)
>  #define LOCO_FEC_PHY_RST             IMX_GPIO_NR(7, 6)
>  #define LOCO_LED                     IMX_GPIO_NR(7, 7)
> +#define LOCO_SD3_CD                  IMX_GPIO_NR(3, 11)
> +#define LOCO_SD3_WP                  IMX_GPIO_NR(3, 12)
> +#define LOCO_SD1_CD                  IMX_GPIO_NR(3, 13)
>
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>       /* FEC */
> @@ -71,6 +74,8 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
>       MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
>       MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
>       MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
> +     /* SD1_CD */
> +     MX53_PAD_EIM_DA13__GPIO3_13,
>       /* SD3 */
>       MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
>       MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
> @@ -203,6 +208,15 @@ static const struct gpio_keys_platform_data loco_button_data __initconst = {
>       .nbuttons       = ARRAY_SIZE(loco_buttons),
>  };
>
> +static const struct esdhc_platform_data mx53_loco_sd1_data __initconst = {
> +     .cd_gpio = LOCO_SD1_CD,
> +};
> +
> +static const struct esdhc_platform_data mx53_loco_sd3_data __initconst = {
> +     .cd_gpio = LOCO_SD3_CD,
> +     .wp_gpio = LOCO_SD3_WP,
> +};
> +
>  static inline void mx53_loco_fec_reset(void)
>  {
>       int ret;
> @@ -249,8 +263,8 @@ static void __init mx53_loco_board_init(void)
>       imx53_add_imx2_wdt(0, NULL);
>       imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
>       imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
> -     imx53_add_sdhci_esdhc_imx(0, NULL);
> -     imx53_add_sdhci_esdhc_imx(2, NULL);
> +     imx53_add_sdhci_esdhc_imx(0, &mx53_loco_sd1_data);
> +     imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
>       imx_add_gpio_keys(&loco_button_data);
>       gpio_led_register_device(-1, &mx53loco_leds_data);
>  }
> --
> 1.7.1
>
The sdhci-esdhc-imx driver currently only supports CD and WP for mx25
and mx35.  How did you test the patch?

--
Regards,
Shawn
