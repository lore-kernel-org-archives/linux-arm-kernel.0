From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:26 +0100
Subject: [PATCH 02/10] ARM: tegra: Enable LVDS on Cardhu
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-3-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add backlight and panel nodes for the Cardhu 10.1" WXGA TFT LCD panel.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- split HDMI support into a separate patch

Changes in v2:
- remove backlight-boot-off property for now

 arch/arm/boot/dts/tegra30-cardhu.dtsi | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index dfcc18adcfd7..9104224124ee 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -56,6 +56,16 @@
 		};
 	};
 
+	host1x at 50000000 {
+		dc at 54200000 {
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
 	pinmux at 70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -152,7 +162,11 @@
 		status = "okay";
 	};
 
-	i2c at 7000c000 {
+	pwm at 7000a000 {
+		status = "okay";
+	};
+
+	panelddc: i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
@@ -372,6 +386,17 @@
 		status = "okay";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_bl_reg>;
+		pwms = <&pwm 0 5000000>;
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -385,6 +410,16 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "chunghwa,claa101wb01", "simple-panel";
+		ddc-i2c-bus = <&panelddc>;
+
+		power-supply = <&vdd_pnl1_reg>;
+		enable-gpios = <&gpio TEGRA_GPIO(L, 2) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.8.4.2
