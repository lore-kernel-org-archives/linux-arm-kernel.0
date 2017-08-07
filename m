From: david@lechnology.com (David Lechner)
Date: Mon,  7 Aug 2017 12:39:40 -0500
Subject: [PATCH v4 4/5] ARM: dts: da850-lego-ev3: Add node for LCD display
In-Reply-To: <1502127581-10517-1-git-send-email-david@lechnology.com>
References: <1502127581-10517-1-git-send-email-david@lechnology.com>
Message-ID: <1502127581-10517-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new node for the LEGO MINDSTORMS EV3 LCD display.

Signed-off-by: David Lechner <david@lechnology.com>
---

v4 changes:
* changed dc to a0

 arch/arm/boot/dts/da850-lego-ev3.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 45983c0..413dbd5 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -249,6 +249,15 @@
 			0x4c 0x00000080 0x000000f0
 		>;
 	};
+
+	ev3_lcd_pins: pinmux_lcd {
+		pinctrl-single,bits = <
+			/* SIMO, GP2[11], GP2[12], CLK */
+			0x14 0x00188100 0x00ffff00
+			/* GP5[0] */
+			0x30 0x80000000 0xf0000000
+		>;
+	};
 };
 
 &pinconf {
@@ -357,6 +366,21 @@
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&ev3_lcd_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+
+	display at 0{
+		compatible = "lego,ev3-lcd";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		a0-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &ehrpwm0 {
 	status = "okay";
 };
-- 
2.7.4
