From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Sep 2017 10:47:59 +0200
Subject: [PATCH 0/8] pinctrl: meson: clean pin offsets
In-Reply-To: <1506006009.2703.175.camel@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <CACRpkdYmO2PSKU-qkBMW7C35kHf=usfOoEAobQDMMdzd1RFSTw@mail.gmail.com>
 <1506006009.2703.175.camel@baylibre.com>
Message-ID: <CACRpkdb+gv+LALF-3wL8AHRC02LF5KHXqSO7=4De-tW4p43=og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 5:00 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> After doing this rework, I noticed that this driver (not the only one though)
> assume gpio offset (param of gpio calls) and pin offset are the same thing ...
> instead of relying pinctrl (and gpio-ranges) to do the translation.

Hm yeah I guess drivers tend to do that if the two are identical.

> To make things a bit more clean, I was thinking about forwarding all gpios
> framework calls to pinconf, so the gpio to pin offset would go through the
> proper mapping function.
>
> Is this the way to do it ?
>
> Using gpio_pinctrl_set_config() I should be able to achieve almost any "write"
> functions but I got stuck on gpio_get()

The intention is not to let pin config be the solve-all backend for
combined GPIO drivers, we still want separation of concerns.

The idea is that the GPIO part of the driver still drive a line high/low
and that means it can also handle things like .set_multiple() to set
several lines at once. There is also .get_multiple() in the works.

I do not think these things should be relayed to pin config,
pin config is not for driving GPIO lines, only for setting up
the electrical properties of them.

What we have is optional pin config back-end to set direction
and set configs such as debounce or open drain by relaying
the gpiochip .set_config() callback to pinctrl_gpio_set_config().
This function is in <linux/pinctrl/consumer.h> for a reason: the
GPIO driver is a consumer of pinctrl services.

These:
extern int pinctrl_request_gpio(unsigned gpio);
extern void pinctrl_free_gpio(unsigned gpio);
extern int pinctrl_gpio_direction_input(unsigned gpio);
extern int pinctrl_gpio_direction_output(unsigned gpio);
extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);

Hm I should rename the first two to pinctrl_gpio_request()
and pinctrl_gpio_free() don't you think... My OCD kicks in.

Anyways: as you can see we even have special callbacks
to set the lines as input and output, we do not use the
pin config calls with parameters PIN_CONFIG_OUTPUT
and there isn't even a corresponding PIN_CONFIG_INPUT
that will really set the pin to input mode for GPIO.
And that would have been the first refactoring here
(getting rid of pinctrl_gpio_direction*).

That is already a bit of a daunting task, and I don't even
know if it makes sense :/

Relaying setting the output value or getting the input
value to pinctrl doesn't make sense to me at all.

> ATM the moment there is no gpio_pinctrl_get_config() or something similar to
> read stuff in the gpio framework from pinconf. Would you be open to add
> something like this ?

I do not see the use case, but if you can describe it I can respond.

.pin_config_get() in <linux/pinctrl/pinconf.h> is already seldom
implemented correctly and drivers do not read out the hardware
state at probe() time. And they don't read out the mux setting
at all, ever, just set it.

Yours,
Linus Walleij
