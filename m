From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 11:35:12 +0100
Subject: [PATCH] pinctrl: at91: add the config GPIO_OUTPUT_x
In-Reply-To: <531F49C3.2020506@atmel.com>
References: <1393984400-14687-1-git-send-email-wenyou.yang@atmel.com>
 <531F49C3.2020506@atmel.com>
Message-ID: <CACRpkdYTq0UmJ0JwzwHLjK8Qa=svoLtqxmm6+ntRnnD_NstCrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 6:37 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Linus,
>
> For the nature of this feature, I would like to have your clear advice
> as this is needed and has been proposed twice (at least). This feature
> is needed for power management states of GPIOs.

It seems that this is aligned with what other pin control drivers do
to move pins to low power states. As long as the same pins are
never used for "ordinary" GPIO through gpiolib I think doing this is
just some electric aspect of the pin and controlled by the device using
it as part of its normal low-power operation. No different from e.g.
setting a different biasing or decoupling or grounding the pin or whatever.

The fact that the register or bit(s) are named ...gpio-something... is
irrelevant if they cannot be accessed as such.

If you want to be *really* picky you can start go about to edit
your gpio-ranges so that it is impossible to cross-reference one of
these GPIOs to a pin, and thus impossible to use them from the
GPIO subsystem. (Right now the at91 driver is using
pinctrl_add_gpio_range() so switch this to using ranges defined
from the device tree if you are fully migrated to DT.)

Basically this is a system issue, how you guys want to handle the
AT91 low-power modes.

I think you are three maintainers of AT91:

M:      Andrew Victor <linux@maxim.org.za>
M:      Nicolas Ferre <nicolas.ferre@atmel.com>
M:      Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Can you get a majority vote on how you want this to work on AT91?
If two out of three AT91 maintainers ACK the patch I will apply it, and
then you three can fight amongst yourselves ;-)

Yours,
Linus Walleij
