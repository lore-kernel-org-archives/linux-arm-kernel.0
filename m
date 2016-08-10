From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 15:12:58 +0200
Subject: [PATCH 1/4] pinctrl: st: Use second parameter to gpio specifier
In-Reply-To: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
References: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470834781-23232-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch allows to use the second parameter of gpio
specifier, which is used to specify whether the gpio is
active high or low.

Simply remove specific of_xlate callback() and of_gpio_n_cells
and use default one set by of_gpiochip_add() which allows
to use second parameter gpio specifier.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-st.txt          |  8 ++++++--
 drivers/pinctrl/pinctrl-st.c                            | 17 -----------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
index 26bcb18..e6cc5e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
@@ -50,7 +50,11 @@ Optional properties:
 GPIO controller/bank node.
 Required properties:
 - gpio-controller : Indicates this device is a GPIO controller
-- #gpio-cells	  : Should be one. The first cell is the pin number.
+- #gpio-cells	  : Must be two.
+     - First cell: specifies the pin number inside the controller
+     - Second cell: specifies whether the pin is logically inverted.
+       - 0 = active high
+       - 1 = active low
 - st,bank-name	  : Should be a name string for this bank as specified in
   datasheet.
 
@@ -88,7 +92,7 @@ Example:
 
 		PIO0: gpio at fe610000 {
 			gpio-controller;
-			#gpio-cells	= <1>;
+			#gpio-cells	= <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg		= <0 0x100>;
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0de1c67..2e5c545 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -799,21 +799,6 @@ static int st_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	return (direction == ST_GPIO_DIRECTION_IN);
 }
 
-static int st_gpio_xlate(struct gpio_chip *gc,
-			const struct of_phandle_args *gpiospec, u32 *flags)
-{
-	if (WARN_ON(gc->of_gpio_n_cells < 1))
-		return -EINVAL;
-
-	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
-		return -EINVAL;
-
-	if (gpiospec->args[0] > gc->ngpio)
-		return -EINVAL;
-
-	return gpiospec->args[0];
-}
-
 /* Pinctrl Groups */
 static int st_pctl_get_groups_count(struct pinctrl_dev *pctldev)
 {
@@ -1486,8 +1471,6 @@ static struct gpio_chip st_gpio_template = {
 	.direction_output	= st_gpio_direction_output,
 	.get_direction		= st_gpio_get_direction,
 	.ngpio			= ST_GPIO_PINS_PER_BANK,
-	.of_gpio_n_cells	= 1,
-	.of_xlate		= st_gpio_xlate,
 };
 
 static struct irq_chip st_gpio_irqchip = {
-- 
1.9.1
