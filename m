From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:06:48 +0100
Subject: [PATCH v5 11/17] ARM: sa1100: make collie use new locomo drivers
In-Reply-To: <1433797008-6246-12-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-12-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614150648.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:42PM +0300, Dmitry Eremin-Solenikov wrote:
> +static struct gpio collie_uart_gpio[] = {
> +	{ COLLIE_GPIO_CTS, GPIOF_IN, "CTS" },
> +	{ COLLIE_GPIO_RTS, GPIOF_OUT_INIT_LOW, "RTS" },
> +	{ COLLIE_GPIO_DTR, GPIOF_OUT_INIT_LOW, "DTR" },
> +	{ COLLIE_GPIO_DSR, GPIOF_IN, "DSR" },
> +};

These should probably be given a better name rather than just "CTS" -
maybe something that gives a clue as to what UART they refer to?

>  static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
>  {
> -	if (mctrl & TIOCM_RTS)
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 0);
> -	else
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 1);
> -
> -	if (mctrl & TIOCM_DTR)
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 0);
> -	else
> -		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 1);
> +	if (!collie_uart_gpio_ok) {
> +		int rc = gpio_request_array(collie_uart_gpio,
> +				ARRAY_SIZE(collie_uart_gpio));
> +		if (rc)
> +			pr_err("collie_uart_set_mctrl: gpio request %d\n", rc);
> +		else
> +			collie_uart_gpio_ok = true;
> +	}
> +
> +	if (collie_uart_gpio_ok) {

This seems to be a repeated chunk of code.  Maybe:

static bool collie_mctrl_present(void)
{
	static bool collie_uart_mctrl_claimed;

	if (!collie_uart_mctrl_claimed) {
		int rc = gpio_request_array(collie_uart_gpio,
					    ARRAY_SIZE(collie_uart_gpio));
		if (rc)
			pr_err("%s: gpio_request_array() failed: %d\n",
			       __func__, rc);
		else
			collie_uart_mctrl_claimed = true;
	}

	return collie_uart_mctrl_claimed;
}

static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
{
	if (collie_mctrl_present()) {

> +		gpio_set_value(COLLIE_GPIO_RTS, !(mctrl & TIOCM_RTS));
> +		gpio_set_value(COLLIE_GPIO_DTR, !(mctrl & TIOCM_DTR));
> +	}
>  }
>  
>  static u_int collie_uart_get_mctrl(struct uart_port *port)
>  {
>  	int ret = TIOCM_CD;
> -	unsigned int r;
>  
> -	r = locomo_gpio_read_output(&collie_locomo_device.dev, LOCOMO_GPIO_CTS & LOCOMO_GPIO_DSR);
> -	if (r == -ENODEV)
> +	if (!collie_uart_gpio_ok) {
> +		int rc = gpio_request_array(collie_uart_gpio,
> +				ARRAY_SIZE(collie_uart_gpio));
> +		if (rc)
> +			pr_err("collie_uart_get_mctrl: gpio request %d\n", rc);
> +		else
> +			collie_uart_gpio_ok = true;
> +	}
> +
> +	if (!collie_uart_gpio_ok)
>  		return ret;
> -	if (r & LOCOMO_GPIO_CTS)
> +
> +	if (gpio_get_value(COLLIE_GPIO_CTS))
>  		ret |= TIOCM_CTS;
> -	if (r & LOCOMO_GPIO_DSR)
> +	if (gpio_get_value(COLLIE_GPIO_DSR))
>  		ret |= TIOCM_DSR;
>  
>  	return ret;

And this would become:

	int TIOCM_CD;

	if (collie_mctrl_present()) {
		if (gpio_get_value(COLLIE_GPIO_CTS))
			ret |= TIOCM_CTS;
		if (gpio_get_value(COLLIE_GPIO_DSR))
			ret |= TIOCM_DSR;
	}

	return ret;

which kind'a looks neater, and avoids duplicating the GPIO claiming.

> @@ -191,33 +216,35 @@ static struct sa1100_port_fns collie_port_fns __initdata = {
>  	.get_mctrl	= collie_uart_get_mctrl,
>  };
>  
> -static int collie_uart_probe(struct locomo_dev *dev)
> -{
> -	return 0;
> -}
> -
> -static int collie_uart_remove(struct locomo_dev *dev)
> -{
> -	return 0;
> -}
> +static struct regulator_consumer_supply collie_amp_on_consumer_supplies[] = {
> +	REGULATOR_SUPPLY("VCC", "1-004e"),
> +};
>  
> -static struct locomo_driver collie_uart_driver = {
> -	.drv = {
> -		.name = "collie_uart",
> +static struct regulator_init_data collie_amp_on_init_data = {
> +	.constraints	= {
> +		.name	= "AMP_ON",
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>  	},
> -	.devid	= LOCOMO_DEVID_UART,
> -	.probe	= collie_uart_probe,
> -	.remove	= collie_uart_remove,
> +	.consumer_supplies = collie_amp_on_consumer_supplies,
> +	.num_consumer_supplies = ARRAY_SIZE(collie_amp_on_consumer_supplies),
>  };
>  
> -static int __init collie_uart_init(void)
> -{
> -	return locomo_driver_register(&collie_uart_driver);
> -}
> -device_initcall(collie_uart_init);
> -
> -#endif
> +static struct fixed_voltage_config collie_amp_on_data = {
> +	.supply_name	= "amp_on",
> +	.microvolts	= 3300000,
> +	.gpio		= COLLIE_GPIO_AMP2_ON,
> +	.startup_delay	= 5,
> +	.enable_high	= 1,
> +	.init_data	= &collie_amp_on_init_data,
> +};
>  
> +static struct platform_device collie_amp_on_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= -1,
> +	.dev = {
> +		.platform_data	= &collie_amp_on_data,
> +	},
> +};
>  
>  static struct resource locomo_resources[] = {
>  	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
> @@ -225,14 +252,15 @@ static struct resource locomo_resources[] = {
>  };
>  
>  static struct locomo_platform_data locomo_info = {
> -	.irq_base	= IRQ_BOARD_START,
> +	.gpio_base = COLLIE_LOCOMO_GPIO_BASE,
> +	.comadj	          = 128,

Using spaces for what looks like pointless indentation.  Please either
align the = signs using tabs, or don't bother at all.  As the rest of
the file's style is to align the = signs using tabs, please remain
consistent with the rest of the file unless you are intending to
reformat it - in which case, the reformatting should happen as the
very first patch.

>  };
>  
> -struct platform_device collie_locomo_device = {
> +static struct platform_device collie_locomo_device = {
>  	.name		= "locomo",
>  	.id		= 0,
>  	.dev		= {
> -		.platform_data	= &locomo_info,
> +		.platform_data  = &locomo_info,

You seem to replace a tab with two spaces here...

>  	},
>  	.num_resources	= ARRAY_SIZE(locomo_resources),
>  	.resource	= locomo_resources,
> @@ -270,7 +298,55 @@ static struct platform_device collie_gpio_keys_device = {
>  	},
>  };
>  
> +static int collie_mmc_init(struct device *dev,
> +		irqreturn_t (*isr)(int, void*), void *mmc)
> +{
> +	int ret;
> +
> +	ret = gpio_request(COLLIE_GPIO_CARD_POWER, "MMC power");
> +	if (!ret)
> +		ret = gpio_direction_output(COLLIE_GPIO_CARD_POWER, 0);
> +	if (ret)
> +		gpio_free(COLLIE_GPIO_CARD_POWER);
> +	return ret;

Why not use gpio_request_one() here?  This whole function could be
collapsed to just:

	return gpio_request_one(COLLIE_GPIO_CARD_POWER, GPIOF_OUT_INIT_LOW,
				"MMC power");

> +}
> +
> +static void collie_mmc_exit(struct device *dev, void *mmc)
> +{
> +	gpio_free(COLLIE_GPIO_CARD_POWER);
> +}
> +
> +static void collie_mmc_setpower(struct device *dev, unsigned int mask)
> +{
> +	gpio_set_value(COLLIE_GPIO_CARD_POWER, !!mask);
> +}
> +
> +static struct mmc_spi_platform_data collie_mmc_data = {
> +	.init		= collie_mmc_init,
> +	.exit		= collie_mmc_exit,
> +	.setpower	= collie_mmc_setpower,
> +	.detect_delay	= 200,
> +	.powerup_msecs  = 200,
> +	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.flags		= MMC_SPI_USE_CD_GPIO | MMC_SPI_USE_RO_GPIO,
> +	.cd_gpio	= COLLIE_GPIO_CARD_DETECT,
> +	.ro_gpio	= COLLIE_GPIO_CARD_RO,
> +	.caps2		= MMC_CAP2_RO_ACTIVE_HIGH,
> +};
> +
> +static struct spi_board_info collie_spi_board_info[] __initdata = {
> +	{
> +		.modalias	= "mmc_spi",
> +		.platform_data	= &collie_mmc_data,
> +		.max_speed_hz	= 25000000,
> +		.bus_num	= 0,
> +		.chip_select	= 0,
> +		.mode		= SPI_MODE_0,
> +	},
> +};
> +
>  static struct platform_device *devices[] __initdata = {
> +	&collie_amp_on_device,
>  	&collie_locomo_device,
>  	&colliescoop_device,
>  	&collie_power_device,
> @@ -347,10 +423,39 @@ static struct sa1100fb_mach_info collie_lcd_info = {
>  
>  	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
>  	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
> +};
>  
> -#ifdef CONFIG_BACKLIGHT_LOCOMO
> -	.lcd_power	= locomolcd_power
> -#endif
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
> +static struct gpiod_lookup_table collie_bl_gpios_table = {
> +	.dev_id = "locomo-backlight.0",
> +	.table = {
> +		GPIO_LOOKUP("locomo-gpio", 9, "flvr", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +}, collie_lcd_gpios_table = {

Please don't do this.  Please phrase this instead as:

};

static struct gpiod_lookup_table collie_lcd_gpios_table = {

> +	.dev_id = "locomo-lcd.0",
> +	.table = {
> +		GPIO_LOOKUP("locomo-gpio", 4, "VSHA", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 5, "VSHD", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 6, "Vee", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("locomo-gpio", 7, "MOD", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
>  };

...
-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
