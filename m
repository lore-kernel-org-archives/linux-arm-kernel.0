From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Apr 2014 17:44:51 +0200
Subject: [PATCH 7/7] ARM: tegra: dalmore - Add DSI power supply
In-Reply-To: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
References: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1398440691-23366-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The 1.2V supply for CSI and DSI was previously marked always-on. This is
suboptimal because it prevents the supply from being disabled when there
is no activity in the display or capture paths that it powers.

Hook up the regulator to the DSI output and mark it as not always-on, so
that it will only be enabled when DSI actually needs it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 1309c75c821c..9cd09b63b900 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -37,6 +37,8 @@
 		dsi at 54300000 {
 			status = "okay";
 
+			avdd-dsi-csi-supply = <&avdd_1v2_reg>;
+
 			panel at 0 {
 				compatible = "panasonic,vvx10f004b00",
 					     "simple-panel";
@@ -983,12 +985,10 @@
 						regulator-max-microvolt = <2800000>;
 					};
 
-					ldo3 {
+					avdd_1v2_reg: ldo3 {
 						regulator-name = "avdd-dsi-csi";
 						regulator-min-microvolt = <1200000>;
 						regulator-max-microvolt = <1200000>;
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					ldo4 {
-- 
1.9.2
