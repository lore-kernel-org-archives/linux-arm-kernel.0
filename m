From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Sep 2018 17:14:01 -0700
Subject: [PATCH] ARM: BCM63XX: Fix incorrect interrupt specifiers
Message-ID: <20180920001402.1585-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of our interrupts were incorrectly specified, fix both the PPI
and SPI interrupts to be correct.

Fixes: b5762cacc411 ("ARM: bcm63138: add NAND DT support")
Fixes: 46d4bca0445a ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index 43ee992ccdcf..6df61518776f 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -106,21 +106,23 @@
 		global_timer: timer at 1e200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x1e200 0x20>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&axi_clk>;
 		};
 
 		local_timer: local-timer at 1e600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x1e600 0x20>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&axi_clk>;
 		};
 
 		twd_watchdog: watchdog at 1e620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x1e620 0x20>;
-			interrupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		armpll: armpll {
@@ -158,7 +160,7 @@
 		serial0: serial at 600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
-			interrupts = <GIC_SPI 32 0>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -167,7 +169,7 @@
 		serial1: serial at 620 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x620 0x1b>;
-			interrupts = <GIC_SPI 33 0>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -180,7 +182,7 @@
 			reg = <0x2000 0x600>, <0xf0 0x10>;
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
-			interrupts = <GIC_SPI 38 0>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand";
 		};
 
-- 
2.17.1
