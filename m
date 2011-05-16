From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 May 2011 02:09:20 +0200
Subject: [PATCH] drivers: create a pinmux subsystem v2
In-Reply-To: <20110510235853.GM26703@pulham.picochip.com>
References: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
	<20110510235853.GM26703@pulham.picochip.com>
Message-ID: <BANLkTim5wurV7aFSm4ae6+HBpGZO1z_=XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/11 Jamie Iles <jamie@jamieiles.com>:
> [...]
>> +static struct foo_pmx_func myfuncs[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .name = "spi0-0",
>> + ? ? ? ? ? ? .pins = spi0_0_pins,
>> + ? ? ? ? ? ? .num_pins = ARRAY_SIZE(spi0_1_pins),
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name = "i2c0",
>> + ? ? ? ? ? ? .pins = i2c0_pins,
>> + ? ? ? ? ? ? .num_pins = ARRAY_SIZE(i2c0_pins),
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name = "spi0-1",
>> + ? ? ? ? ? ? .pins = spi0_1_pins,
>> + ? ? ? ? ? ? .num_pins = ARRAY_SIZE(spi0_1_pins),
>> + ? ? },
>> +};
>
> So I can see how this works well for these examples, but on our devices,
> we have some interfaces for connecting to radios and these have a pair
> of 8-bit RX and TX busses. ?However, depending on what radio you
> connect, you may not need all 8 bits of each and this is dependent on
> the board. ?What would be the best way to deal with that in this scheme
> where say we only wanted 4 bits of each, saving the others for GPIO?
> Would this need to be a function for each configuration?

Yes. Define a function containing the pins you need, then when that
function is muxed in by pinmux_get() the remaining pins are still
available for GPIO.

The framework only deals with functions as groups of pins and
individual GPIO pins, defining the groups is currently up to each
platform.

> [...]
>> +/**
>> + * pinmux_request_gpio() - request a single pin to be muxed in to be used
>> + * ? as a GPIO pin
>> + * @pin: the pin to mux in as GPIO
>> + * @gpio: the corresponding GPIO pin number
>> + */
>> +int pinmux_request_gpio(int pin, unsigned gpio)
>> +{
>> + ? ? char gpiostr[16];
>> +
>> + ? ? snprintf(gpiostr, 15, "gpio%d", gpio);
>> + ? ? return pin_request(pin, gpiostr, true);
>> +}
>> +EXPORT_SYMBOL_GPL(pinmux_request_gpio);
>
> Our devices have two different GPIO controllers, which can be muxed to
> the same pad (they're slightly different - one is a bit slower but can
> do sigma-delta output) and our pinmux driver would need to know what
> GPIO controller it should route to the pad. ?Could gpio_request_enable()
> be passed the GPIO number or is there a better way to do this?

Hmmmm that was really new!

But like we have the more complex config function for pinmux groups:
extern int pinmux_config(struct pinmux *pmx, u16 param, unsigned long *data);

I believe your case could be handled with a similar more complex
per-pin config function like this:
extern int pinmux_config_gpio(int pin, unsigned gpio, u16 param,
unsigned long *data);

Would that work?

Not that I like to sprinkle the ioctl()-like config functions all over the place
but these two would likely cover all special cases.

Linus Walleij
