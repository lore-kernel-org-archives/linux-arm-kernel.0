From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 12:44:11 +0200
Subject: [PATCH v2 4/5] arm64: dts: marvell: Enable second SDHCI controller in
 Armada 37xx
In-Reply-To: <20170613104412.1616-1-gregory.clement@free-electrons.com>
References: <20170613104412.1616-1-gregory.clement@free-electrons.com>
Message-ID: <20170613104412.1616-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Konstantin Porotchkin <kostap@marvell.com>

The Armada 37xx SoCs has 2 SDHCI interfaces. This patch adds the second
one.

Moreover, the Armada 37xx DB v2 board populates the 2 SDHCI interfaces.

The second interface is using pluggable module that can either
have an SD connector or eMMC on it.
This patch adds support for SD module in the device DT.

[ gregory.clement at free-electrons.com:
 - Add more detail in commit log
 - Sort the dt node in address order
 - Document the SD slot in the dts ]

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  9 +++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3ee920ac0015..eab3bc7e6382 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -158,6 +158,15 @@
 	status = "okay";
 };
 
+/* SD slot module on CON14(V2.0)/CON15(V1.4) */
+&sdhci1 {
+	wp-inverted;
+	cd-gpios = <&gpiosb 2 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	marvell,pad-type = "sd";
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index c1076fd0bd9e..6e3d50cf10db 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -292,6 +292,17 @@
 				};
 			};
 
+			sdhci1: sdhci at d0000 {
+				compatible = "marvell,armada-3700-sdhci",
+					     "marvell,sdhci-xenon";
+				reg = <0xd0000 0x300
+				       0x1e808 0x4>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nb_periph_clk 0>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
 			sdhci0: sdhci at d8000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
-- 
2.11.0
