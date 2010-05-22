From: redhatter@gentoo.org (Stuart Longland)
Date: Sat, 22 May 2010 11:02:17 +1000
Subject: i.MX27 GPIOs -- how to define the default output?
Message-ID: <20100522010210.GA18017@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm in the process of porting Ka-Ro's TX27 kernel patch over from kernel
2.6.28 to current git HEAD[1].  In the process of doing this, I note that
the old definitions GPIO_DFLT_HIGH and GPIO_DFLT_LOW have disappeared.

I can't seem to find their replacements anywhere.

The code I'm porting defines a heap of GPIO pins for use with the LCD
controller:

static unsigned int mx27_lcdc_gpios[] = {
	MXC_PIN(F, 12, GPIO, GPIO_OUT | GPIO_DFLT_LOW), /* LCD reset
(active LOW) */
	MXC_PIN(E,  5, GPIO, GPIO_OUT | GPIO_DFLT_HIGH), /* LCD
backlight (PWM: 0: off 1: max brightness */
	MXC_PIN(A, 30, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA30 */
	MXC_PIN(A, 25, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA25 */
	MXC_PIN(A, 26, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA26 */
	MXC_PIN(A, 24, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA24 */
	MXC_PIN(A, 27, GPIO, GPIO_OUT | GPIO_DFLT_LOW),	/* PA27 */
	PA5_PF_LSCLK,
	PA6_PF_LD0,
	PA7_PF_LD1,
	... etc

then later; calls mxc_gpio_setup_multiple_pins on it:

	ret = mxc_gpio_setup_multiple_pins(mx27_lcdc_gpios,
					ARRAY_SIZE(mx27_lcdc_gpios),
"LCD");

While a glitch probably will do little more than cause the LCD backlight
to flicker momentarily, and maybe reset the LCD itself, I'd still like
to have the signals driven the right way from the outset.  Does anyone
have any pointers as to where I could look for where this default is
set?

On a related note; we have a small audio amplifier on our board.  Its
mute signal is wired up to one of the keypad column outputs on the
i.MX27 keypad controller, which can be driven as a GPIO.  Is there a
means of accessing this cleanly within the GPIO framework of the kernel?
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

1. This hasn't been an easy task; reasoning is so that we can leverage
the i.MX27 I?S SSI code in the current Linux-ASoC tree, not present in
kernel 2.6.28.  Backporting this proved to be a huge mess.
