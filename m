From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:33 +0100
Subject: [PATCH 09/10] ARM: tegra: Enable HDMI support on Dalmore
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-10-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add HDMI node to the Dalmore device tree and hook up the VDD and PLL
regulators as well as the I2C adapter used for DDC and the GPIO used
for hotplug detection.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 512922f049c3..73aecfb57ccb 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -17,6 +17,17 @@
 	};
 
 	host1x at 50000000 {
+		hdmi at 54280000 {
+			status = "okay";
+
+			vdd-supply = <&vdd_hdmi_reg>;
+			pll-supply = <&palmas_smps3_reg>;
+
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			nvidia,hpd-gpio =
+				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		};
+
 		dsi at 54300000 {
 			status = "okay";
 
@@ -773,6 +784,10 @@
 		};
 	};
 
+	hdmi_ddc: i2c at 7000c700 {
+		status = "okay";
+	};
+
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
-- 
1.8.4.2
