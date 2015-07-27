From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jul 2015 14:41:58 +0200
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert users to the PIO interrupts
 binding
In-Reply-To: <1438000918-9026-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1438000918-9026-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1438000918-9026-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current DTs were setting the cell size to 2, but used the default xlate
function that was assuming an interrupt cell size of 1, leading to the
second part of the cell (the flags) being ignored, while we were having an
inconsistent binding between the interrupts and gpio (that could also be
used as interrupts).

That "binding" doesn't work either with newer SoCs that have multiple irq
banks.

Now that we fixed the pinctrl driver to handle this like it should always
have been handled, convert the DT users, and while we're at it, remove the
size-cells property of PIO that is completely useless.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

---
 arch/arm/boot/dts/sun4i-a10.dtsi           | 3 +--
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts   | 2 +-
 arch/arm/boot/dts/sun5i.dtsi               | 3 +--
 arch/arm/boot/dts/sun6i-a31.dtsi           | 3 +--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi           | 3 +--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi       | 3 +--
 8 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 61c03d1fe530..710a0531953e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -713,8 +713,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			pwm0_pins_a: pwm0 at 0 {
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 514f159a14d4..9303fa035b0e 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -93,7 +93,7 @@
 		compatible = "chipone,icn8318";
 		reg = <0x40>;
 		interrupt-parent = <&pio>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
+		interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts_wake_pin_p66>;
 		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 54b097830434..c58d5a62605f 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -475,8 +475,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			i2c0_pins_a: i2c0 at 0 {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 008047a018cf..2541412cabb0 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -599,8 +599,7 @@
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			uart0_pins_a: uart0 at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 4611e2f5a99e..70d0f85a636d 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -181,7 +181,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
-		interrupts = <10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
+		interrupts = <7 10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
 		interrupt-names = "host-wake";
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index f32f6f20d923..1e6bd360dac0 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -178,7 +178,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
-		interrupts = <10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
+		interrupts = <7 10 IRQ_TYPE_LEVEL_LOW>; /* PH10 / EINT10 */
 		interrupt-names = "host-wake";
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6a63f30c9a69..d3497a51f0c4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -794,8 +794,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#interrupt-cells = <2>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			pwm0_pins_a: pwm0 at 0 {
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7abd0ae3143d..f93105709680 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -339,8 +339,7 @@
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			uart0_pins_a: uart0 at 0 {
-- 
2.4.6
