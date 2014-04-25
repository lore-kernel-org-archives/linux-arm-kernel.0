From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Apr 2014 17:44:46 +0200
Subject: [PATCH 2/7] ARM: tegra: venice2 - Enable HDMI
In-Reply-To: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
References: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1398440691-23366-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add HDMI +5V, VDD and PLL regulators and enable the DDC I2C controller.
Enable the HDMI device, provide the power supplies as well as the DDC
adapter and use the standard pin (PN7) for hotplug detection.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 6770e2bdf226..84a6ec039e1d 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -17,6 +17,18 @@
 	};
 
 	host1x at 0,50000000 {
+		hdmi at 0,54280000 {
+			status = "okay";
+
+			vdd-supply = <&vdd_3v3_hdmi>;
+			pll-supply = <&vdd_hdmi_pll>;
+			hdmi-supply = <&vdd_5v0_hdmi>;
+
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			nvidia,hpd-gpio =
+				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		};
+
 		sor at 0,54540000 {
 			status = "okay";
 
@@ -601,7 +613,7 @@
 		clock-frequency = <100000>;
 	};
 
-	i2c at 0,7000c700 {
+	hdmi_ddc: i2c at 0,7000c700 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
@@ -700,7 +712,7 @@
 					regulator-boot-on;
 				};
 
-				sd4 {
+				vdd_1v05_run: sd4 {
 					regulator-name = "+1.05V_RUN";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
@@ -1147,6 +1159,27 @@
 			enable-active-high;
 			vin-supply = <&vdd_3v3_sys>;
 		};
+
+		vdd_hdmi_pll: regulator at 11 {
+			compatible = "regulator-fixed";
+			reg = <11>;
+			regulator-name = "+1.05V_RUN_AVDD_HDMI_PLL";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+			vin-supply = <&vdd_1v05_run>;
+		};
+
+		vdd_5v0_hdmi: regulator at 12 {
+			compatible = "regulator-fixed";
+			reg = <12>;
+			regulator-name = "+5V_HDMI_CON";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_5v0_sys>;
+		};
 	};
 
 	sound {
-- 
1.9.2
