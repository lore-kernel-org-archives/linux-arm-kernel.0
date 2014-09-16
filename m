From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 16 Sep 2014 19:35:21 +0300
Subject: [PATCH 3/4] ARM: dts: cm-t54: add ADS7846 touchscreen support
In-Reply-To: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410885322-5928-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADS7846 touchscreen support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |   61 ++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 588cc2a..9cfcad5 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -45,6 +45,13 @@
 		enable-active-high;
 	};
 
+	ads7846reg: ads7846-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "ads7846-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
@@ -164,6 +171,15 @@
 	};
 };
 
+&omap5_pmx_wkup {
+
+	ads7846_pins: pinmux_ads7846_pins {
+		pinctrl-single,pins = <
+			0x02 (PIN_INPUT_PULLDOWN | MUX_MODE6)  /* llib_wakereqin.gpio1_wk15 */
+		>;
+	};
+};
+
 &omap5_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
@@ -300,6 +316,51 @@
 			OMAP5_IOPAD(0x013a, PIN_OUTPUT | MUX_MODE3) /* dispc_data23 */
 		>;
 	};
+
+	mcspi2_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x00fc, PIN_INPUT | MUX_MODE0)	/* mcspi2_clk.mcspi2_clk */
+			OMAP5_IOPAD(0x00fe, PIN_INPUT | MUX_MODE0)	/* mcspi2_simo.mcspi2_simo */
+			OMAP5_IOPAD(0x0100, PIN_INPUT | MUX_MODE0)	/* mcspi2_somi.mcspi2_somi */
+			OMAP5_IOPAD(0x0102, PIN_INPUT | MUX_MODE0)	/* mcspi2_cs0.mcspi2_cs0 */
+		>;
+	};
+};
+
+&mcspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+
+	/* touch controller */
+	ads7846 at 0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ads7846_pins>;
+
+		compatible = "ti,ads7846";
+		vcc-supply = <&ads7846reg>;
+
+		reg = <0>;				/* CS0 */
+		spi-max-frequency = <1500000>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 0>;			/* gpio1_wk15 */
+		pendown-gpio = <&gpio1 15 0>;
+
+
+		ti,x-min = /bits/ 16 <0x0>;
+		ti,x-max = /bits/ 16 <0x0fff>;
+		ti,y-min = /bits/ 16 <0x0>;
+		ti,y-max = /bits/ 16 <0x0fff>;
+
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+
+		ti,debounce-max = /bits/ 16 <30>;
+		ti,debounce-tol = /bits/ 16 <10>;
+		ti,debounce-rep = /bits/ 16 <1>;
+
+		linux,wakeup;
+	};
 };
 
 &mmc1 {
-- 
1.7.5.4
