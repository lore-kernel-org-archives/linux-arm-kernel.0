From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:14 +0100
Subject: [PATCH 30/30] ARM: sun8i: ippo q8h v5: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-31-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 110 ++++++++++++++--------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 623573e46080..4cb25f8267c8 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -66,69 +66,67 @@
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
+};
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
-			vmmc-supply = <&reg_vcc3v0>;
-			bus-width = <4>;
-			cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
-				allwinner,pins = "PB4";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
 
-		lradc: lradc at 01c22800 {
-			vref-supply = <&reg_vcc3v0>;
-			status = "okay";
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-			button at 200 {
-				label = "Volume Up";
-				linux,code = <KEY_VOLUMEUP>;
-				channel = <0>;
-				voltage = <200000>;
-			};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	/* pull-ups and devices require PMIC regulator */
+	status = "failed";
+};
 
-			button at 400 {
-				label = "Volume Down";
-				linux,code = <KEY_VOLUMEDOWN>;
-				channel = <0>;
-				voltage = <400000>;
-			};
-		};
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
-		};
+	button at 200 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <200000>;
+	};
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
+	button at 400 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <400000>;
+	};
+};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			/* pull-ups and devices require PMIC regulator */
-			status = "failed";
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
+	cd-inverted;
+	status = "okay";
+};
 
-		r_uart: serial at 01f02800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&r_uart_pins_a>;
-			status = "okay";
-		};
+&pio {
+	mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
+		allwinner,pins = "PB4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 };
+
+&r_uart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_uart_pins_a>;
+	status = "okay";
+};
-- 
2.2.2
