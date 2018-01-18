From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Jan 2018 10:46:44 +0100
Subject: [RFC PATCH 1/2] pinctrl: add consumer variant for gpio request
In-Reply-To: <20180115162233.6205-2-ludovic.desroches@microchip.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
 <20180115162233.6205-2-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdbceFf09UNRT=cmPq1caP=eiEJc_APi55p379AyJt-0Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 5:22 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Add a consumer variant to GPIO request relative functions. The goal
> is to fix the bad ownership, which is arbitrary set to
> "range->name:gpio", of a GPIO.

For this patch on its own (apart from the context):

I what you want to achieve is to pass a consumer name from
gpiolib to pinmux portions of pinctrl, then augment the existing
pinctrl_gpio_request() to pass an optional consumer name,
and change all existing in-kernel users to just pass NULL
and then use the range name as fallback if the consumer
name is NULL.

> There is a lack of configuration features for GPIO. For instance,
> we can't set the bias. Some pin controllers manage both device's
> pins and GPIOs. GPIOs can benefit from pin configuration. Usually,
> a pinctrl node is used to mux the pin as a GPIO and to set up its
> configuration.

Pin config takes care of bias, pull up/down, drive strength etc etc.

GPIO hammers lines 0->1, 1->2, and reads them as 0 or 1.
It can group lines into arrays etc but that is what it does.

The two systems are cross-connected using the GPIO ranges.

There are cross-calls for GPIO to ask pin controllers for favors:
extern int pinctrl_gpio_request(unsigned gpio);
extern void pinctrl_gpio_free(unsigned gpio);
extern int pinctrl_gpio_direction_input(unsigned gpio);
extern int pinctrl_gpio_direction_output(unsigned gpio);
extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);

Note: when the GPIO hardware is very simple apart from some extra
register or two providing open drain and/or debounce, the gpio driver
can simply implement .set_config() itself so no pin control back-end
is needed. We could require a separate pin config driver but why
complicate things for the sake of abstraction. Nah.

The last API (pinctrl_gpio_set_config()) should only be called
to set up electrical properties under special circumstances.

Those are as follows:

1) When the in-kernel client needs to configure electrical properties,
gpiolib exposes interfaces for this, such as:
int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);

Likewise devm_gpiod_get() can pass flags such as
GPIOD_OUT_LOW_OPEN_DRAIN to state that "I want this line,
and I want it to be initialized logical low (deasserted), and it must
be open drain" If the corresponding device tree phandle flag or board file
description or whatever is not also flagging the line as
open drain, gpiolib will protest with a warning print and
enforce open drain. But it is clear that it *should* have been
configured correctly in the device tree.

This API is not all inclusive: notice that we just support open drain,
not open source. (No upfront design: we just deal with what drivers
need, not what they may theoretically need.)

This is partly for historical reasons, but it also makes sense that things
like I2C that can only work electrically with open drain, has a
way to specify that these lines must really be configured as
open drain for this thing to work.

This is necessary when the logic of the code must tell gpiolib how to
electrically use the pin, i.e. it is not a static configuration that comes
from device tree or ACPI or a board file. This is why open
drain/source and debounce can be set up from the in-kernel API.

2) Userspace consumers.

To be clear: these are not laptops, desktops, servers, set-top boxes,
mobile phones etc. Anything comprising a mass-produced system
should NOT use userspace GPIO. That is just WRONG. Real, widely
deployed systems should have proper kernel drivers for their
hardware and deploy their systems with pin config and GPIO use
cases set up in device tree or ACPI or whatever. NOT in userspace
scripts.

Userpace consumers are automatic control: oil burners, electric
bikes, door openers, alarms etc using some GPIO lines as, yeah,
essentially as GPIO lines. "General purpose", as opposed to
"dedicated purpose".

These users include the maker community that do some
fiddely-fiddling with GPIOs from userspace, and that is fine.

Future of this ABI/API:

I do not yet know how much pin config we should allow to come
in from this end *ONLY*. What does userspace consumers really
need?

Also there is no reciprocation between userspace ABI and
in-kernel API.

If we for example decide to let bias and drive strength be set up
from userspace, that does not necessarily mean that we must
let all in-kernel drivers do that too. We can allow
.set_config() to be called from the userspace ABI and down to
.set_config() in the pin control driver ONLY without allowing the
same path for in-kernel users.

Yours,
Linus Walleij
