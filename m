From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 13 Aug 2013 20:18:21 -0300
Subject: [PATCH v2] ARM: sunxi: dt: Add device tree for Mele A1000
In-Reply-To: <20130813203001.GC28819@lukather>
References: <20130813203001.GC28819@lukather>
Message-ID: <1376435901-6617-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree usable on Mele A1000 (and A2000, as it
apparently is the same device except for the case). This device features
one UART port, Ethernet, an AXP209 PMU on i2c0 and two user configurable
LEDs.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Maxime, this v2 should address all your comments.

Cheers,

Emilio

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts | 101 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-a1000.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..3fd3919 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -206,6 +206,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
 	stih415-b2020.dtb \
 	stih416-b2020.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += \
+	sun4i-a10-a1000.dtb \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
new file mode 100644
index 0000000..0b2e9d7
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -0,0 +1,101 @@
+/*
+ * Copyright 2013 Emilio L?pez
+ *
+ * Emilio L?pez <emilio@elopez.com.ar>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun4i-a10.dtsi"
+
+/ {
+	model = "Mele A1000";
+	compatible = "mele,a1000", "allwinner,sun4i-a10";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	soc at 01c20000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy1>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			phy-supply = <&reg_emac_3v3>;
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
+		pinctrl at 01c20800 {
+			emac_power_pin_a1000: emac_power_pin at 0 {
+				allwinner,pins = "PH15";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			led_pins_a1000: led_pins at 0 {
+				allwinner,pins = "PH10", "PH20";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_a1000>;
+
+		red {
+			label = "a1000:red:usr";
+			gpios = <&pio 7 10 0>;
+		};
+
+		blue {
+			label = "a1000:blue:usr";
+			gpios = <&pio 7 20 0>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_emac_3v3: emac-3v3 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_power_pin_a1000>;
+			regulator-name = "emac-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			enable-active-high;
+			gpio = <&pio 7 15 0>;
+		};
+	};
+};
-- 
1.8.3.4
