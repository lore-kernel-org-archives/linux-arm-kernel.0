From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 01 Oct 2009 14:55:29 +1300
Subject: [PATCH] ep93xx: update i2c support
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42C7C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901D41F55@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D41F5D@mi8nycmail19.Mi8.com>	<4AC3BB1F.9050903@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C6B@mi8nycmail19.Mi8.com>	<4AC3C8D2.5060009@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42C7C@mi8nycmail19.Mi8.com>
Message-ID: <4AC40C11.4060401@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Update the ep93xx i2c support:
> 
>   1) The platform init code passes the configuration data for the
>      i2c-gpio driver.  This allows any gpio pin do be used for the
>      sda and scl pins.  It also allows the platform to specify the
>      udelay and timeout.
>   2) Program the gpio configuration register to enable/disable the
>      open drain drivers.  Note that this really only works if the
>      sda and scl pins are set to EP93XX_GPIO_LINE_EEDAT and
>      EP93XX_GPIO_LINE_EECLK.
>   3) Update the edb93xx.c platform init to use the new support.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> ---
> 
> -void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
> +void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
> +				struct i2c_board_info *devices, int num)
>  {
> +	ep93xx_i2c_data = *data;
> +
> +	/*
> +	 * Set the EEPROM interface pin drive type control.
> +	 * Defines the driver type for the EECLK and EEDAT pins as either
> +	 * open drain, which will require an external pull-up, or a normal
> +	 * CMOS driver.
> +	 */
> +	if (data->sda_is_open_drain && data->sda_pin != EP93XX_GPIO_LINE_EEDAT)
> +		printk("ep93xx: sda != EEDAT, open drain has no effect\n");
> +	if (data->scl_is_open_drain && data->scl_pin != EP93XX_GPIO_LINE_EECLK)
> +		printk("ep93xx: scl != EECLK, open drain has no effect\n");

pr_warning on these. Otherwise:

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
