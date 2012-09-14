From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 11:16:59 -0600
Subject: [PATCH v2] pinctrl: document semantics vs GPIO
In-Reply-To: <1347630587-31014-1-git-send-email-linus.walleij@stericsson.com>
References: <1347630587-31014-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5053668B.6020604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 07:49 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The semantics of the interactions between GPIO and pinctrl may be
> unclear, e.g. which one do you request first? This amends the
> documentation to make this clear.

> +If a pin control driver and a GPIO driver is dealing with the same pins
> +and the use cases involve multiplexing, you MUST implement the pin controller
> +as a back-end for the GPIO driver like this.

I might add one caveat to that:

==========
, unless your HW design is such that the GPIO controller can override
the pin controller's mux state, without the need for any such interaction.
==========

... as on Tegra for example, the GPIO controller contains a bit per GPIO
pin which forces the GPIO controller to control the pin, irrespective of
any mux setting in the pinmux controller (although the pin controller's
tri-state config overrides the GPIO controller's output-enable
config!!!). Hence, the exact same semantics can be achieved, without the
GPIO driver actually having to call into the pinctrl subsystem. That
said, Tegra's GPIO driver still does end up calling into
pinctrl_request_gpio()/pinctrl_free_gpio() so that pinctrl debugfs works
for example, just not the pinctrl_gpio_direction_*(), so I guess it's
partially following the MUST above, so perhaps there's no need for the
caveat?

Either way,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

In the future, I wonder if someone might want the following caveat,

==========
, unless you require that all boards (or device trees) define a system
hog pinmux configuration that muxes all required GPIO signals as desired.
==========

... which might be appropriate for HW where GPIO-vs-special-function
selection is performed in the pinmux controller itself, per-pin. Perhaps
this is the OMAP special case you mentioned before?
