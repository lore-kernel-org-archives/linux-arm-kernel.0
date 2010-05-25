From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 May 2010 09:59:02 +0200
Subject: i.MX27 GPIOs -- how to define the default output?
In-Reply-To: <20100522010210.GA18017@www.longlandclan.yi.org>
References: <20100522010210.GA18017@www.longlandclan.yi.org>
Message-ID: <20100525075902.GK17272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On Sat, May 22, 2010 at 11:02:17AM +1000, Stuart Longland wrote:
> Hi all,
> 
> I'm in the process of porting Ka-Ro's TX27 kernel patch over from kernel
> 2.6.28 to current git HEAD[1].  In the process of doing this, I note that
> the old definitions GPIO_DFLT_HIGH and GPIO_DFLT_LOW have disappeared.

These have never been in the mainline kernel. It must be something Ka-Ro
introduced in their kernel.

> 
> I can't seem to find their replacements anywhere.
> 
> The code I'm porting defines a heap of GPIO pins for use with the LCD
> controller:
> 
> static unsigned int mx27_lcdc_gpios[] = {
> 	MXC_PIN(F, 12, GPIO, GPIO_OUT | GPIO_DFLT_LOW), /* LCD reset
> (active LOW) */
> 	MXC_PIN(E,  5, GPIO, GPIO_OUT | GPIO_DFLT_HIGH), /* LCD
> backlight (PWM: 0: off 1: max brightness */
> 	MXC_PIN(A, 30, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA30 */
> 	MXC_PIN(A, 25, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA25 */
> 	MXC_PIN(A, 26, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA26 */
> 	MXC_PIN(A, 24, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA24 */
> 	MXC_PIN(A, 27, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA27 */
> 	PA5_PF_LSCLK,
> 	PA6_PF_LD0,
> 	PA7_PF_LD1,
> 	... etc
> 
> then later; calls mxc_gpio_setup_multiple_pins on it:
> 
> 	ret = mxc_gpio_setup_multiple_pins(mx27_lcdc_gpios,
> 					ARRAY_SIZE(mx27_lcdc_gpios),
> "LCD");
> 
> While a glitch probably will do little more than cause the LCD backlight
> to flicker momentarily, and maybe reset the LCD itself, I'd still like
> to have the signals driven the right way from the outset.  Does anyone
> have any pointers as to where I could look for where this default is
> set?

The actual value of a gpio is not written in
mxc_gpio_setup_multiple_pins(). So if your bootloader has left the gpios
correctly everything will work. You could also pass the GPIO_IN flag in
which case the gpios will be configured as an input and a
pullup/pulldown should pull them into the right direction. As a third
possibility you could do a gpio_request/gpio_direction_output before
changing the muxer.

> 
> On a related note; we have a small audio amplifier on our board.  Its
> mute signal is wired up to one of the keypad column outputs on the
> i.MX27 keypad controller, which can be driven as a GPIO.  Is there a
> means of accessing this cleanly within the GPIO framework of the kernel?

When the muxer is configured the gpios work with the standard gpio api.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
