From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 13:28:52 +0100
Subject: [PATCH 1/2] pinctrl: mediatek: fix direction control issue
In-Reply-To: <1455612869.11448.22.camel@mtksdaap41>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
 <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
 <1454555015.4618.10.camel@mussux00>
 <CACRpkdZb2-TX1eY7eyK5qCqOg66MP1e4+OO287roJdP=RB6-Fg@mail.gmail.com>
 <1455242831.35628.15.camel@mussux00>
 <1455612869.11448.22.camel@mtksdaap41>
Message-ID: <CACRpkdb1pVQY0UG-_Z5ivyG6rPZq5YibYcRhzdnDMghfH8jMjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 9:54 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:

> To make it more clear, for a GPIO pin to get input on MTK chip, we must:
>
> - Enable input for the pad (input-enable)

This should be done by the pin control portions of the driver in
response to the PIN_CONFIG_INPUT_ENABLE generic pin
config setting.

Possibly *also* by just writing the hardware registers
from the callbacks right below here:

> - Set mux to GPIO mode

This should be done by just writing the hardware registers
in these callbacks from struct pinmux_ops:

        int (*gpio_request_enable) (struct pinctrl_dev *pctldev,
                                    struct pinctrl_gpio_range *range,
                                    unsigned offset);
        void (*gpio_disable_free) (struct pinctrl_dev *pctldev,
                                   struct pinctrl_gpio_range *range,
                                   unsigned offset);
        int (*gpio_set_direction) (struct pinctrl_dev *pctldev,
                                   struct pinctrl_gpio_range *range,
                                   unsigned offset,
                                   bool input);

In respons to these functions being called from the corresponding
GPIO driver:

extern int pinctrl_request_gpio(unsigned gpio);
extern void pinctrl_free_gpio(unsigned gpio);
extern int pinctrl_gpio_direction_input(unsigned gpio);
extern int pinctrl_gpio_direction_output(unsigned gpio);

> - Set GPIO direction to input

This should be done in these callbacks from struct gpio_chip:

        int                     (*direction_input)(struct gpio_chip *chip,
                                                unsigned offset);
        int                     (*direction_output)(struct gpio_chip *chip,
                                                unsigned offset, int value);

By just writing the hardware registers.

> Currently user need to add a dts node to set pinmux to GPIO mode with
> input-enable property, the driver need to call gpio_direction_input to
> set direction.

It seems like:

- Your GPIO driver is not calling the pinctrl_request_gpio/
  pinctrl_gpio_direction_* etc.

- Your pinmux driver is not implementing the GPIO-specifif
  .gpio_* functions

> Since input-enable and GPIO direction are 2 different things, we now
> think this patch is inappropriate. Instead, user should not required to
> add pinmux node in dts if all he want is use it as plain GPIO input.

If you sort out the above callbacks (also read
Documentation/pinctrl.txt about GPIO) I think it is
clear what you need to do.

Usually you should only need a special pinmux/pinconf node
for a GPIO line if you need to specify pull-up or similar electronic
things for that GPIO.

Yours,
Linus Walleij
