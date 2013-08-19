From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 13:15:42 -0600
Subject: [PATCH v2] pinctrl: queue GPIO operations instead of defering
In-Reply-To: <1376751410-14560-1-git-send-email-linus.walleij@linaro.org>
References: <1376751410-14560-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52126EDE.5060000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 08:56 AM, Linus Walleij wrote:
> We currently defer probing of the caller if a pinctrl GPIO
> request or direction setting comes in before the range mapping
> a certain GPIO to a certain pin controller is available.
> 
> This can end up with a circular dependency: the GPIO driver
> needs the pin controller to be ready

So that much is explained above; it's because some GPIO APIs call into
pinctrl to manage GPIO-vs-pinmux-function setup.

> and the pin controller need the GPIO driver to be ready.

Why does that happen?

> This also happens if
> pin controllers and GPIO controllers compiled as modules
> are inserted in a certain order.

Shouldn't deferred probe resolve that just fine, assuming there are no
circular dependencies? In other words, this is just a special case of
the explanation above, so probably not worth explicitly mentioning.

...
> On the Nomadik we get this situation with the pinctrl
> driver when moving to requesting GPIOs off the gpiochip
> right after it has been added,

So, the pinctrl driver calls gpio_request()? Surely the solution is
simply not to do that?
