From: ayaka@soulik.info (Randy Li)
Date: Thu,  7 Jul 2016 02:22:59 +0800
Subject: [PATCH 2/3] ARM: dts: move regulator settings from common to specifics
In-Reply-To: <1467829380-16242-1-git-send-email-ayaka@soulik.info>
References: <3015470.z4L7UQJKa9@phil>
 <1467829380-16242-1-git-send-email-ayaka@soulik.info>
Message-ID: <1467829380-16242-3-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator settings are the same in the firefly beta and
firefly release version. But the firefly reload is different.
I remove the different part from the common header dtsi file,
but remained those common one to keep references.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly-beta.dts | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dts      | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi     | 12 +++++-------
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly-beta.dts b/arch/arm/boot/dts/rk3288-firefly-beta.dts
index 75d77e3..375c5d8 100644
--- a/arch/arm/boot/dts/rk3288-firefly-beta.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-beta.dts
@@ -69,3 +69,33 @@
 &pwm0 {
 	status = "okay";
 };
+
+&gmac {
+	phy-supply = <&vcc_lan>;
+};
+
+&io_domains {
+		audio-supply = <&vcca_33>;
+		flash1-supply = <&vcc_lan>;
+};
+
+&act8846_regs {
+	vcca_18: REG7  {
+		regulator-name = "vcca_18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcca_33: REG8 {
+		regulator-name = "vcca_33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vcc_lan: REG9 {
+		regulator-name = "vcc_lan";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dts b/arch/arm/boot/dts/rk3288-firefly.dts
index c07fe92..e89e575 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dts
+++ b/arch/arm/boot/dts/rk3288-firefly.dts
@@ -69,3 +69,33 @@
 &pwm1 {
 	status = "okay";
 };
+
+&gmac {
+	phy-supply = <&vcc_lan>;
+};
+
+&io_domains {
+		audio-supply = <&vcca_33>;
+		flash1-supply = <&vcc_lan>;
+};
+
+&act8846_regs {
+	vcca_18: REG7  {
+		regulator-name = "vcca_18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vcca_33: REG8 {
+		regulator-name = "vcca_33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vcc_lan: REG9 {
+		regulator-name = "vcc_lan";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 1d7f03c..194e05a 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -68,11 +68,9 @@
 		compatible = "rockchip,rk3288-io-voltage-domain";
 		rockchip,grf = <&grf>;
 
-		audio-supply = <&vcca_33>;
 		bb-supply = <&vcc_io>;
 		dvp-supply = <&dovdd_1v8>;
 		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
 		gpio30-supply = <&vcc_io>;
 		gpio1830-supply = <&vcc_io>;
 		lcdc-supply = <&vcc_io>;
@@ -225,7 +223,6 @@
 	clock_in_out = "input";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
-	phy-supply = <&vcc_lan>;
 	phy-mode = "rgmii";
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
@@ -296,7 +293,7 @@
 		inl2-supply = <&vcc_sys>;
 		inl3-supply = <&vcc_20>;
 
-		regulators {
+		act8846_regs: regulators {
 			vcc_ddr: REG1 {
 				regulator-name = "vcc_ddr";
 				regulator-min-microvolt = <1200000>;
@@ -339,19 +336,20 @@
 				regulator-always-on;
 			};
 
-			vcca_18: REG7 {
+			REG7  {
 				regulator-name = "vcca_18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			vcca_33: REG8 {
+			REG8 {
 				regulator-name = "vcca_33";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
-			vcc_lan: REG9 {
+			REG9 {
 				regulator-name = "vcc_lan";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-- 
2.7.4
