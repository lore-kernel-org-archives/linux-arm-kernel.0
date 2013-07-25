From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 10:53:21 -0700
Subject: [PATCH v5 07/16] ARM: tegra: trimslice: Initialize PCIe from DT
In-Reply-To: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
References: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1374774810-18459-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <thierry.reding@avionic-design.de>

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add missing dummy regulator nodes by Stephen Warren
- rename port 0 DT node and disable unused port 1

 arch/arm/boot/dts/tegra20-trimslice.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index ed4b901..9f1b237 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -310,6 +310,16 @@
 		nvidia,sys-clock-req-active-high;
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
 		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
@@ -413,6 +423,24 @@
 			enable-active-high;
 			gpio = <&gpio 170 0>; /* PV2 */
 		};
+
+		pci_clk_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "pci_clk";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		pci_vdd_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "pci_vdd";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
 	};
 
 	sound {
-- 
1.8.1.5
