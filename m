From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 13 Feb 2015 17:43:00 +0100
Subject: [PATCH 6/7] ARM: berlin: rework the clock node for BG2CD
In-Reply-To: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423845781-7480-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of the Berlin mfd controller driver, all drivers
previously sharing the chip and system controller nodes now have their
own sub-node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 314cde70a3ba..34d3ec957243 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -48,7 +48,7 @@
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-			clocks = <&chip CLKID_SDIO0XIN>, <&chip CLKID_SDIO0>;
+			clocks = <&chip_clk CLKID_SDIO0XIN>, <&chip_clk CLKID_SDIO0>;
 			clock-names = "io", "core";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -72,7 +72,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_TWD>;
+			clocks = <&chip_clk CLKID_TWD>;
 		};
 
 		usb_phy0: usb-phy at b74000 {
@@ -94,7 +94,7 @@
 		eth1: ethernet at b90000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xb90000 0x10000>;
-			clocks = <&chip CLKID_GETH1>;
+			clocks = <&chip_clk CLKID_GETH1>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			/* set by bootloader */
 			local-mac-address = [00 00 00 00 00 00];
@@ -112,7 +112,7 @@
 		eth0: ethernet at e50000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xe50000 0x10000>;
-			clocks = <&chip CLKID_GETH0>;
+			clocks = <&chip_clk CLKID_GETH0>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			/* set by bootloader */
 			local-mac-address = [00 00 00 00 00 00];
@@ -211,7 +211,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
 				interrupts = <8>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -220,7 +220,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c14 0x14>;
 				interrupts = <9>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -229,7 +229,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c28 0x14>;
 				interrupts = <10>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -238,7 +238,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c3c 0x14>;
 				interrupts = <11>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -247,7 +247,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c50 0x14>;
 				interrupts = <12>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -256,7 +256,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c64 0x14>;
 				interrupts = <13>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -265,7 +265,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c78 0x14>;
 				interrupts = <14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -274,7 +274,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c8c 0x14>;
 				interrupts = <15>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -292,9 +292,14 @@
 		chip: chip-controller at ea0000 {
 			compatible = "marvell,berlin2cd-chip-ctrl", "syscon";
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
 				compatible = "marvell,berlin2cd-soc-pinctrl";
@@ -315,7 +320,7 @@
 			compatible = "chipidea,usb2";
 			reg = <0xed0000 0x200>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_USB0>;
+			clocks = <&chip_clk CLKID_USB0>;
 			phys = <&usb_phy0>;
 			phy-names = "usb-phy";
 			status = "disabled";
@@ -325,7 +330,7 @@
 			compatible = "chipidea,usb2";
 			reg = <0xee0000 0x200>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_USB1>;
+			clocks = <&chip_clk CLKID_USB1>;
 			phys = <&usb_phy1>;
 			phy-names = "usb-phy";
 			status = "disabled";
-- 
2.3.0
