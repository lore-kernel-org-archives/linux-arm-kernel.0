From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 14:53:21 -0700
Subject: [PATCH V2 2/3] ARM: tegra: ventana: enable HDMI port
In-Reply-To: <1357163602-10777-1-git-send-email-swarren@wwwdotorg.org>
References: <1357163602-10777-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357163602-10777-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Limit DDC I2C speed to 100KHz.
---
 arch/arm/boot/dts/tegra20-ventana.dts |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index adc4754..816eb12 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -10,6 +10,18 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	host1x {
+		hdmi {
+			status = "okay";
+
+			vdd-supply = <&hdmi_vdd_reg>;
+			pll-supply = <&hdmi_pll_reg>;
+
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -320,7 +332,7 @@
 
 	i2c at 7000c400 {
 		status = "okay";
-		clock-frequency = <400000>;
+		clock-frequency = <100000>;
 	};
 
 	i2cmux {
@@ -335,7 +347,7 @@
 		pinctrl-1 = <&state_i2cmux_pta>;
 		pinctrl-2 = <&state_i2cmux_idle>;
 
-		i2c at 0 {
+		hdmi_ddc: i2c at 0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -446,13 +458,13 @@
 					regulator-max-microvolt = <1800000>;
 				};
 
-				ldo7 {
+				hdmi_vdd_reg: ldo7 {
 					regulator-name = "vdd_ldo7,avdd_hdmi,vdd_fuse";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 				};
 
-				ldo8 {
+				hdmi_pll_reg: ldo8 {
 					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-- 
1.7.10.4
