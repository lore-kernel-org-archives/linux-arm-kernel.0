From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 10:11:29 -0600
Subject: [PATCH] pinctrl: document semantics vs GPIO
In-Reply-To: <1347519686-10170-1-git-send-email-linus.walleij@stericsson.com>
References: <1347519686-10170-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <505205B1.4080708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 01:01 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The semantics of the interactions between GPIO and pinctrl may be
> unclear, e.g. which one do you request first? This amends the
> documentation to make this clear.

> +Drivers needing both pin control and GPIOs
> +==========================================
> +
> +Again, it is discouraged to let drivers lookup and select pin control states
> +themselves, but again sometimes this is unavoidable.
> +
> +So say that your driver is fetching its resources like this:
> +
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/gpio.h>
> +
> +struct pinctrl *pinctrl;
> +int gpio;
> +
> +pinctrl = devm_pinctrl_get_select_default(&dev);
> +gpio = devm_gpio_request(&dev, 14, "foo");
> +
> +Here we first request a certain pin state and then request GPIO 14 to be
> +used. If you're using the subsystems orthogonally like this, always get
> +your pinctrl handle and select the desired pinctrl state BEFORE requesting
> +the GPIO. This is a semantic convention to avoid situations that can be
> +electrically unpleasant, you will certainly want to mux in and bias pins
> +in a certain way before the GPIO subsystems starts to deal with them.

I'm not 100% certain that all HW will work best by first programming
pinctrl then programming GPIO. For example of strangeness, Tegra's GPIO
controller has a bit per-pin which overrides the pinmux's mux function
to enable GPIOs, yet the pinctrl's tri-state overrides the GPIO's
input/output control. I imagine HW engineers can come up with even more
bizarre schemes that might in some cases require the reverse order).

However, I suppose what you've documented is likely common and it'd be
good to recommend a default order between the two APIs. I might whittle
out the part that justifies the order from a HW glitching perspective
though.

> +The above can be hidden: using pinctrl hogs, the driver may be setting

s/the driver/the pinctrl driver/ I think.

> +up the config and muxing for the pins when the pinctrl driver is probing,
> +nevertheless orthogonal to the GPIO subsystem.
> +
> +But there are also situations where it makes sense for the GPIO subsystem
> +to communicate directly with with the pinctrl subsystem, using the latter
> +as a back-end. This is when the GPIO driver may call out to the functions
> +described in the section "Pin control interaction with the GPIO subsystem"
> +above. This only involves per-pin multiplexing, and will be completely
> +hidden behind the gpio_*() function namespace. In this case, the driver
> +need not interact with the pin control subsystem at all.

I think it makes sense to more strongly recommend that for GPIO muxing,
the GPIO driver always call into the pinctrl subsystem (if needed by the
HW) to perform that muxing, so that standalone gpio_direction_*() always
work without any use of pinctrl; the interaction between the two should
only be required if pin configuration (not just pin muxing) is also
required.
