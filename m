From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 21 Mar 2018 09:20:11 -0500
Subject: [PATCHv7 2/3] arm64: dts: stratix10: use clock bindings for the
 Stratix10 platform
In-Reply-To: <1521642012-9770-1-git-send-email-dinguyen@kernel.org>
References: <1521642012-9770-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1521642012-9770-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the clock bindings for the Stratix10 SoC. This includes changing the old
binding of "intc,clk-s10-mgr" to "intel,stratix10-clkmgr". The reason that
this can be done is that there are currently no clock driver for Stratix10,
thus there are no consumers of the old binding. So changing the binding will
not break any legacy code.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7:
- move PLL out of clkmgr node and into DT root
v6:
- no changes
v5:
- no changes
v4:
- remove '_' in name of clock nodes
- use clock-controller in SoCDK node in dts file
v3:
- use the correct vendor prefix
- explain the binding change
v2:
- use a single clock binding for the clock controller
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 47 +++++++++++++++++++++-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  8 ++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index c89d0c30..0e267c8 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -17,6 +17,7 @@
 /dts-v1/;
 #include <dt-bindings/reset/altr,rst-mgr-s10.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/stratix10-clock.h>
 
 / {
 	compatible = "altr,socfpga-stratix10";
@@ -92,9 +93,32 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
-		clkmgr at ffd1000 {
-			compatible = "altr,clk-mgr";
+		clkmgr: clock-controller at ffd10000 {
+			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clocks {
+			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			cb_intosc_ls_clk: cb-intosc-ls-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			f2s_free_clk: f2s-free-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			osc1: osc1 {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
 		};
 
 		gmac0: ethernet at ff800000 {
@@ -105,6 +129,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -116,6 +142,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -127,6 +155,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC2_RESET>;
 			reset-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
+			clock-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -229,6 +259,9 @@
 			fifo-depth = <0x400>;
 			resets = <&rst SDMMC_RESET>;
 			reset-names = "reset";
+			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
+				 <&clkmgr STRATIX10_SDMMC_CLK>;
+			clock-names = "biu", "ciu";
 			status = "disabled";
 		};
 
@@ -288,24 +321,32 @@
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 113 4>;
 			reg = <0xffc03000 0x100>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
+			clock-names = "timer";
 		};
 
 		timer1: timer1 at ffc03100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 114 4>;
 			reg = <0xffc03100 0x100>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
+			clock-names = "timer";
 		};
 
 		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 115 4>;
 			reg = <0xffd00000 0x100>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
+			clock-names = "timer";
 		};
 
 		timer3: timer3 at ffd00100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 116 4>;
 			reg = <0xffd00100 0x100>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
+			clock-names = "timer";
 		};
 
 		uart0: serial0 at ffc02000 {
@@ -315,6 +356,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			resets = <&rst UART0_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
@@ -325,6 +367,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			resets = <&rst UART1_RESET>;
+			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 0007564..8880190 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -50,6 +50,14 @@
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0 0 0>;
 	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
 };
 
 &gpio1 {
-- 
2.7.4
