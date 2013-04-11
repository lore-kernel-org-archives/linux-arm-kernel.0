From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 11 Apr 2013 10:55:25 -0500
Subject: [PATCHv3 2/3] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
References: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
Message-ID: <1365695726-26849-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Adds the main PLL clock groups for SOCFPGA into device tree file
so that the clock framework to query the clock and clock rates
appropriately.

$cat /sys/kernel/debug/clk/clk_summary
   clock                        enable_cnt  prepare_cnt  rate
---------------------------------------------------------------------
 osc1                           2           2            25000000
    sdram_pll                   0           0            400000000
       s2f_usr2_clk             0           0            66666666
       ddr_dq_clk               0           0            200000000
       ddr_2x_dqs_clk           0           0            400000000
       ddr_dqs_clk              0           0            200000000
    periph_pll                  2           2            500000000
       s2f_usr1_clk             0           0            50000000
       per_base_clk             4           4            100000000
       per_nand_mmc_clk         0           0            25000000
       per_qsi_clk              0           0            250000000
       emac1_clk                1           1            125000000
       emac0_clk                0           0            125000000
    main_pll                    1           1            1600000000
       cfg_s2f_usr0_clk         0           0            100000000
       main_nand_sdmmc_clk      0           0            100000000
       main_qspi_clk            0           0            400000000
       dbg_base_clk             0           0            400000000
       mainclk                  0           0            400000000
       mpuclk                   1           1            800000000
          smp_twd               1           1            200000000

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

v3:
- Use basic clk_gate structure and reuse clk_gate_ops
- Split out patches between dts and source

v2:
- Add copyright from Calxeda for clk.c
- Add device tree "fixed-divider" for clocks with fixed dividers
- Fix space and tab issues
---
 .../bindings/arm/altera/socfpga-clk-manager.txt    |   11 ++
 .../devicetree/bindings/clock/altr_socfpga.txt     |   18 +++
 arch/arm/boot/dts/socfpga.dtsi                     |  157 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |    8 +
 arch/arm/boot/dts/socfpga_vt.dts                   |    8 +
 5 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644 Documentation/devicetree/bindings/clock/altr_socfpga.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
new file mode 100644
index 0000000..2c28f1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
@@ -0,0 +1,11 @@
+Altera SOCFPGA Clock Manager
+
+Required properties:
+- compatible : "altr,clk-mgr"
+- reg : Should contain base address and length for Clock Manager
+
+Example:
+	 clkmgr at ffd04000 {
+		compatible = "altr,clk-mgr";
+		reg = <0xffd04000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
new file mode 100644
index 0000000..bd0c841
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -0,0 +1,18 @@
+Device Tree Clock bindings for Altera's SoCFPGA platform
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"altr,socfpga-pll-clock" - for a PLL clock
+	"altr,socfpga-perip-clock" - The peripheral clock divided from the
+		PLL clock.
+- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
+- clocks : shall be the input parent clock phandle for the clock. This is
+	either an oscillator or a pll output.
+- #clock-cells : from common clock binding, shall be set to 0.
+
+Optional properties:
+- fixed-divider : If clocks have a fixed divider value, use this property.
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7e8769b..16a6e13 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -81,6 +81,163 @@
 			};
 		};
 
+		clkmgr at ffd04000 {
+				compatible = "altr,clk-mgr";
+				reg = <0xffd04000 0x1000>;
+
+				clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					osc: osc1 {
+						#clock-cells = <0>;
+						compatible = "fixed-clock";
+					};
+
+					main_pll: main_pll {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-pll-clock";
+						clocks = <&osc>;
+						reg = <0x40>;
+
+						mpuclk: mpuclk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							fixed-divider = <2>;
+							reg = <0x48>;
+						};
+
+						mainclk: mainclk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							fixed-divider = <4>;
+							reg = <0x4C>;
+						};
+
+						dbg_base_clk: dbg_base_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							fixed-divider = <4>;
+							reg = <0x50>;
+						};
+
+						main_qspi_clk: main_qspi_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							reg = <0x54>;
+						};
+
+						main_nand_sdmmc_clk: main_nand_sdmmc_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							reg = <0x58>;
+						};
+
+						cfg_s2f_usr0_clk: cfg_s2f_usr0_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&main_pll>;
+							reg = <0x5C>;
+						};
+					};
+
+					periph_pll: periph_pll {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-pll-clock";
+						clocks = <&osc>;
+						reg = <0x80>;
+
+						emac0_clk: emac0_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x88>;
+						};
+
+						emac1_clk: emac1_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x8C>;
+						};
+
+						per_qspi_clk: per_qsi_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x90>;
+						};
+
+						per_nand_mmc_clk: per_nand_mmc_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x94>;
+						};
+
+						per_base_clk: per_base_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x98>;
+						};
+
+						s2f_usr1_clk: s2f_usr1_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&periph_pll>;
+							reg = <0x9C>;
+						};
+					};
+
+					sdram_pll: sdram_pll {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-pll-clock";
+						clocks = <&osc>;
+						reg = <0xC0>;
+
+						ddr_dqs_clk: ddr_dqs_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&sdram_pll>;
+							reg = <0xC8>;
+						};
+
+						ddr_2x_dqs_clk: ddr_2x_dqs_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&sdram_pll>;
+							reg = <0xCC>;
+						};
+
+						ddr_dq_clk: ddr_dq_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&sdram_pll>;
+							reg = <0xD0>;
+						};
+
+						s2f_usr2_clk: s2f_usr2_clk {
+							#clock-cells = <0>;
+							compatible = "altr,socfpga-perip-clk";
+							clocks = <&sdram_pll>;
+							reg = <0xD4>;
+						};
+					};
+				};
+			};
+
 		gmac0: stmmac at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			reg = <0xff700000 0x2000>;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 3ae8a83..2495958 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -33,6 +33,14 @@
 	};
 
 	soc {
+		clkmgr at ffd04000 {
+			clocks {
+				osc1 {
+					clock-frequency = <25000000>;
+				};
+			};
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 1036eba..0bf035d 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -33,6 +33,14 @@
 	};
 
 	soc {
+		clkmgr at ffd04000 {
+			clocks {
+				osc1 {
+					clock-frequency = <10000000>;
+				};
+			};
+		};
+
 		timer0 at ffc08000 {
 			clock-frequency = <7000000>;
 		};
-- 
1.7.9.5
