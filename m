From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 19:42:47 +0800
Subject: [PATCH v9 01/10] gpio: add gpio offset in gpio range cells property
In-Reply-To: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361101376-3783-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio offset into "gpio-range-cells" property. It's used to support
sparse pinctrl range in gpio chip.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/gpio/gpio.txt |    6 +++---
 arch/arm/boot/dts/spear1310.dtsi                |    4 ++--
 arch/arm/boot/dts/spear1340.dtsi                |    4 ++--
 arch/arm/boot/dts/spear310.dtsi                 |    4 ++--
 arch/arm/boot/dts/spear320.dtsi                 |    4 ++--
 drivers/gpio/gpiolib-of.c                       |   15 ++-------------
 6 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index a336287..d933af3 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -98,7 +98,7 @@ announce the pinrange to the pin ctrl subsystem. For example,
 		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
 		reg = <0x1460 0x18>;
 		gpio-controller;
-		gpio-ranges = <&pinctrl1 20 10>, <&pinctrl2 50 20>;
+		gpio-ranges = <&pinctrl1 0 20 10>, <&pinctrl2 10 50 20>;
 
     }
 
@@ -107,8 +107,8 @@ where,
 
    Next values specify the base pin and number of pins for the range
    handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
-   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
-   by this gpio controller.
+   pin 29 under pinctrl1 with gpio offset 0 and pin 50 to pin 69 under
+   pinctrl2 with gpio offset 10 is handled by this gpio controller.
 
 The pinctrl node must have "#gpio-range-cells" property to show number of
 arguments to pass with phandle from gpio controllers node.
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 1513c19..122ae94 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -89,7 +89,7 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1310-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		apb {
@@ -212,7 +212,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 246>;
+				gpio-ranges = <&pinmux 0 0 246>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <246>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index b2d41b7..7ec1eb8 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -63,7 +63,7 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1340-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		pwm: pwm at e0180000 {
@@ -146,7 +146,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 252>;
+				gpio-ranges = <&pinmux 0 0 252>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <250>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index ab45b8c..9537208 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -25,7 +25,7 @@
 		pinmux: pinmux at b4000000 {
 			compatible = "st,spear310-pinmux";
 			reg = <0xb4000000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		fsmc: flash at 44000000 {
@@ -102,7 +102,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 102>;
+				gpio-ranges = <&pinmux 0 0 102>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <102>;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index caa5520..ffea342 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -24,7 +24,7 @@
 		pinmux: pinmux at b3000000 {
 			compatible = "st,spear320-pinmux";
 			reg = <0xb3000000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		clcd at 90000000 {
@@ -130,7 +130,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 102>;
+				gpio-ranges = <&pinmux 0 0 102>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <102>;
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a71a54a..892040a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -203,22 +203,11 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (!pctldev)
 			break;
 
-		/*
-		 * This assumes that the n GPIO pins are consecutive in the
-		 * GPIO number space, and that the pins are also consecutive
-		 * in their local number space. Currently it is not possible
-		 * to add different ranges for one and the same GPIO chip,
-		 * as the code assumes that we have one consecutive range
-		 * on both, mapping 1-to-1.
-		 *
-		 * TODO: make the OF bindings handle multiple sparse ranges
-		 * on the same GPIO chip.
-		 */
 		ret = gpiochip_add_pin_range(chip,
 					     pinctrl_dev_get_devname(pctldev),
-					     0, /* offset in gpiochip */
 					     pinspec.args[0],
-					     pinspec.args[1]);
+					     pinspec.args[1],
+					     pinspec.args[2]);
 
 		if (ret)
 			break;
-- 
1.7.10.4
