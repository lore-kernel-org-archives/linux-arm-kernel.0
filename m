From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:41 +0200
Subject: [PATCH 09/18] ARM: am57xx: cl-som-am57x: dts: add touchscreen support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-10-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADS7846 touchscreen support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index eba12a4..1830d4f 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -43,6 +43,13 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	ads7846reg: fixedregulator-ads7846-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "ads7846-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &dra7_pmx_core {
@@ -183,6 +190,12 @@
 			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT | MUX_MODE15)
 		>;
 	};
+
+	ads7846_pins: pinmux_ads7846_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3464, PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpmc_a9.gpio1_31 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -450,6 +463,37 @@
 			reg = <0x100000 0x0>;
 		};
 	};
+
+	/* touch controller */
+	ads7846 at 0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ads7846_pins>;
+
+		compatible = "ti,ads7846";
+		vcc-supply = <&ads7846reg>;
+
+		reg = <1>;                              /* CS1 */
+		spi-max-frequency = <1500000>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <31 0>;
+		pendown-gpio = <&gpio1 31 0>;
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
 
 &mac {
-- 
1.9.1
