From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Thu, 12 Jun 2014 17:11:24 +0200
Subject: [PATCH 1/2] ARM: tegra: tamonten: add the base board regulators
Message-ID: <1402585885-28247-1-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the Tamonten DTS define a fixed regulator for the 5V supply.
However this regulator is in fact on the base board. Fix this by
properly defining the regulators found on the base boards.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 arch/arm/boot/dts/tegra20-medcom-wide.dts | 46 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-plutux.dts      | 46 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-tamonten.dtsi   | 10 +------
 arch/arm/boot/dts/tegra20-tec.dts         | 46 +++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index 6d3a4cb..0cd05f7 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -64,4 +64,50 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	board_regulators {
+		compatible = "simple-bus";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vcc_24v_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vcc_24v";
+			regulator-min-microvolt = <24000000>;
+			regulator-max-microvolt = <24000000>;
+			regulator-always-on;
+		};
+
+		vdd_5v0_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_5v0";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		vdd_3v3_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_3v3";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd_1v8_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_1v8";
+			vin-supply = <&vdd_3v3_reg>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 29051a2..a1b0e86 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -58,4 +58,50 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	board_regulators {
+		compatible = "simple-bus";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vcc_24v_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vcc_24v";
+			regulator-min-microvolt = <24000000>;
+			regulator-max-microvolt = <24000000>;
+			regulator-always-on;
+		};
+
+		vdd_5v0_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_5v0";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		vdd_3v3_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_3v3";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd_1v8_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_1v8";
+			vin-supply = <&vdd_3v3_reg>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index a1b0d96..9c83185 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -334,6 +334,7 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 
+			/* vdd_5v0_reg must be provided by the base board */
 			sys-supply = <&vdd_5v0_reg>;
 			vin-sm0-supply = <&sys_reg>;
 			vin-sm1-supply = <&sys_reg>;
@@ -511,15 +512,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		vdd_5v0_reg: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vdd_5v0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
-
 		pci_vdd_reg: regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 890562c..173201a 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -67,4 +67,50 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	board_regulators {
+		compatible = "simple-bus";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vcc_24v_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vcc_24v";
+			regulator-min-microvolt = <24000000>;
+			regulator-max-microvolt = <24000000>;
+			regulator-always-on;
+		};
+
+		vdd_5v0_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_5v0";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		vdd_3v3_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_3v3";
+			vin-supply = <&vcc_24v_reg>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd_1v8_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_1v8";
+			vin-supply = <&vdd_3v3_reg>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
 };
-- 
2.0.0
