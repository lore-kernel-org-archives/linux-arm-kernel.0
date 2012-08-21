From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 21 Aug 2012 16:47:29 +0530
Subject: [PATCH v3 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
Message-ID: <1345547850-29761-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tps65910 regulator device tree data to AM335x-EVM by adding
regulator consumers with tightened constraints and regulator-name.
TPS65910 regulator handle can be obtained by using this regulator
name.

This patch also add I2C node with I2C frequency and tps65910 PMIC
I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 1e1fc15..f9c28a5 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -38,5 +38,99 @@
 		dcan1: d_can at 481D0000 {
 			status = "okay";
 		};
+
+		i2c1: i2c at 44E0B000 {
+			status = "okay";
+			clock-frequency = <400000>;
+
+			tps: tps at 2D {
+				reg = <0x2D>;
+			};
+		};
+	};
+
+	vbat: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+};
+
+/include/ "tps65910.dtsi"
+
+&tps {
+	vcc1-supply = <&vbat>;
+	vcc2-supply = <&vbat>;
+	vcc3-supply = <&vbat>;
+	vcc4-supply = <&vbat>;
+	vcc5-supply = <&vbat>;
+	vcc6-supply = <&vbat>;
+	vcc7-supply = <&vbat>;
+	vccio-supply = <&vbat>;
+
+	regulators {
+		vrtc_reg: regulator at 0 {
+			regulator-always-on;
+		};
+
+		vio_reg: regulator at 1 {
+			regulator-always-on;
+		};
+
+		vdd1_reg: regulator at 2 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1312500>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator at 3 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1150000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd3_reg: regulator at 4 {
+			regulator-always-on;
+		};
+
+		vdig1_reg: regulator at 5 {
+			regulator-always-on;
+		};
+
+		vdig2_reg: regulator at 6 {
+			regulator-always-on;
+		};
+
+		vpll_reg: regulator at 7 {
+			regulator-always-on;
+		};
+
+		vdac_reg: regulator at 8 {
+			regulator-always-on;
+		};
+
+		vaux1_reg: regulator at 9 {
+			regulator-always-on;
+		};
+
+		vaux2_reg: regulator at 10 {
+			regulator-always-on;
+		};
+
+		vaux33_reg: regulator at 11 {
+			regulator-always-on;
+		};
+
+		vmmc_reg: regulator at 12 {
+			regulator-always-on;
+		};
 	};
 };
-- 
1.7.9.5
