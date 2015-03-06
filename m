From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:12:58 +0100
Subject: [PATCH v2 05/11] ARM: berlin: rework the clock node for BG2
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of the Berlin mfd controller driver, all drivers
previously sharing the chip and system controller nodes now have their
own sub-node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 43 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index fbe5c6b6502d..0cbe99da16dc 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -56,7 +56,7 @@
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-			clocks = <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
+			clocks = <&chip_clk CLKID_SDIO0XIN>, <&chip_clk CLKID_SDIO0>;
 			clock-names = "io", "core";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -65,7 +65,7 @@
 		sdhci1: sdhci at ab0800 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0800 0x200>;
-			clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO1>;
 			clock-names = "io", "core";
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -75,7 +75,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_NFC_ECC>, <&chip CLKID_NFC>;
+			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
 			clock-names = "io", "core";
 			pinctrl-0 = <&emmc_pmux>;
 			pinctrl-names = "default";
@@ -105,13 +105,13 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&chip CLKID_TWD>;
+			clocks = <&chip_clk CLKID_TWD>;
 		};
 
 		eth1: ethernet at b90000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xb90000 0x10000>;
-			clocks = <&chip CLKID_GETH1>;
+			clocks = <&chip_clk CLKID_GETH1>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			/* set by bootloader */
 			local-mac-address = [00 00 00 00 00 00];
@@ -134,7 +134,7 @@
 		eth0: ethernet at e50000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xe50000 0x10000>;
-			clocks = <&chip CLKID_GETH0>;
+			clocks = <&chip_clk CLKID_GETH0>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			/* set by bootloader */
 			local-mac-address = [00 00 00 00 00 00];
@@ -233,7 +233,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
 				interrupts = <8>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -242,7 +242,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c14 0x14>;
 				interrupts = <9>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -251,7 +251,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c28 0x14>;
 				interrupts = <10>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -260,7 +260,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c3c 0x14>;
 				interrupts = <11>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -269,7 +269,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c50 0x14>;
 				interrupts = <12>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -278,7 +278,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c64 0x14>;
 				interrupts = <13>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -287,7 +287,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c78 0x14>;
 				interrupts = <14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -296,7 +296,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c8c 0x14>;
 				interrupts = <15>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -315,7 +315,7 @@
 			compatible = "marvell,berlin2-ahci", "generic-ahci";
 			reg = <0xe90000 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_SATA>;
+			clocks = <&chip_clk CLKID_SATA>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -335,7 +335,7 @@
 		sata_phy: phy at e900a0 {
 			compatible = "marvell,berlin2-sata-phy";
 			reg = <0xe900a0 0x200>;
-			clocks = <&chip CLKID_SATA>;
+			clocks = <&chip_clk CLKID_SATA>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#phy-cells = <1>;
@@ -353,9 +353,14 @@
 		chip: chip-controller at ea0000 {
 			compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
-			#clock-cells = <1>;
-			clocks = <&refclk>;
-			clock-names = "refclk";
+
+			chip_clk: clock {
+				compatible = "marvell,berlin2-clk";
+
+				#clock-cells = <1>;
+				clocks = <&refclk>;
+				clock-names = "refclk";
+			};
 
 			soc_pinctrl: pin-controller {
 				compatible = "marvell,berlin2-soc-pinctrl";
-- 
2.3.1
