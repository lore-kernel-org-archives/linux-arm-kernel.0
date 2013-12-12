From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Dec 2013 14:30:43 -0600
Subject: [PATCHv6 3/5] dts: socfpga: Add support for SD/MMC on the SOCFPGA
 platform
In-Reply-To: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Message-ID: <1386880245-10192-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Adds a new binding, "altr,socfpga-sdmmc-sdr-clk". This is a new clock
binding that the SD/MMC driver can use the common clock framework to
set the appropriate clock phase shift settings for the CIU clock.

Also add the "syscon" binding to the "altr,sys-mgr" node. The clock
driver can use the syscon driver to toggle the register for the SD/MMC
clock phase shift settings.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v6: Add documentation for "altr,socfpga-sdmmc-sdr-clk". Add "syscon" to the
sysmgr binding.
v5: Use the "snps,dw-mshc" binding
v4: Re-use "rockchip,rk2928-dw-mshc" binding
v3: none
v2: none
---
 .../devicetree/bindings/clock/altr_socfpga.txt     |   11 +++++++++--
 arch/arm/boot/dts/socfpga.dtsi                     |   19 ++++++++++++++++++-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   12 ++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   12 ++++++++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++++++++++++
 5 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index 0045433..a2e75f0 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -11,10 +11,17 @@ Required properties:
 		PLL clock.
 	"altr,socfpga-gate-clk" - Clocks that directly feed peripherals and
 		can get gated.
+	"altr,socfpga-sdmmc-sdr-clk" - Clock that controls the SD/MMC SDR phase
+		shift settings for the SD/MMC
 
-- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
+- reg : shall be one of the following:
+	* For the "altr,socfpga-sdmmc-sdr-clk" clock, reg will the register
+		offset that controls the SD/MMC SDR phase shift settings.
+	* For all of the other clocks, control register offset from
+		CLOCK_MANAGER's base for the clock.
 - clocks : shall be the input parent clock phandle for the clock. This is
-	either an oscillator or a pll output.
+	either an oscillator or a pll output. This is an optional field for
+	the "altr,socfpga-sdmmc-sdr-clk" clock.
 - #clock-cells : from common clock binding, shall be set to 0.
 
 Optional properties:
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f936476..4be9aaf 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -436,6 +436,12 @@
 						clocks = <&f2s_periph_ref_clk>, <&main_qspi_clk>, <&per_qspi_clk>;
 						clk-gate = <0xa0 11>;
 					};
+
+					sdr_mmc_clk: sdr_mmc_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-sdmmc-sdr-clk";
+						reg = <0x108>;
+					};
 				};
 			};
 
@@ -469,6 +475,17 @@
 			cache-level = <2>;
 		};
 
+		mmc: dwmmc0 at ff704000 {
+			compatible = "snps,dw-mshc";
+			reg = <0xff704000 0x1000>;
+			interrupts = <0 139 4>;
+			fifo-depth = <0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&l4_mp_clk>, <&sdmmc_clk>, <&sdr_mmc_clk>;
+			clock-names = "biu", "ciu", "sdr_mmc_clk";
+		};
+
 		/* Local timer */
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
@@ -523,7 +540,7 @@
 		};
 
 		sysmgr at ffd08000 {
-				compatible = "altr,sys-mgr";
+				compatible = "altr,sys-mgr", "syscon";
 				reg = <0xffd08000 0x4000>;
 			};
 	};
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index a85b404..112b7e2 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -27,6 +27,18 @@
 			};
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		serial0 at ffc02000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index a8716f6..52b1501 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -28,6 +28,18 @@
 			};
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		ethernet at ff702000 {
 			phy-mode = "rgmii";
 			phy-addr = <0xffffffff>; /* probe for phy addr */
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index d1ec0ca..9e93768 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,18 @@
 			};
 		};
 
+		dwmmc0 at ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
+
+			slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			};
+		};
+
 		ethernet at ff700000 {
 			phy-mode = "gmii";
 			status = "okay";
-- 
1.7.9.5
