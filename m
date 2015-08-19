From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 Aug 2015 20:41:43 +0200
Subject: [PATCH v2 06/21] ARM: pxa: magician: Add normal and power I2C
 definition
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D2593A.5060400@tul.cz>
Message-ID: <87mvxn6ryw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> @@ -873,10 +875,39 @@ static struct platform_device strataflash = {
>   */
>  
>  static struct i2c_pxa_platform_data i2c_info = {
> -	.fast_mode = 1,
> +	.fast_mode = 0,	/* fast mode seems to be have bit errors */
> +	.use_pio = 0, /* no polling */
This deserves a better commit message : why the switch out of fast_mode, what
was not working, etc ...

> +/*
> + * GPIO I2C normal controller (alternative)
> + */
> +
> +static struct i2c_gpio_platform_data rtc_device_data = {
> +	.sda_pin = GPIO118_MAGICIAN_I2C_SDA,
> +	.scl_pin = GPIO117_MAGICIAN_I2C_SCL,
> +	.udelay = 100
> +};
> +
> +static struct platform_device i2c_gpio_bus_alt = {
> +	.name = "i2c-gpio",
> +	.id = 0,
> +	.dev = {
> +		.platform_data = &rtc_device_data,
rtc_device_data, really ?
Can you add __initdata, I think i2c-gpio copies the data and doesn't use it
anymore after ?

Cheers.

-- 
Robert
