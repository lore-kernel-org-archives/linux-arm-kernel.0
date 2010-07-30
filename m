From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Fri, 30 Jul 2010 09:14:30 +0900
Subject: [PATCH 1/2] ARM: S5PV210: Add audio support to Aquila
In-Reply-To: <4C52053A.8090400@simtec.co.uk>
References: <4C4F9E4C.7000001@samsung.com>
	<4C52053A.8090400@simtec.co.uk>
Message-ID: <AANLkTimiLMqJ1qewOGr6jy=MhAgQpM0Z1yxYYz4xeraL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 7:48 AM, Ben Dooks <ben@simtec.co.uk> wrote:
> On 28/07/10 04:04, Chanwoo Choi wrote:
>
> [snip]
>
>
>> +/* GPIO I2C AP 1.8V */
>> +#define AP_I2C_GPIO_BUS_5 ? ?5
>> +static struct i2c_gpio_platform_data i2c_gpio5_data = {
>> + ? ? .sda_pin ? ? ? ?= S5PV210_MP05(3), ? ? ?/* XM0ADDR_11 */
>> + ? ? .scl_pin ? ? ? ?= S5PV210_MP05(2), ? ? ?/* XM0ADDR_10 */
>> +};
>> +
>> +static struct platform_device i2c_gpio5 = {
>> + ? ? .name ? ? ? ? ? = "i2c-gpio",
>> + ? ? .id ? ? ? ? ? ? = AP_I2C_GPIO_BUS_5,
>> + ? ? .dev ? ? ? ? ? ?= {
>> + ? ? ? ? ? ? .platform_data ?= &i2c_gpio5_data,
>> + ? ? },
>> +};
>> +
>> +static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? /* CS/ADDR = low 0x34 (FYI: high = 0x36) */
>> + ? ? ? ? ? ? I2C_BOARD_INFO("wm8994", 0x34 >> 1),
>> + ? ? ? ? ? ? .platform_data ?= &wm8994_platform_data,
>> + ? ? },
>> +};
>> +
>> +static void __init aquila_sound_init(void)
>> +{
>> + ? ? unsigned int gpio;
>> +
>> + ? ? /* CODEC_XTAL_EN */
>> + ? ? gpio = S5PV210_GPH3(2); ? ? ? ? /* XEINT_26 */
>> + ? ? gpio_request(gpio, "CODEC_XTAL_EN");
>> + ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
>> + ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
>> + ? ? gpio_direction_output(gpio, 1);
>
> gpio_direction_output() should have done the cfgpin()
> call.

Good catch. Thanks.

I think we required that extend the current gpiolib to support the
setpull like functions. also sleep gpio pin configuration.
Marek or shim? do you have any ideas?

>
>> + ? ? /* CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS)
>> + ? ? ?* for 24MHZ
>> + ? ? ?*/
>> + ? ? writel(readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
>
> Not sure if this should be being done directly? will it affect
> the current clock tree?

It's almost done by bootloader. but we make sure it's really routed
the CLKOUT to XUSBXTI.

Thank you,
Kyungmin Park

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
