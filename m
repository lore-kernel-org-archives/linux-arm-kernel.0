From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:54:06 +0300
Subject: [PATCH 5/5] arm64: tegra: Add ethernet controller on Tegra194
In-Reply-To: <20180620125406.11906-1-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
Message-ID: <20180620125406.11906-5-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra194 contains the same ethernet controller as the Tegra186.
Add the device tree node for it, and correspondingly the PHY node
on the board device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 40d688f7de1c..7f2563b78bc7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -27,6 +27,26 @@
 	};
 
 	cbb {
+		ethernet at 2490000 {
+			status = "okay";
+
+			phy-reset-gpios = <&gpio TEGRA194_MAIN_GPIO(G, 5) GPIO_ACTIVE_LOW>;
+			phy-handle = <&phy>;
+			phy-mode = "rgmii";
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy: phy at 0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0x0>;
+					interrupt-parent = <&gpio>;
+					interrupts = <TEGRA194_MAIN_GPIO(G, 4) IRQ_TYPE_LEVEL_LOW>;
+				};
+			};
+		};
+
 		serial at 3110000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index abe2d688eb65..11666ceb3a24 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -35,6 +35,28 @@
 			gpio-controller;
 		};
 
+		ethernet at 2490000 {
+			compatible = "nvidia,tegra186-eqos",
+				     "snps,dwc-qos-ethernet-4.10";
+			reg = <0x02490000 0x10000>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_AXI_CBB>,
+				 <&bpmp TEGRA194_CLK_EQOS_AXI>,
+				 <&bpmp TEGRA194_CLK_EQOS_RX>,
+				 <&bpmp TEGRA194_CLK_EQOS_TX>,
+				 <&bpmp TEGRA194_CLK_EQOS_PTP_REF>;
+			clock-names = "master_bus", "slave_bus", "rx", "tx", "ptp_ref";
+			resets = <&bpmp TEGRA194_RESET_EQOS>;
+			reset-names = "eqos";
+			status = "disabled";
+
+			snps,write-requests = <1>;
+			snps,read-requests = <3>;
+			snps,burst-map = <0x7>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <8>;
+		};
+
 		uarta: serial at 3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.16.1
