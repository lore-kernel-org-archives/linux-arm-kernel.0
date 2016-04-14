From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Apr 2016 11:42:13 +0200
Subject: [PATCH RESEND 1/2] pinctrl: ns2: add pinmux driver support for
 Broadcom NS2 SoC
In-Reply-To: <CAL2FKYmAoaK=E8wrKc+sHPfM3cZ5O8GnZB2yfMx-GvUH3g1pKQ@mail.gmail.com>
References: <CAL2FKYmAoaK=E8wrKc+sHPfM3cZ5O8GnZB2yfMx-GvUH3g1pKQ@mail.gmail.com>
Message-ID: <CACRpkdYxE4UMB+AwHhUJ4cYAOget94zos_u4Z-j9obemPGewWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 9:53 AM, Yendapally Reddy Dhananjaya Reddy
<yendapally.reddy@broadcom.com> wrote:
> On Wed, Apr 13, 2016 at 6:49 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Mar 29, 2016 at 5:22 PM, Yendapally Reddy Dhananjaya Reddy
>> <yendapally.reddy@broadcom.com> wrote:

>>> +static const unsigned int gpio_0_1_pins[] = {24, 25};
>>> +static const unsigned int pwm_0_pins[] = {24};
>>> +static const unsigned int pwm_1_pins[] = {25};
>>
>> So either the same pins are used for GPIO or PWM.
>> And this pattern persists.
>>
>> Do you have a brewing GPIO driver for this block as well?
>> Is it a separate front-end calling to pinctrl using the
>> pinctrl_gpio_* calls or do you plan to patch it into this
>> driver?
>>
>> This is more of a question.
>>
>
> This SoC supports group based configuration and there is a top level register
> to select groups. Once the gpio_0_1_pins group is selected, there is one more
> register to select between gpio_0_1 and pwm (only four pins). The pins
> 24 and 25 are shared between nor pins and gpio at the top group level. Once
> gpio group is selected, then we can select to be either gpio or pwm. I missed
> these two pins to be added to nor_data_pins and will add in the next version.
>
> static const unsigned nor_data_pins[] =  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
>         10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25};
>
> NS2_PIN_GROUP(nand, 0, 0, 31, 1, 0),
> NS2_PIN_GROUP(nor_data, 0, 0, 31, 1, 1),
> NS2_PIN_GROUP(gpio_0_1, 0, 0, 31, 1, 0),
>
> To select PWM, we need to select gpio and pwm as well.
>
> gpio: gpio {
> function = "gpio";
> groups = "gpio_0_1_grp";
>
> pwm: pwm {
> function = "pwm";
> groups = "pwm0_grp", "pwm1_grp";
> };
>
> Already available gpio driver "pinctrl-iproc-gpio.c" will be the gpio driver
> for this soc as well without pin request.

Then you are doing something wrong. Look in pinctrl-iproc-gpio.c:

/*
 * Request the Iproc IOMUX pinmux controller to mux individual pins to GPIO
 */
static int iproc_gpio_request(struct gpio_chip *gc, unsigned offset)
{
        struct iproc_gpio *chip = gpiochip_get_data(gc);
        unsigned gpio = gc->base + offset;

        /* not all Iproc GPIO pins can be muxed individually */
        if (!chip->pinmux_is_supported)
                return 0;

        return pinctrl_request_gpio(gpio);
}

static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
{
        struct iproc_gpio *chip = gpiochip_get_data(gc);
        unsigned gpio = gc->base + offset;

        if (!chip->pinmux_is_supported)
                return;

        pinctrl_free_gpio(gpio);
}

So as you see pinctrl_request_gpio() and pinctrl_free_gpio()
are being called.

These will in turn call pinmux_request_gpio() and
pinmux_free_gpio() to make the backing pin controller
mux in the pin as GPIO.

pinmux_request_gpio() will end up in pin_request()
and at this point:

if (gpio_range && ops->gpio_request_enable)
                /* This requests and enables a single GPIO pin */
                status = ops->gpio_request_enable(pctldev, gpio_range, pin);

As you can see: it will attempt to call the .gpio_request_enable()
method of your struct pinmux_ops.

But your pinmux ops look like this:

+static struct pinmux_ops ns2_pinmux_ops = {
+       .get_functions_count = ns2_get_functions_count,
+       .get_function_name = ns2_get_function_name,
+       .get_function_groups = ns2_get_function_groups,
+       .set_mux = ns2_pinmux_enable,
+};

I.e. there is no way that GPIO can be set up as a GPIO line,
and you're relying on some other pin control entries in the
device tree to do that, which is unnecessarily complicated.

Please consider implementing the .gpio_request_enable callback
for this pin multiplexer.

Yours,
Linus Walleij
