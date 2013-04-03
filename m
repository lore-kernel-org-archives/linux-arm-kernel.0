From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  3 Apr 2013 16:45:17 +0200
Subject: [PATCH v3 11/12] ARM: tegra: trimslice: Initialize PCIe from DT
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1365000318-28256-12-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- add missing dummy regulator nodes by Stephen Warren
- rename port 0 DT node and disable unused port 1

 arch/arm/boot/dts/tegra20-trimslice.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 955bf49..dc081c3 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -300,6 +300,16 @@
 		};
 	};
 
+	pcie-controller {
+		status = "okay";
+		pex-clk-supply = <&pci_clk_reg>;
+		vdd-supply = <&pci_vdd_reg>;
+
+		pci at 1,0 {
+			status = "okay";
+		};
+	};
+
 	usb at c5000000 {
 		status = "okay";
 		nvidia,vbus-gpio = <&gpio 170 0>; /* gpio PV2 */
@@ -357,6 +367,24 @@
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
+
+		pci_clk_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "pci_clk";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		pci_vdd_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "pci_vdd";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
 	};
 
 	sound {
-- 
1.8.2
