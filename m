From: markz@nvidia.com (Mark Zhang)
Date: Fri, 30 Nov 2012 13:44:16 +0800
Subject: [PATCH] ARM: dt: tegra: cardhu: Add drm components
Message-ID: <1354254256-10212-1-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the RGB & HDMI nodes in Tegra 30 cardhu's dts.
This makes the LVDS & HDMI working.

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
Changes:
- This patch depcrates the patch:
  "[PATCH V2] ARM: dt: tegra: cardhu: Add drm components"
  Because the issue that LCD and HDMI can't work at the same time
  has been fixed by Thierry's patch:
  "drm: tegra: Use framebuffer pitch as line stride"

 arch/arm/boot/dts/tegra30-cardhu.dtsi |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index bdb2a66..9b33bfb 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -27,6 +27,25 @@
 	model = "NVIDIA Tegra30 Cardhu evaluation board";
 	compatible = "nvidia,cardhu", "nvidia,tegra30";
 
+	host1x {
+		dc at 54200000 {
+			rgb {
+				status = "okay";
+				nvidia,ddc-i2c-bus = <&rgb_ddc>;
+			};
+		};
+
+		hdmi {
+			status = "okay";
+
+			vdd-supply = <&sys_3v3_reg>;
+			pll-supply = <&vio_reg>;
+
+			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+		};
+	};
+
 	memory {
 		reg = <0x80000000 0x40000000>;
 	};
@@ -114,7 +133,7 @@
 		clock-frequency = <408000000>;
 	};
 
-	i2c at 7000c000 {
+	rgb_ddc: i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
@@ -137,7 +156,7 @@
 		};
 	};
 
-	i2c at 7000c700 {
+	hdmi_ddc: i2c at 7000c700 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
-- 
1.7.9.5
