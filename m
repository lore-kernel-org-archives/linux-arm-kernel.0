From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 27 Sep 2011 11:08:04 +0200
Subject: [PATCH v3 4/4] ARM: mx53_ard: Add flexcan support
In-Reply-To: <1316712635-25126-4-git-send-email-rogerio.pimentel@freescale.com>
References: <1316712635-25126-1-git-send-email-rogerio.pimentel@freescale.com>
	<1316712635-25126-4-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <4E819274.7080206@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2011 07:30 PM, Rogerio Pimentel wrote:
> Adding flexcan support on i.MX53 ARD

You probably don't want to hardwire the gpios to the can transceiver as
enabled. I suggest to attach the transceiver_switch callback.

Have a look at arch/arm/mach-mxs/mach-mx28evk.c

cheers, Marc

> 
> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
> ---
> Changes since v2: 
> Rebased to imx-cleanup, using gpio_request_array
> instead gpio_request_one
>  arch/arm/mach-mx5/Kconfig          |    1 +
>  arch/arm/mach-mx5/board-mx53_ard.c |   39 ++++++++++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index b4f5ab6..c71731e 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -218,6 +218,7 @@ config MACH_MX53_LOCO
>  config MACH_MX53_ARD
>  	bool "Support MX53 ARD platforms"
>  	select SOC_IMX53
> +	select IMX_HAVE_PLATFORM_FLEXCAN
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> index ddc3015..e29bb23 100644
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
> @@ -169,16 +178,27 @@ static struct imxi2c_platform_data mx53_ard_i2c3_data = {
>  	.bitrate = 400000,
>  };
>  
> -static void __init mx53_ard_io_init(void)
> +static struct gpio mx53_ard_gpios[] = {
> +	{ ARD_ETHERNET_INT_B, GPIOF_IN, "eth-int-b" },
> +	{ ARD_I2CPORTEXP_B, GPIOF_OUT_INIT_HIGH, "i2cptexp-rst" },
> +	{ ARD_CAN_EN, GPIOF_OUT_INIT_HIGH, "can-en" },
> +	{ ARD_CAN_STBY, GPIOF_OUT_INIT_HIGH, "can-stby" },
> +};
> +
> +static int __init mx53_ard_io_init(void)
>  {
> +	int ret;
> +
>  	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
>  				ARRAY_SIZE(mx53_ard_pads));
>  
> -	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
> -	gpio_direction_input(ARD_ETHERNET_INT_B);
> +	ret = gpio_request_array(mx53_ard_gpios,
> +				ARRAY_SIZE(mx53_ard_gpios));
> +
> +	if (ret)
> +		return ret;
>  
> -	gpio_request(ARD_I2CPORTEXP_B, "i2cptexp-rst");
> -	gpio_direction_output(ARD_I2CPORTEXP_B, 1);
> +	return 0;
>  }
>  
>  /* Config CS1 settings for ethernet controller */
> @@ -222,10 +242,15 @@ static struct platform_device *devices[] __initdata = {
>  
>  static void __init mx53_ard_board_init(void)
>  {
> +	int ret;
> +
>  	imx53_soc_init();
>  	imx53_add_imx_uart(0, NULL);
>  
> -	mx53_ard_io_init();
> +	ret = mx53_ard_io_init();
> +	if (ret)
> +		pr_err("failed to request gpio pins: %d\n", ret);
> +
>  	weim_cs_config();
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  
> @@ -234,6 +259,8 @@ static void __init mx53_ard_board_init(void)
>  	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
>  	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
>  	imx_add_gpio_keys(&ard_button_data);
> +	imx53_add_flexcan0(NULL);
> +	imx53_add_flexcan1(NULL);
>  }
>  
>  static void __init mx53_ard_timer_init(void)


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110927/fae961d3/attachment.sig>
