From: tony@atomide.com (Tony Lindgren)
Date: Fri,  4 Dec 2015 15:31:08 -0800
Subject: [PATCH 5/6] ARM: dts: Add usb support for hp t410
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Message-ID: <1449271869-7614-6-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb support for hp t410 and a fixed regulator for the hub power.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-t410.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index d1927a7..5d4313f 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -16,6 +16,17 @@
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
 
+	/* gpio9 seems to control USB VBUS regulator and/or hub power */
+	usb_power: regulator at 9 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	vmmcsd_fixed: fixedregulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -60,4 +71,28 @@
 			DM814X_IOPAD(0x0920, PIN_INPUT | 40)	/* SD2_SDCD */
 			>;
 	};
+
+	usb0_pins: pinmux_usb0_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0c34, PIN_OUTPUT | 0x1)	/* USB0_DRVVBUS */
+			>;
+	};
+
+	usb1_pins: pinmux_usb1_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0834, PIN_OUTPUT | 0x80)	/* USB1_DRVVBUS */
+			>;
+	};
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	dr_mode = "host";
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+	dr_mode = "host";
 };
-- 
2.6.2
