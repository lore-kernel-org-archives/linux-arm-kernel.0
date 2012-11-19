From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:11:42 +0100
Subject: [PATCH 2/3] arm: kirkwood: Convert XOR instantiation to DT.
In-Reply-To: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319903-30855-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Use DT to describe the two XOR DMA engines on Kirkwood. Remove the
C code initialization.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi   |   40 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c |   13 ------------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index e5ebf42..83716ee 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -94,6 +94,46 @@
 			status = "okay";
 		};
 
+		xor at 60800 {
+			compatible = "marvell,orion-xor";
+			reg = <0x60800 0x100
+			       0x60A00 0x100>;
+			status = "okay";
+			clocks = <&gate_clk 8>;
+
+			xor00 {
+			      interrupts = <5>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			};
+			xor01 {
+			      interrupts = <6>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			      dmacap,memset;
+			};
+		};
+
+		xor at 60900 {
+			compatible = "marvell,orion-xor";
+			reg = <0x60900 0x100
+			       0xd0B00 0x100>;
+			status = "okay";
+			clocks = <&gate_clk 16>;
+
+			xor00 {
+			      interrupts = <7>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			};
+			xor01 {
+			      interrupts = <8>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			      dmacap,memset;
+			};
+		};
+
 		sata at 80000 {
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 994ce26..5cabdff 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -21,7 +21,6 @@
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/usb-ehci-orion.h>
-#include <linux/platform_data/dma-mv_xor.h>
 #include <plat/irq.h>
 #include <plat/common.h>
 #include "common.h"
@@ -60,14 +59,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	orion_clkdev_add(NULL, "orion-ehci.0",
 			 of_clk_get_from_provider(&clkspec));
 
-	clkspec.args[0] = CGC_BIT_XOR0;
-	orion_clkdev_add(NULL, MV_XOR_NAME ".0",
-			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CGC_BIT_XOR1;
-	orion_clkdev_add(NULL, MV_XOR_NAME ".1",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CGC_BIT_PEX1;
 	orion_clkdev_add("1", "pcie",
 			 of_clk_get_from_provider(&clkspec));
@@ -104,10 +95,6 @@ static void __init kirkwood_dt_init(void)
 	/* Setup root of clk tree */
 	kirkwood_of_clk_init();
 
-	/* internal devices that every board has */
-	kirkwood_xor0_init();
-	kirkwood_xor1_init();
-
 #ifdef CONFIG_KEXEC
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
-- 
1.7.9.5
