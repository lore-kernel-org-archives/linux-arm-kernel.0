From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 11:54:25 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: bring rk3399-firefly power-tree in
 line
Message-ID: <20170523095427.7421-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power-tree on the rk3399-firefly did not completely match the
documentation and vendor devicetree. It was also missing some
supply-hirarchy information and some regulator-gpio names did not
match the schematics. Fix this for the existing regulators before
introducing new things.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 96 ++++++++++++++-----------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 40b11041ed89..ef47360ad286 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -95,6 +95,15 @@
 		#clock-cells = <0>;
 	};
 
+	dc_12v: dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	rt5640-sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "rockchip,rt5640-codec";
@@ -134,15 +143,27 @@
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	/* switched by pmic_sleep */
+	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8>;
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_drv>;
+		pinctrl-0 = <&pcie_pwr_en>;
 		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
 		regulator-boot-on;
+		vin-supply = <&dc_12v>;
 	};
 
 	vcc3v3_sys: vcc3v3-sys {
@@ -152,32 +173,29 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
 	};
 
+	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
+		pinctrl-0 = <&vcc5v0_host_en>;
 		regulator-name = "vcc5v0_host";
 		regulator-always-on;
+		vin-supply = <&vcc_sys>;
 	};
 
-	vcc5v0_sys: vcc5v0-sys {
+	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
+		regulator-name = "vcc_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-	};
-
-	vcc_phy: vcc-phy-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_phy";
-		regulator-always-on;
-		regulator-boot-on;
+		vin-supply = <&dc_12v>;
 	};
 
 	vdd_log: vdd-log {
@@ -188,15 +206,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
-	};
-
-	vccadc_ref: vccadc-ref {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_sys>;
 	};
 };
 
@@ -232,7 +242,7 @@
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
 	clock_in_out = "input";
-	phy-supply = <&vcc_phy>;
+	phy-supply = <&vcc_lan>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -262,16 +272,16 @@
 		rockchip,system-power-controller;
 		wakeup-source;
 
-		vcc1-supply = <&vcc3v3_sys>;
-		vcc2-supply = <&vcc3v3_sys>;
-		vcc3-supply = <&vcc3v3_sys>;
-		vcc4-supply = <&vcc3v3_sys>;
-		vcc6-supply = <&vcc3v3_sys>;
-		vcc7-supply = <&vcc3v3_sys>;
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
 		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc3v3_sys>;
-		vcc10-supply = <&vcc3v3_sys>;
-		vcc11-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
 		vcc12-supply = <&vcc3v3_sys>;
 		vddio-supply = <&vcc1v8_pmu>;
 
@@ -332,12 +342,12 @@
 				};
 			};
 
-			vcc3v0_tp: LDO_REG2 {
-				regulator-name = "vcc3v0_tp";
+			vcc2v8_dvp: LDO_REG2 {
+				regulator-name = "vcc2v8_dvp";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -355,8 +365,8 @@
 				};
 			};
 
-			vcc_sd: LDO_REG4 {
-				regulator-name = "vcc_sd";
+			vcc_sdio: LDO_REG4 {
+				regulator-name = "vcc_sdio";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -413,7 +423,7 @@
 				};
 			};
 
-			vcc3v3_s3: SWITCH_REG1 {
+			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
 				regulator-name = "vcc3v3_s3";
 				regulator-always-on;
 				regulator-boot-on;
@@ -443,7 +453,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -460,7 +470,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -528,7 +538,7 @@
 
 	bt656-supply = <&vcc1v8_dvp>;
 	audio-supply = <&vcca1v8_codec>;
-	sdmmc-supply = <&vcc_sd>;
+	sdmmc-supply = <&vcc_sdio>;
 	gpio1830-supply = <&vcc_3v0>;
 };
 
@@ -563,7 +573,7 @@
 	};
 
 	pcie {
-		pcie_drv: pcie-drv {
+		pcie_pwr_en: pcie-pwr-en {
 			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
@@ -601,7 +611,7 @@
 	};
 
 	usb2 {
-		host_vbus_drv: host-vbus-drv {
+		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
@@ -616,7 +626,7 @@
 };
 
 &saradc {
-	vref-supply = <&vccadc_ref>;
+	vref-supply = <&vcca1v8_s3>;
 	status = "okay";
 };
 
-- 
2.11.0
