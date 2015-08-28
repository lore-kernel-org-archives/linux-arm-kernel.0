From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:37 +0200
Subject: [PATCH 02/11] arm: tegra: colibri_t30: fix hdmi supply
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-3-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix HDMI supplies (both regular VDD as well as PLL ones) being switched
by the TPS65911 PMIC's GPIO6 aka EN_VDD_HDMI by introducing two new
GPIO switched fixed regulators avdd_hdmi_pll_1v8_reg and
avdd_hdmi_3v3_reg.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 83ba3f2..5e6a47e 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -15,8 +15,8 @@
 
 	host1x at 50000000 {
 		hdmi at 54280000 {
-			vdd-supply = <&sys_3v3_reg>;
-			pll-supply = <&vio_reg>;
+			vdd-supply = <&avdd_hdmi_3v3_reg>;
+			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
 
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
@@ -365,18 +365,40 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		sys_3v3_reg: regulator at 100 {
+		avdd_hdmi_pll_1v8_reg: regulator at 100 {
 			compatible = "regulator-fixed";
 			reg = <100>;
+			regulator-name = "+V1.8_AVDD_HDMI_PLL";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			enable-active-high;
+			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+			vin-supply = <&vio_reg>;
+		};
+
+		sys_3v3_reg: regulator at 101 {
+			compatible = "regulator-fixed";
+			reg = <101>;
 			regulator-name = "3v3";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
 
-		charge_pump_5v0_reg: regulator at 101 {
+		avdd_hdmi_3v3_reg: regulator at 102 {
 			compatible = "regulator-fixed";
-			reg = <101>;
+			reg = <102>;
+			regulator-name = "+V3.3_AVDD_HDMI";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			enable-active-high;
+			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+			vin-supply = <&sys_3v3_reg>;
+		};
+
+		charge_pump_5v0_reg: regulator at 103 {
+			compatible = "regulator-fixed";
+			reg = <103>;
 			regulator-name = "5v0";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-- 
2.4.3
