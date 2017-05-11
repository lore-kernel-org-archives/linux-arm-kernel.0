From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 May 2017 10:09:16 +0200
Subject: [PATCH] ARM: dts: imx28: add gpio-ranges for internal gpio
 controller
In-Reply-To: <20170511075135.GF5833@dragon>
References: <20170508085925.18342-1-u.kleine-koenig@pengutronix.de>
 <20170511075135.GF5833@dragon>
Message-ID: <20170511080916.gim5pyhj5jarzf4r@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 03:51:36PM +0800, Shawn Guo wrote:
> On Mon, May 08, 2017 at 10:59:25AM +0200, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > with this patch applied I get the following lines in dmesg which looks
> > fine:
> > 
> > 	[    0.227913] gpio gpiochip0: (80018000.pinctrl:gpio at 0): created GPIO range 0->31 ==> 80018000.pinctrl PIN 0->31
> > 	[    0.236100] gpio gpiochip1: (80018000.pinctrl:gpio at 1): created GPIO range 0->31 ==> 80018000.pinctrl PIN 32->63
> > 	[    0.244463] gpio gpiochip2: (80018000.pinctrl:gpio at 2): created GPIO range 0->31 ==> 80018000.pinctrl PIN 64->95
> > 	[    0.253020] gpio gpiochip3: (80018000.pinctrl:gpio at 3): created GPIO range 0->31 ==> 80018000.pinctrl PIN 96->127
> > 	[    0.261639] gpio gpiochip4: (80018000.pinctrl:gpio at 4): created GPIO range 0->31 ==> 80018000.pinctrl PIN 128->159
> > 
> > But when looking at a used gpio
> > 
> > 	# cat /sys/kernel/debug/gpio
> > 	gpiochip0: GPIOs 0-31, parent: platform/80018000.pinctrl:gpio at 0, 80018000.pinctrl:gpio at 0:
> > 	...
> > 	 gpio-20  (LED4                |?                   ) out hi
> > 	...
> > 
> > 	# grep "pin 20 " /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-pins
> > 	pin 20 (GPMI_RDY0): leds (GPIO UNCLAIMED) function leds group leds.0
> > 
> > I wonder why there is still "GPIO UNCLAIMED". I would have expected that
> > this disappears and somehow references the gpio_request issued by the
> > led-gpio driver after my patch.
> > 
> > What am I missing?
> 
> It seems that's only the case where @strict of struct pinmux_ops is
> true.  We should set it true for pinctrl-mxs, I guess?

The description is:

 * @strict: do not allow simultaneous use of the same pin for GPIO and another
 *      function. Check both gpio_owner and mux_owner strictly before approving
 *      the pin request.

so if I understand correctly that means that if a device has configured the pin
MX28_PAD_SSP2_SCK as function SSP2_SCK it's impossible to do gpio_request on
<&gpio2 16> (which is the matching GPIO)? I don't like that. My use case for
exactly this is that I want the MX28_PAD_SSP2_SCK pin to be high-Z when the spi
bus is not in use. I do this as follows:

	&ssp2 {
		pinctrl-names = "default", "idle";
		pinctrl-0 = <&spi2_pins_a>;
		pinctrl-1 = <&spi2_pins_a_gpio>;
		...
	};

where spi2_pins_a_gpio includes MX28_PAD_SSP2_SCK__GPIO_2_16, and then

	&gpio2 {
		ssp2_sck {
			gpio-hog;
			gpio = <16 0>;
			input;
		};
		...
	};

. So I think strict is a bad idea, not only for pinctrl-mxs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
