From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:29:17 +0200
Subject: [PATCH 2/4] ARM: dts: meson8b: odroidc1: add the fixed voltage
 regulators
In-Reply-To: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
References: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180913202919.20927-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are multiple fixed regulators on the Odroid-C1 board. Add them so
they can be used when we add the devices that need them (SAR ADC needs
the 1.8V IOREF, RTC needs VDD_RTC).
These are:
- P5V0 is the main 5V power input
- VCC3V3 / VDDIO_AO3V3 / VDD3V3: fixed regulator with 3.3V output which
  is supplied by P5V0
- IOREF_1V8 / VCC1V8 / VDD1V8: fixed regulator with 1.8V output which is
  supplied by P5V0
- VDD_RTC: fixed voltage regulator with 0.9V output which is supplied by
  VDDIO_AO3V3
- DDR_VDDC / DDR3_1V5: fixed voltage regulator with 1.5V output which is
  supplied by P5V0
- the existing TF_IO and RFLASH_VDD_EN regulators are supplied by
  VDDIO_AO3V3
- the existing VCCK regulator is supplied by P5V0

This does not add the missing VDDEE regulator (controlled by PWM_D)
because it's not clear yet how to configure the voltage of that
regulator.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0557823cdd64..a08dccccdb5e 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -71,6 +71,14 @@
 		};
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
@@ -81,6 +89,8 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		vin-supply = <&vcc_3v3>;
+
 		gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
@@ -92,6 +102,8 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
+		vin-supply = <&vcc_3v3>;
+
 		/*
 		 * signal name from schematics: TF_3V3N_1V8_EN
 		 */
@@ -102,6 +114,36 @@
 			  1800000 1>;
 	};
 
+	vcc_1v8: regulator-vcc-1v8 {
+		/*
+		 * RICHTEK RT9179 configured for a fixed output voltage of
+		 * 1.8V. This supplies not only VCC1V8 but also IOREF_1V8 and
+		 * VDD1V8 according to the schematics.
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		vin-supply = <&p5v0>;
+	};
+
+	vcc_3v3: regulator-vcc-3v3 {
+		/*
+		 * Monolithic Power Systems MP2161 configured for a fixed
+		 * output voltage of 3.3V. This supplies not only VCC3V3 but
+		 * also VDD3V3 and VDDIO_AO3V3 according to the schematics.
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&p5v0>;
+	};
+
 	vcck: regulator-vcck {
 		/* Monolithic Power Systems MP2161 */
 		compatible = "pwm-regulator";
@@ -110,12 +152,43 @@
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
+		vin-supply = <&p5v0>;
+
 		pwms = <&pwm_cd 0 12218 0>;
 		pwm-dutycycle-range = <91 0>;
 
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vddc_ddr: regulator-vddc-ddr {
+		/*
+		 * Monolithic Power Systems MP2161 configured for a fixed
+		 * output voltage of 1.5V. This supplies not only DDR_VDDC but
+		 * also DDR3_1V5 according to the schematics.
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "DDR_VDDC";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+
+		vin-supply = <&p5v0>;
+	};
+
+	vdd_rtc: regulator-vdd-rtc {
+		/*
+		 * Torex Semiconductor XC6215 configured for a fixed output of
+		 * 0.9V.
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDD_RTC";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		vin-supply = <&vcc_3v3>;
+	};
 };
 
 &cpu0 {
-- 
2.19.0
