From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Sep 2014 10:02:45 -0600
Subject: [PATCH 2/2] ARM: tegra: jetson-tk1: Enable PCIe support
In-Reply-To: <1410969765-18070-1-git-send-email-swarren@wwwdotorg.org>
References: <1410969765-18070-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1410969765-18070-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Enable both PCIe ports, one of which is connected to an onboard ethernet
chip, whereas the other goes to a miniPCIe slot.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[swarren, fixed PCIe supply property names in DT]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 64828c265414..029c9a021541 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -16,6 +16,26 @@
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
+	pcie-controller at 0,01003000 {
+		status = "okay";
+
+		avddio-pex-supply = <&vdd_1v05_run>;
+		dvddio-pex-supply = <&vdd_1v05_run>;
+		avdd-pex-pll-supply = <&vdd_1v05_run>;
+		hvdd-pex-supply = <&vdd_3v3_lp0>;
+		hvdd-pex-pll-e-supply = <&vdd_3v3_lp0>;
+		vddio-pex-ctl-supply = <&vdd_3v3_lp0>;
+		avdd-pll-erefe-supply = <&avdd_1v05_run>;
+
+		pci at 1,0 {
+			status = "okay";
+		};
+
+		pci at 2,0 {
+			status = "okay";
+		};
+	};
+
 	host1x at 0,50000000 {
 		hdmi at 0,54280000 {
 			status = "okay";
@@ -1550,7 +1570,7 @@
 					regulator-always-on;
 				};
 
-				ldo0 {
+				avdd_1v05_run: ldo0 {
 					regulator-name = "+1.05V_RUN_AVDD";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
-- 
1.9.1
