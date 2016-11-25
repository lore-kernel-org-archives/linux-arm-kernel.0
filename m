From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Nov 2016 16:30:18 +0100
Subject: [PATCH net-next 5/5] ARM64: dts: marvell: Add network support for
 Armada 3700
In-Reply-To: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
References: <cover.2b146800967005632cd02d4da77397e6e2fdf51f.1480087510.git-series.gregory.clement@free-electrons.com>
Message-ID: <88d69f125ff8557f95313687d16f7e01a1b0f083.1480087510.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add neta nodes for network support both in device tree for the SoC and
the board.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 23 +++++++++++++++++++-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 23 +++++++++++++++++++-
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 1372e9a6aaa4..c8b82e4145de 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -81,3 +81,26 @@
 &pcie0 {
 	status = "okay";
 };
+
+&mdio {
+	status = "okay";
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&eth0 {
+	phy-mode = "rgmii-id";
+	phy = <&phy0>;
+	status = "okay";
+};
+
+&eth1 {
+	phy-mode = "rgmii-id";
+	phy = <&phy1>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e9bd58793464..3b8eb45bdc76 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -140,6 +140,29 @@
 				};
 			};
 
+			eth0: ethernet at 30000 {
+				   compatible = "marvell,armada-3700-neta";
+				   reg = <0x30000 0x4000>;
+				   interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				   clocks = <&sb_periph_clk 8>;
+				   status = "disabled";
+			};
+
+			mdio: mdio at 32004 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,orion-mdio";
+				reg = <0x32004 0x4>;
+			};
+
+			eth1: ethernet at 40000 {
+				compatible = "marvell,armada-3700-neta";
+				reg = <0x40000 0x4000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&sb_periph_clk 7>;
+				status = "disabled";
+			};
+
 			usb3: usb at 58000 {
 				compatible = "marvell,armada3700-xhci",
 				"generic-xhci";
-- 
git-series 0.8.10
