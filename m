From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 14 Oct 2016 18:30:26 +0530
Subject: [PATCH 2/9] ARM: dra72-evm: Fix modelling of regulators
In-Reply-To: <20161014130033.14172-1-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Message-ID: <20161014130033.14172-3-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add proper description of input voltage regulators and update the voltage
rail map for all the regulators.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 3c02612..8537b6a 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -18,11 +18,47 @@
 		display0 = &hdmi0;
 	};
 
+	evm_12v0: fixedregulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	evm_5v0: fixedregulator-evm5v0 {
+		/* Output 1 of TPS43351QDAPRQ1 */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: fixedregulator-vsys3v3 {
+		/* Output 2 of TPS43351QDAPRQ1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	evm_3v3_sw: fixedregulator-evm_3v3 {
+		/* TPS22965DSG */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
 	};
 
 	aic_dvdd: fixedregulator-aic_dvdd {
@@ -39,6 +75,7 @@
 		regulator-name = "evm_3v3_sd";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_3v3_sw>;
 		enable-active-high;
 		gpio = <&pcf_gpio_21 5 GPIO_ACTIVE_HIGH>;
 	};
@@ -190,6 +227,17 @@
 		tps65917_pmic {
 			compatible = "ti,tps65917-pmic";
 
+			smps1-in-supply = <&vsys_3v3>;
+			smps2-in-supply = <&vsys_3v3>;
+			smps3-in-supply = <&vsys_3v3>;
+			smps4-in-supply = <&vsys_3v3>;
+			smps5-in-supply = <&vsys_3v3>;
+			ldo1-in-supply = <&vsys_3v3>;
+			ldo2-in-supply = <&vsys_3v3>;
+			ldo3-in-supply = <&vsys_3v3>;
+			ldo4-in-supply = <&evm_5v0>;
+			ldo5-in-supply = <&vsys_3v3>;
+
 			tps65917_regulators: regulators {
 				smps1_reg: smps1 {
 					/* VDD_MPU */
-- 
2.9.3
