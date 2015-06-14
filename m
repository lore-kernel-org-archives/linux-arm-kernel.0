From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:08:17 +0100
Subject: [PATCH v5 14/17] ARM: pxa: poodle: use new LoCoMo driver
In-Reply-To: <1433797008-6246-15-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-15-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614150817.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:45PM +0300, Dmitry Eremin-Solenikov wrote:
> @@ -179,7 +181,8 @@ static struct resource locomo_resources[] = {
>  };
>  
>  static struct locomo_platform_data locomo_info = {
> -	.irq_base	= IRQ_BOARD_START,
> +	.gpio_base	  = -1,
> +	.comadj	          = 118,

More space vs tabs madness.  Please keep to the original file's style
when editing, it's important.

>  };
>  
>  struct platform_device poodle_locomo_device = {
> @@ -192,8 +195,6 @@ struct platform_device poodle_locomo_device = {
>  	},
>  };
>  
> -EXPORT_SYMBOL(poodle_locomo_device);
> -
>  #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
>  static struct pxa2xx_spi_master poodle_spi_info = {
>  	.num_chipselect	= 1,
> @@ -424,6 +425,47 @@ static struct i2c_board_info __initdata poodle_i2c_devices[] = {
>  	{ I2C_BOARD_INFO("wm8731", 0x1b) },
>  };
>  
> +static struct iio_map locomo_iio_map[] = {
> +	{
> +		.consumer_dev_name = "locomo-lcd.0",
> +		.consumer_channel = "comadj",
> +		.adc_channel_label = "CH0",
> +	},
> +	{ }
> +};
> +
> +static struct i2c_board_info locomo_i2c_devs[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("m62332", 0x4e),
> +		.platform_data = locomo_iio_map,
> +	},
> +};
> +
> +static struct gpiod_lookup_table poodle_audio_gpios_table = {
> +	.dev_id = "poodle-audio",
> +	.table = {
> +		GPIO_LOOKUP("locomo-gpio", 10, "mute-l", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("locomo-gpio", 11, "mute-r", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("locomo-gpio", 8, "amp-on", GPIO_ACTIVE_LOW),
> +		{ },
> +	},
> +}, poodle_bl_gpios_table = {

Same comment as previous patch...

> +	.dev_id = "locomo-backlight.0",
> +	.table = {
> +		GPIO_LOOKUP("locomo-gpio", 9, "flvr", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +}, poodle_lcd_gpios_table = {

Ditto...

> +	.dev_id = "locomo-lcd.0",
> +	.table = {
> +		GPIO_LOOKUP("locomo-gpio", 4, "VSHA", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 5, "VSHD", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 6, "Vee", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 7, "MOD", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static void poodle_poweroff(void)
>  {
>  	pxa_restart(REBOOT_HARD, NULL);
> @@ -445,6 +487,13 @@ static void __init poodle_init(void)
>  
>  	platform_scoop_config = &poodle_pcmcia_config;
>  
> +	if (sharpsl_param.comadj != -1)
> +		locomo_info.comadj = sharpsl_param.comadj;
> +
> +	gpiod_add_lookup_table(&poodle_audio_gpios_table);
> +	gpiod_add_lookup_table(&poodle_bl_gpios_table);
> +	gpiod_add_lookup_table(&poodle_lcd_gpios_table);
> +
>  	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
>  	if (ret)
>  		pr_warn("poodle: Unable to register LoCoMo device\n");
> @@ -455,6 +504,7 @@ static void __init poodle_init(void)
>  	pxa_set_ficp_info(&poodle_ficp_platform_data);
>  	pxa_set_i2c_info(NULL);
>  	i2c_register_board_info(0, ARRAY_AND_SIZE(poodle_i2c_devices));
> +	i2c_register_board_info(1, ARRAY_AND_SIZE(locomo_i2c_devs));
>  	poodle_init_spi();
>  	regulator_has_full_constraints();
>  }
> -- 
> 2.1.4
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
