From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:11:43 +0100
Subject: [PATCH 3/3] arm: dove: Convert Dove to DT XOR DMA engine
In-Reply-To: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319903-30855-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

With DT support for Marvell XOR DMA engine, make use of it on Dove.
Also remove the now redundant code in DT board init for xor engines.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/dove.dtsi |   42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/common.c |   10 ----------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 8c8ab621..ff56bff 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -174,5 +174,47 @@
 			clocks = <&gate_clk 15>;
 			status = "okay";
 		};
+
+		xor0: dma-engine at 60800 {
+			compatible = "marvell,orion-xor";
+			reg = <0x60800 0x100
+			       0x60a00 0x100>;
+			clocks = <&gate_clk 23>;
+			status = "okay";
+
+			channel0 {
+				interrupts = <39>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+
+			channel1 {
+				interrupts = <40>;
+				dmacap,memset;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+		};
+
+		xor1: dma-engine at 60900 {
+			compatible = "marvell,orion-xor";
+			reg = <0x60900 0x100
+			       0x60b00 0x100>;
+			clocks = <&gate_clk 24>;
+			status = "okay";
+
+			channel0 {
+				interrupts = <42>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+
+			channel1 {
+				interrupts = <43>;
+				dmacap,memset;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index a209444..97a7abe 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -409,14 +409,6 @@ static void __init dove_legacy_clk_init(void)
 	clkspec.args[0] = CLOCK_GATING_BIT_PCIE1;
 	orion_clkdev_add("1", "pcie",
 			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CLOCK_GATING_BIT_XOR0;
-	orion_clkdev_add(NULL, MV_XOR_NAME ".0",
-			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CLOCK_GATING_BIT_XOR1;
-	orion_clkdev_add(NULL, MV_XOR_NAME ".1",
-			 of_clk_get_from_provider(&clkspec));
 }
 
 static void __init dove_of_clk_init(void)
@@ -445,8 +437,6 @@ static void __init dove_dt_init(void)
 
 	/* Internal devices not ported to DT yet */
 	dove_rtc_init();
-	dove_xor0_init();
-	dove_xor1_init();
 
 	dove_ge00_init(&dove_dt_ge00_data);
 	dove_ehci0_init();
-- 
1.7.9.5
