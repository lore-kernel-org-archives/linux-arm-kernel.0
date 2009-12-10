From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Dec 2009 08:30:17 +0800
Subject: [PATCH] ARM: pxa/raumfeld: board support cleanups
In-Reply-To: <1260095301-29363-1-git-send-email-daniel@caiaq.de>
References: <1260095301-29363-1-git-send-email-daniel@caiaq.de>
Message-ID: <20091210003017.GI28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sun, Dec 06, 2009 at 11:28:21AM +0100, Daniel Mack wrote:
> Some minor things that I didn't notice in the original post.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Would be good if that one made it in, too.

In case your 'pending' branch is not being tracked by anyone, you can
also squash this into the original commit if you like.

Thanks,
Daniel


> ---
>  arch/arm/mach-pxa/raumfeld.c |   53 +++++++++++++++++++----------------------
>  1 files changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index f8457bb..7b33bca 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -584,8 +584,6 @@ static struct pxafb_mach_info raumfeld_sharp_lcd_info = {
>  	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
>  };
>  
> -static int gpio_display_enable = GPIO_DISPLAY_ENABLE;
> -
>  static void __init raumfeld_lcd_init(void)
>  {
>  	int ret;
> @@ -611,7 +609,7 @@ static void __init raumfeld_lcd_init(void)
>  	if (ret < 0)
>  		pr_warning("Unable to request GPIO_DISPLAY_ENABLE\n");
>  	else
> -		gpio_direction_output(gpio_display_enable, 1);
> +		gpio_direction_output(GPIO_DISPLAY_ENABLE, 1);
>  }
>  
>  /**
> @@ -693,14 +691,23 @@ static struct spi_board_info controller_spi_devices[] __initdata = {
>   * MMC for Marvell Libertas 8688 via SDIO
>   */
>  
> -static void raumfeld_mci_setpower(struct device *dev, unsigned int on)
> +static int raumfeld_mci_init(struct device *dev, irq_handler_t isr, void *data)
> +{
> +	gpio_set_value(GPIO_W2W_RESET, 1);
> +	gpio_set_value(GPIO_W2W_PDN, 1);
> +
> +	return 0;
> +}
> +
> +static void raumfeld_mci_exit(struct device *dev, void *data)
>  {
> -	gpio_set_value(GPIO_W2W_RESET, on);
> -	gpio_set_value(GPIO_W2W_PDN, on);
> +	gpio_set_value(GPIO_W2W_RESET, 0);
> +	gpio_set_value(GPIO_W2W_PDN, 0);
>  }
>  
>  static struct pxamci_platform_data raumfeld_mci_platform_data = {
> -	.setpower		= raumfeld_mci_setpower,
> +	.init			= raumfeld_mci_init,
> +	.exit			= raumfeld_mci_exit,
>  	.detect_delay		= 20,
>  	.gpio_card_detect	= -1,
>  	.gpio_card_ro		= -1,
> @@ -711,9 +718,6 @@ static struct pxamci_platform_data raumfeld_mci_platform_data = {
>   * External power / charge logic
>   */
>  
> -static int gpio_charge_dc_ok;
> -static int gpio_charge_usb_susp;
> -
>  static int power_supply_init(struct device *dev)
>  {
>  	return 0;
> @@ -725,7 +729,7 @@ static void power_supply_exit(struct device *dev)
>  
>  static int raumfeld_is_ac_online(void)
>  {
> -	return !gpio_get_value(gpio_charge_dc_ok);
> +	return !gpio_get_value(GPIO_CHARGE_DC_OK);
>  }
>  
>  static int raumfeld_is_usb_online(void)
> @@ -787,21 +791,18 @@ static void __init raumfeld_power_init(void)
>  	else
>  		gpio_direction_output(GPIO_CHRG_PEN2, 1);
>  
> -	gpio_charge_dc_ok = GPIO_CHARGE_DC_OK;
> -	gpio_charge_usb_susp = GPIO_CHARGE_USB_SUSP;
> -
> -	ret = gpio_request(gpio_charge_dc_ok, "CABLE_DC_OK");
> +	ret = gpio_request(GPIO_CHARGE_DC_OK, "CABLE_DC_OK");
>  	if (ret < 0)
>  		pr_warning("Unable to request GPIO_CHARGE_DC_OK\n");
>  
> -	ret = gpio_request(gpio_charge_usb_susp, "CHARGE_USB_SUSP");
> +	ret = gpio_request(GPIO_CHARGE_USB_SUSP, "CHARGE_USB_SUSP");
>  	if (ret < 0)
>  		pr_warning("Unable to request GPIO_CHARGE_USB_SUSP\n");
>  	else
> -		gpio_direction_output(gpio_charge_usb_susp, 0);
> +		gpio_direction_output(GPIO_CHARGE_USB_SUSP, 0);
>  
> -	power_supply_resources[0].start = gpio_to_irq(gpio_charge_dc_ok);
> -	power_supply_resources[0].end = gpio_to_irq(gpio_charge_dc_ok);
> +	power_supply_resources[0].start = gpio_to_irq(GPIO_CHARGE_DC_OK);
> +	power_supply_resources[0].end = gpio_to_irq(GPIO_CHARGE_DC_OK);
>  
>  	ret = request_irq(gpio_to_irq(GPIO_CHARGE_DONE),
>  			&charge_done_irq, IORESOURCE_IRQ_LOWEDGE,
> @@ -920,11 +921,9 @@ static struct i2c_board_info raumfeld_pwri2c_board_info = {
>  	.platform_data	= &max8660_pdata,
>  };
>  
> -static struct i2c_board_info raumfeld_connector_i2c_board_info[] __initdata = {
> -	{
> -		.type	= "cs4270",
> -		.addr	= 0x48,
> -	},
> +static struct i2c_board_info raumfeld_connector_i2c_board_info __initdata = {
> +	.type	= "cs4270",
> +	.addr	= 0x48,
>  };
>  
>  static struct eeti_ts_platform_data eeti_ts_pdata = {
> @@ -1040,8 +1039,7 @@ static void __init raumfeld_connector_init(void)
>  {
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_connector_pin_config));
>  	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
> -	i2c_register_board_info(0,
> -			ARRAY_AND_SIZE(raumfeld_connector_i2c_board_info));
> +	i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
>  
>  	platform_device_register(&smc91x_device);
>  
> @@ -1053,8 +1051,7 @@ static void __init raumfeld_speaker_init(void)
>  {
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_speaker_pin_config));
>  	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
> -	i2c_register_board_info(0,
> -			ARRAY_AND_SIZE(raumfeld_connector_i2c_board_info));
> +	i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
>  
>  	platform_device_register(&smc91x_device);
>  	platform_device_register(&rotary_encoder_device);
> -- 
> 1.6.5.2
> 
