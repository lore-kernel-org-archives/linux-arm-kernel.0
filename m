From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 10:54:25 -0700
Subject: [PATCH] ARM: tegra: whistler: enable HDMI port
Message-ID: <1353088465-25556-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable host1x, and the HDMI output. Whistler also has a DSI-based LCD,
and a VGA output. tegradrm doesn't support either of those output types
yet.

Based on work by Thierry Reding for TrimSlice.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-whistler.dts |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 94a71c9..20d576e 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -10,6 +10,18 @@
 		reg = <0x00000000 0x20000000>;
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
@@ -246,6 +258,11 @@
 		clock-frequency = <216000000>;
 	};
 
+	hdmi_ddc: i2c at 7000c400 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <100000>;
@@ -356,7 +373,7 @@
 					regulator-always-on;
 				};
 
-				ldo6 {
+				hdmi_pll_reg: ldo6 {
 					regulator-name = "nvvdd_ldo6,avdd_hdmi_pll";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -388,7 +405,7 @@
 					regulator-always-on;
 				};
 
-				ldo11 {
+				hdmi_vdd_reg: ldo11 {
 					regulator-name = "nvvdd_ldo11,vddio_pex_clk,vcom_33,avdd_hdmi";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
-- 
1.7.10.4
