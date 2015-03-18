From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 10:51:37 +0000
Subject: [PATCH 4/6] pinctrl: st: Supply a GPIO get_direction() call-back
In-Reply-To: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1426675899-19882-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's hardware differentiates between GPIO mode and Pinctrl alternate
functions.  When a pin is in GPIO mode, there are dedicated registers
to set and obtain direction status.  However, If a pin's alternate
function is in use then the direction is set and status is derived
from a bunch of syscon registers.  The issue is; until now there was
a lack of parity between the two.

For example:

Catting the two following information sources could result in
conflicting information (output has been snipped for simplicity):

 $ cat /sys/kernel/debug/gpio
  GPIOs 32-39, platform/961f080.pin-controller-sbc, PIO4:
   gpio-33  (?                   ) out hi

 $ cat /sys/kernel/debug/pinctrl/<pin-controller>/pinconf-pins
  pin 33 (PIO4[1]):[OE:0,PU:0,OD:0]
         [retime:0,invclk:0,clknotdat:0,de:0,rt-clk:0,rt-delay:0]

In this example GPIO-33 is a GPIO controlled LED, which is set for
output, as you'd expect.  However, when the same information is
drafted from Pinctrl, it clearly states that OE (Output Enable) is
not set i.e. the pin is set for input.  This is because OE normally
only represents alternate functions and has no bearing on how the
pin operates when in Alt-0 (GPIO mode).

This patch changes the current semantics and provides a parity link
between the two subsystems.  The get_direction() call-back firstly
determines which function a pin is operating in, then uses the
appropriate helpers for that mode.

Reported-by: Olivier Clergeaud <olivier.clergeaud@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-st.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 10ad19c..52a4377 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -206,7 +206,6 @@
 #define gpio_chip_to_bank(chip) \
 		container_of(chip, struct st_gpio_bank, gpio_chip)
 
-
 enum st_retime_style {
 	st_retime_style_none,
 	st_retime_style_packed,
@@ -781,6 +780,35 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int st_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct st_gpio_bank *bank = gpio_chip_to_bank(chip);
+	struct st_pio_control pc = bank->pc;
+	unsigned long config;
+	unsigned int direction = 0;
+	unsigned int function;
+	unsigned int value;
+	int i = 0;
+
+	/* Alternate function direction is handled by Pinctrl */
+	function = st_pctl_get_pin_function(&pc, offset);
+	if (function) {
+		st_pinconf_get_direction(&pc, offset, &config);
+		return !ST_PINCONF_UNPACK_OE(config);
+	}
+
+	/*
+	 * GPIO direction is handled differently
+	 * - See st_gpio_direction() above for an explanation
+	 */
+	for (i = 0; i <= 2; i++) {
+		value = readl(bank->base + REG_PIO_PC(i));
+		direction |= ((value >> offset) & 0x1) << i;
+	}
+
+	return (direction == ST_GPIO_DIRECTION_IN);
+}
+
 static int st_gpio_xlate(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags)
 {
@@ -1452,6 +1480,7 @@ static struct gpio_chip st_gpio_template = {
 	.set			= st_gpio_set,
 	.direction_input	= st_gpio_direction_input,
 	.direction_output	= st_gpio_direction_output,
+	.get_direction		= st_gpio_get_direction,
 	.ngpio			= ST_GPIO_PINS_PER_BANK,
 	.of_gpio_n_cells	= 1,
 	.of_xlate		= st_gpio_xlate,
-- 
1.9.1
