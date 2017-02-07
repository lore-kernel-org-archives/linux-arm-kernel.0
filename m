From: david@lechnology.com (David Lechner)
Date: Tue,  7 Feb 2017 13:22:07 -0600
Subject: [PATCH 1/3] ARM: da850-lego-ev3: Add device tree node for A/DC
In-Reply-To: <1486495329-2789-1-git-send-email-david@lechnology.com>
References: <1486495329-2789-1-git-send-email-david@lechnology.com>
Message-ID: <1486495329-2789-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the TI ADS7957 analog/digital converter on LEGO
MINDSTORMS EV3 as well as a regulator node that is used by the A/DC node.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 112ec92..0309537 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -139,6 +139,19 @@
 		enable-active-high;
 		regulator-boot-on;
 	};
+
+	/*
+	 * This is a simple voltage divider on VCC5V to provide a 2.5V
+	 * reference signal to the ADC.
+	 */
+	adc_ref: regulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "adc ref";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		vin-supply = <&vcc5v>;
+	};
 };
 
 &pmx_core {
@@ -293,6 +306,14 @@
 			};
 		};
 	};
+
+	adc: adc at 3 {
+		compatible = "ti,ads7957";
+		reg = <3>;
+		#io-channel-cells = <1>;
+		spi-max-frequency = <10000000>;
+		vref-supply = <&adc_ref>;
+	};
 };
 
 &gpio {
-- 
2.7.4
