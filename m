From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 7 Dec 2015 21:09:25 +0800
Subject: [PATCH 2/2] ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1
In-Reply-To: <1449493765-5111-1-git-send-email-jszhang@marvell.com>
References: <1449493765-5111-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449493765-5111-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We removed CLK_IGNORE_UNUSED from CLKID_SDIO's flag, so the sdhci0 and
sdhci1 don't work. We fix this by adding the optional 2nd clock for
BG2Q's sdhci0 and sdhci1. This patch brings another benefit: the 2nd
clock can be disabled during runtime pm, so saves power a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 5b10129..fb1da99 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -118,7 +118,8 @@
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-			clocks = <&chip_clk CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO>;
+			clock-names = "io", "core";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -126,7 +127,8 @@
 		sdhci1: sdhci at ab0800 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0800 0x200>;
-			clocks = <&chip_clk CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO>;
+			clock-names = "io", "core";
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
2.6.2
