From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Sep 2011 12:38:53 +0200
Subject: [PATCH v2 4/4] ARM: mx53_ard: Add flexcan support
In-Reply-To: <1315598408-29563-4-git-send-email-rogerio.pimentel@freescale.com>
References: <1315598408-29563-1-git-send-email-rogerio.pimentel@freescale.com>
	<1315598408-29563-4-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <20110919103853.GO31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 05:00:08PM -0300, Rogerio Pimentel wrote:
> Adding flexcan support on i.MX53 ARD
> 
> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
> ---
> Changes since v1: 
> Changed pull-up pad config from iomux-mx53.h to board-mx53_ard.c
> Created a function to request CAN pins
> If pins cannot be requested, flexcan will not be registered
>  arch/arm/mach-mx5/Kconfig          |    1 +
>  arch/arm/mach-mx5/board-mx53_ard.c |   37 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index fb4c503..7c911d1 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -205,6 +205,7 @@ config MACH_MX53_LOCO
>  config MACH_MX53_ARD
>  	bool "Support MX53 ARD platforms"
>  	select SOC_IMX53
> +	select IMX_HAVE_PLATFORM_FLEXCAN
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> index 76a67c4..3b5d77e 100644
> --- a/arch/arm/mach-mx5/board-mx53_ard.c
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -44,6 +44,8 @@
>  #define ARD_BACK			IMX_GPIO_NR(5, 11)
>  #define ARD_PROG			IMX_GPIO_NR(5, 12)
>  #define ARD_VOLUMEUP		IMX_GPIO_NR(5, 13)
> +#define ARD_CAN_EN		IMX_GPIO_NR(7, 6)
> +#define ARD_CAN_STBY		IMX_GPIO_NR(4, 15)
>  
>  static iomux_v3_cfg_t mx53_ard_pads[] = {
>  	/* UART1 */
> @@ -102,6 +104,13 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
>  	MX53_PAD_DISP0_DAT18__GPIO5_12,	/* prog */
>  	MX53_PAD_DISP0_DAT19__GPIO5_13,	/* vol up */
>  	MX53_PAD_GPIO_10__GPIO4_0,		/* vol down */
> +	/* CAN */
> +	MX53_PAD_KEY_COL2__CAN1_TXCAN | PAD_CTL_PUS_100K_UP,
> +	MX53_PAD_KEY_ROW2__CAN1_RXCAN,
> +	MX53_PAD_PATA_RESET_B__CAN2_TXCAN | PAD_CTL_PUS_100K_UP,
> +	MX53_PAD_PATA_IORDY__CAN2_RXCAN,
> +	MX53_PAD_PATA_DA_0__GPIO7_6,
> +	MX53_PAD_KEY_ROW4__GPIO4_15,
>  };
>  
>  #define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
> @@ -181,6 +190,25 @@ static void __init mx53_ard_io_init(void)
>  	gpio_direction_output(ARD_I2CPORTEXP_B, 1);
>  }
>  
> +static int __init mx53_ard_flexcan_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request_one(ARD_CAN_EN, GPIOF_OUT_INIT_HIGH, "can-en");
> +	if (ret) {
> +		pr_err("Cannot request ARD_CAN_EN pin: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpio_request_one(ARD_CAN_STBY, GPIOF_OUT_INIT_HIGH, "can-stby");
> +	if (ret) {
> +		pr_err("Cannot request ARD_CAN_STBY pin: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

How about using gpio_request_array instead? Also, we could move
ARD_ETHERNET_INT_B and ARD_I2CPORTEXP_B into this array aswell so that
we do not request all gpios in device specific functions, but have
one board specific gpio request function instead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
