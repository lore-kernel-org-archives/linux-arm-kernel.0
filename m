From: atull@kernel.org (Alan Tull)
Date: Wed, 21 Feb 2018 14:25:41 -0600
Subject: [PATCH] arm64: dts: stratix10: enable i2c, add i2c periperals
Message-ID: <20180221202541.3258-1-atull@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock for i2c
Enable i2c1
Set the i2c bus speed to 100KHz
Add the following i2c peripherals
* ds1339 RTC
* 24c32 EEPROM
* max1619 temperature monitor
* ltc2497 ADC
  * Add a fixed regulator for the ADC's Vref.

This requires Dinh Nguyen's Stratix10 clock driver
("clk: socfpga: stratix10: add clock driver for Stratix10 platform")

Signed-off-by: Alan Tull <atull@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  5 ++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 5a6a699..65d9256 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -210,6 +210,7 @@
 			reg = <0xffc02800 0x100>;
 			interrupts = <0 103 4>;
 			resets = <&rst I2C0_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
@@ -220,6 +221,7 @@
 			reg = <0xffc02900 0x100>;
 			interrupts = <0 104 4>;
 			resets = <&rst I2C1_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
@@ -230,6 +232,7 @@
 			reg = <0xffc02a00 0x100>;
 			interrupts = <0 105 4>;
 			resets = <&rst I2C2_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
@@ -240,6 +243,7 @@
 			reg = <0xffc02b00 0x100>;
 			interrupts = <0 106 4>;
 			resets = <&rst I2C3_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
@@ -250,6 +254,7 @@
 			reg = <0xffc02c00 0x100>;
 			interrupts = <0 107 4>;
 			resets = <&rst I2C4_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index b7f0b6b..cf3b519 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -51,6 +51,13 @@
 		reg = <0 0 0 0>;
 	};
 
+	ref_033v: 033-v-ref {
+		compatible = "regulator-fixed";
+		regulator-name = "0.33V";
+		regulator-min-microvolt = <330000>;
+		regulator-max-microvolt = <330000>;
+	};
+
 	soc {
 		clock-controller at ffd10000 {
 			clocks {
@@ -111,3 +118,30 @@
 &usb0 {
 	status = "okay";
 };
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	adc at 14 {
+		compatible = "lltc,ltc2497";
+		reg = <0x14>;
+		vref-supply = <&ref_033v>;
+	};
+
+	temp at 4c {
+		compatible = "maxim,max1619";
+		reg = <0x4c>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
-- 
2.7.4
