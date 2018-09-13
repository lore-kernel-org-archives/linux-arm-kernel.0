From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:29:16 +0200
Subject: [PATCH 1/4] ARM: dts: meson8b: odroidc1: add the CPU voltage regulator
In-Reply-To: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
References: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180913202919.20927-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU voltage regulator is a "Monolithic Power Systems MP2161"
(according to the Odroid-C1+'s schematics). It is driven by PWM_C on
GPIODV_9.

Hardkernel's 3.10 kernel (based on the Amlogic GPL kernel sources)
defines a PWM voltage table with the following values:
- 0.86 volts = PWM register value 0x10f001b
- (more values in 0.1 volt increments)
- 1.14 volts = PWM register value 0x000012a
When using the XTAL (24MHz) as input this translates into a PWM period
of 12218ns with 0.86V using a duty cycle of 91% and 1.14V using a duty
cycle of 0%.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index ef3177d3da3d..0557823cdd64 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -101,6 +101,25 @@
 		states = <3300000 0
 			  1800000 1>;
 	};
+
+	vcck: regulator-vcck {
+		/* Monolithic Power Systems MP2161 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VCCK";
+		regulator-min-microvolt = <860000>;
+		regulator-max-microvolt = <1140000>;
+
+		pwms = <&pwm_cd 0 12218 0>;
+		pwm-dutycycle-range = <91 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vcck>;
 };
 
 &ethmac {
@@ -180,6 +199,14 @@
 	};
 };
 
+&pwm_cd {
+	status = "okay";
+	pinctrl-0 = <&pwm_c1_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_XTAL>;
+	clock-names = "clkin0";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.19.0
