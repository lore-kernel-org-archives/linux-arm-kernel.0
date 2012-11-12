From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Nov 2012 09:25:46 +0100
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <50A020C5.4070506@wwwdotorg.org>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org>
Message-ID: <20121112082546.GU22029@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2012 at 03:03:49PM -0700, Stephen Warren wrote:
> On 11/11/2012 09:21 AM, Andrew Lunn wrote:
> > From: Jamie Lentin <jm@lentin.co.uk>
> > 
> > Given appropriate devicetree bindings, this driver registers a
> > pm_power_off function to set a GPIO line high/low to power down
> > your board.
> 
> This feature will be useful for the Tegra TrimSlice board too.

Hi Stephen

Great to hear its usable for others.

> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
> 
> > +Required properties:
> > +- compatible : should be "gpio-poweroff".
> > +- gpios : The GPIO to set high/low, see "gpios property" in
> > +  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
> > +  low to power down the board set it to "Active Low", otherwise set
> > +  gpio to "Active High".
> 
> Unfortunately, not all GPIO bindings support active high/low flags in
> the GPIO specifier. As such, the flags there are basically useless.
> Other bindings (e.g. IIRC the fixed-regulator binding) have added a
> separate active-high property to indicate the GPIO polarity. This
> binding should probably follow suite.

Humm, so are you saying of_get_named_gpio_flags() is deprecated?

There is a lot of code using this to get the flag
OF_GPIO_ACTIVE_LOW. Some of these users are very generic code:

drivers/leds/leds-gpio.c:
drivers/input/misc/rotary_encoder.c:
drivers/input/keyboard/gpio_keys.c:
drivers/input/keyboard/gpio_keys_polled.c:
drivers/hwmon/gpio-fan.c:

The only code using the "enable-active-high"
property is drivers/regulator/fixed.c although the binding
documentation twl6040.txt talks about it, but the code does not
implement it.

Could you point me towards some email discussion about this?

Thanks
	Andrew
