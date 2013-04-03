From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  3 Apr 2013 16:45:16 +0200
Subject: [PATCH v3 10/12] ARM: tegra: harmony: Initialize PCIe from DT
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1365000318-28256-11-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/boot/dts/tegra20-harmony.dts | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 5fb0888..8799d7a 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -334,7 +334,7 @@
 					regulator-always-on;
 				};
 
-				ldo0 {
+				pci_clk_reg: ldo0 {
 					regulator-name = "vdd_ldo0,vddio_pex_clk";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -418,6 +418,20 @@
 		nvidia,invert-interrupt;
 	};
 
+	pcie-controller {
+		pex-clk-supply = <&pci_clk_reg>;
+		vdd-supply = <&pci_vdd_reg>;
+		status = "okay";
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
 	usb at c5000000 {
 		status = "okay";
 	};
@@ -601,7 +615,7 @@
 			enable-active-high;
 		};
 
-		regulator at 3 {
+		pci_vdd_reg: regulator at 3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
 			regulator-name = "vdd_1v05";
@@ -609,8 +623,6 @@
 			regulator-max-microvolt = <1050000>;
 			gpio = <&pmic 2 0>;
 			enable-active-high;
-			/* Hack until board-harmony-pcie.c is removed */
-			status = "disabled";
 		};
 
 		regulator at 4 {
-- 
1.8.2
