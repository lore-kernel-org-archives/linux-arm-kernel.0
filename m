From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:01 +0100
Subject: [PATCH 17/30] ARM: sun6i: app4 evb1: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-18-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 52 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index be9f5ee6b59e..98a74da02fd7 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -61,36 +61,34 @@
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
+};
 
-	soc at 01c00000 {
-		pio: pinctrl at 01c20800 {
-			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-				allwinner,pins = "PH27";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		usbphy: phy at 01c19400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
-		};
+&pio {
+	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+		allwinner,pins = "PH27";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
 
-		ehci0: usb at 01c1a000 {
-			status = "okay";
-		};
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_a>;
+	gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
-	};
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_a>;
-		gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
 };
-- 
2.2.2
