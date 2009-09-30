From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 30 Sep 2009 16:18:43 -0400
Subject: [PATCH] ep93xx: update i2c support
In-Reply-To: <4AC3BB1F.9050903@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901D41F55@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41F5D@mi8nycmail19.Mi8.com>
	<4AC3BB1F.9050903@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42C57@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 30, 2009 1:10 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> Update the ep93xx i2c support to allow the platform init to configure
>> the sda and scl pins as open drain or normal cmos drivers.  Also allow
>> the platform to set the udelay and timeout for the i2c-gpio driver.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>
>> ---
>>
>> V2 - __raw_write should be __raw_writel
>>
>>
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index 16b92c3..49e74b6 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -549,12 +549,13 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
>>  	platform_device_register(&ep93xx_eth_device);
>>  }
>>  
>> +
>> +/*************************************************************************
>> + * EP93xx i2c peripheral handling
>> + *************************************************************************/
>>  static struct i2c_gpio_platform_data ep93xx_i2c_data = {
>>  	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
>> -	.sda_is_open_drain	= 0,
>>  	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
>> -	.scl_is_open_drain	= 0,
>> -	.udelay			= 2,
>>  };
>>  
>>  static struct platform_device ep93xx_i2c_device = {
>> @@ -563,8 +564,32 @@ static struct platform_device ep93xx_i2c_device = {
>>  	.dev.platform_data	= &ep93xx_i2c_data,
>>  };
>>  
>> -void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
>> +void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num,
>> +				int sda_is_open_drain, int scl_is_open_drain,
>> +				int udelay, int timeout)
>>  {
>> +	/*
>> +	 * Set the EEPROM interface pin drive type control.
>> +	 * Defines the driver type for the EECLK and EEDAT pins as either
>> +	 * open drain, which will require an external pull-up, or a normal
>> +	 * CMOS driver.
>> +	 */
>> +	ep93xx_i2c_data.sda_is_open_drain = sda_is_open_drain;
>> +	ep93xx_i2c_data.scl_is_open_drain = scl_is_open_drain;
>> +
>> +	__raw_writel((sda_is_open_drain<<1) | (scl_is_open_drain<<0)),
>> +			EP93XX_GPIO_EEDRIVE);
>> +
>> +	/*
>> +	 * udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
>> +	 *         == 0 will default to 5 (100 khz)
>> +	 * timeout: clock stretching timeout in jiffies. If the slave keeps
>> +	 *          SCL low for longer than this, the transfer will time out.
>> +	 *          == 0 will default to HZ / 10 (100 ms)
>> +	 */
>> +	ep93xx_i2c_data.udelay = udelay;
>> +	ep93xx_i2c_data.timeout = timeout;
>> +
>>  	i2c_register_board_info(0, devices, num);
>>  	platform_device_register(&ep93xx_i2c_device);
>>  }
>>
>>   
> I find this a bit ugly since you basically use the register_i2c function
> to fill in the struct elements. Why not just let each board fill in the
> i2c platform data itself. This is more consistent with the other device
> registration functions and also allows boards to use other gpio pins for
> i2c if they want, ie (untested):
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 681bd68..a5bf12d 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -550,13 +550,7 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
>  	platform_device_register(&ep93xx_eth_device);
>  }
>  
> -static struct i2c_gpio_platform_data ep93xx_i2c_data = {
> -	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
> -	.sda_is_open_drain	= 0,
> -	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
> -	.scl_is_open_drain	= 0,
> -	.udelay			= 2,
> -};
> +static struct i2c_gpio_platform_data ep93xx_i2c_data;
>  
>  static struct platform_device ep93xx_i2c_device = {
>  	.name			= "i2c-gpio",
> @@ -564,8 +558,13 @@ static struct platform_device ep93xx_i2c_device = {
>  	.dev.platform_data	= &ep93xx_i2c_data,
>  };
>  
> -void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
> +void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *pdata,
> +				struct i2c_board_info *devices, int num)
>  {
> +	ep93xx_i2c_data = *pdata;
> +	__raw_writel((ep9xx_i2c_data.sda_is_open_drain << 1) |
> +		     (ep9xx_i2c_data.scl_is_open_drain << 0), 
> +		     EP93XX_GPIO_EEDRIVE);
>  	i2c_register_board_info(0, devices, num);
>  	platform_device_register(&ep93xx_i2c_device);
>  }
> 
> Obviously the board files also need to be fixed up.
> 

Good point about using gpio pins other than EEDAT and EECLK.  For instance
the TS-7200 board doesn't have the pins accessible but there is a patch on
the yahoo site that uses two of the pins on their DIO port.

I will modify the patch and repost.

Thanks,
Hartley
