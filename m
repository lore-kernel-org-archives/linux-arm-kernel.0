From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  8 Jul 2015 16:14:06 +0200
Subject: [PATCH] pinctrl: abx500: remove strict mode
Message-ID: <1436364846-11471-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a21763a0b1e5a5ab8310f581886d04beadc16616
"pinctrl: nomadik: activate strict mux mode"
put all Nomadik pin controllers to strict mode. This was
not good on the Snowball platform: the muxing of GPIOs to
different pins is done with hogs in the DTS file, and then
these GPIOs are used by offset, relying on hogs to mux the
pins. Since that means the pin controller "owns" the pins
and at the same time we have a GPIO user, this pin controller
is by definition not strict.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi   | 4 ----
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 9b69bce9297d..165c1bac61b1 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -231,10 +231,6 @@
 					 */
 					gpio26 {
 						gpio26_default_mode: gpio26_default {
-							default_mux {
-								function = "gpio";
-								groups = "gpio26_d_1";
-							};
 							default_cfg {
 								pins = "GPIO26_M16";
 								output-low;
diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 557d0f2a3031..97681fac082e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -787,7 +787,6 @@ static const struct pinmux_ops abx500_pinmux_ops = {
 	.set_mux = abx500_pmx_set,
 	.gpio_request_enable = abx500_gpio_request_enable,
 	.gpio_disable_free = abx500_gpio_disable_free,
-	.strict = true,
 };
 
 static int abx500_get_groups_cnt(struct pinctrl_dev *pctldev)
-- 
2.4.3
