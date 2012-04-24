From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 24 Apr 2012 08:39:07 -0400
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <CACRpkdZ4RSiqrHU60auvCx9xxZp5CQQzjis+Xz6EVMA+7-8_eg@mail.gmail.com>
References: <20120423072745.678323582@rtp-net.org>
 <201204231122.43481.arnd@arndb.de>
 <20120423174924.GA457@sirena.org.uk>
 <CACRpkdZ4RSiqrHU60auvCx9xxZp5CQQzjis+Xz6EVMA+7-8_eg@mail.gmail.com>
Message-ID: <CAKON4Oxa=h4DZapaOSX6=2soBDf1NMQhbkRdbzFcaim=a1T-ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 8:24 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 23, 2012 at 7:49 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Apr 23, 2012 at 11:22:43AM +0000, Arnd Bergmann wrote:
>>> On Monday 23 April 2012, Arnaud Patard wrote:
>>
>>> > Does anyone know how to solve that ?
>>
>>> One way to solve it would be to add a blink function to gpiolib so
>>> that the gpio-led driver can access it through a common wrapper
>>> and we can make the orion_gpio_set_blink() function a pointer in
>>> the gpio_chip structure rather than an export from
>>> arch/arm/plat-orion/gpio.c. I've put a few people on Cc that might
>>> have an opion on this.

I have a board here with a NXP PCA9532 on i2c.
http://www.nxp.com/documents/data_sheet/PCA9532.pdf
drivers/leds/leds-pca9532.c

Pins can be:
GPIO
hardware blinking LED
PWM for backlight

It might even be an interrupt source, but I haven't dug into it that deep.

>>
>> Another idea would be to use pinctrl and represent the blink as a
>> special function. ?Not sure that's sensible though.
>
> I would rather say that anything automatically toggling
> a GPIO pin on/off at specified intervals is HW-controlled
> GPIO PWM.
>
> So this would be something that gets to be modeled in the
> PWM subsystem, but there is no such thing (I know Sascha et
> al was working on that at one point.)
>
> But in my dreams it would be in
> drivers/pwm/pwm-gpio.c and then anything that needs
> an auto-toggling GPIO pin could use that PWM interface.
> And only then it would be given hooks into the gpio driver,
> like with some #ifdef in the .h file for gpiolib that expose
> this hook only to the PWM subsystem.
>
> But I guess I won't have it my way :-)
>
> Currently, drivers/leds/leds-gpio.c has a
> platform-specific callback to set blink period. How do we
> replace that with something that can call generic code on
> a larger scale?
>
> Maybe it should go into gpiolib then, but I'm not sure at
> all.
>
> BTW: can leds-pwm.c use leds-gpio.c and exploit the blink
> callback there? (I hope so...)
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Jon Smirl
jonsmirl at gmail.com
