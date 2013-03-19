From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 19 Mar 2013 10:45:36 -0500
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
Message-ID: <1363707936-17769-2-git-send-email-dinguyen@altera.com>
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

v2:
- Add copyright from Calxeda for clk.c
- Add device tree "fixed-divider" for clocks with fixed dividers
- Fix space and tab issues
---
 .../bindings/arm/altera/socfpga-clk-manager.txt    |   11 ++
 .../devicetree/bindings/clock/altr_socfpga.txt     |   18 ++
 arch/arm/boot/dts/socfpga.dtsi                     |  157 +++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |    8 +
 arch/arm/boot/dts/socfpga_vt.dts                   |    8 +
 arch/arm/mach-socfpga/socfpga.c                    |    6 +
 drivers/clk/socfpga/clk.c                          |  179 +++++++++++++++++---
 7 files changed, 366 insertions(+), 21 deletions(-)
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
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index b41a945..856625a 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/dw_apb_timer.h>
+#include <linux/clk-provider.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -29,6 +30,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
+void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -77,6 +79,9 @@ void __init socfpga_sysmgr_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
+
+	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	clk_mgr_base_addr = of_iomap(np, 0);
 }
 
 static void __init socfpga_init_irq(void)
@@ -102,6 +107,7 @@ static void __init socfpga_cyclone5_init(void)
 {
 	l2x0_of_init(0, ~0UL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_clk_init(NULL);
 	socfpga_init_clocks();
 }
 
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 2c855a6..da6b461 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -1,5 +1,6 @@
 /*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *  Copyright 2011-2012 Calxeda, Inc.
+ *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -11,41 +12,177 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
+ * Based from clk-highbank.c
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
 
-#define SOCFPGA_OSC1_CLK	10000000
-#define SOCFPGA_MPU_CLK		800000000
-#define SOCFPGA_MAIN_QSPI_CLK		432000000
-#define SOCFPGA_MAIN_NAND_SDMMC_CLK	250000000
-#define SOCFPGA_S2F_USR_CLK		125000000
+/* Clock Manager offsets */
+#define CLKMGR_CTRL    0x0
+#define CLKMGR_BYPASS 0x4
 
-void __init socfpga_init_clocks(void)
+/* Clock bypass bits */
+#define MAINPLL_BYPASS (1<<0)
+#define SDRAMPLL_BYPASS (1<<1)
+#define SDRAMPLL_SRC_BYPASS (1<<2)
+#define PERPLL_BYPASS (1<<3)
+#define PERPLL_SRC_BYPASS (1<<4)
+
+#define SOCFPGA_PLL_BG_PWRDWN  0x00000001
+#define SOCFPGA_PLL_EXT_ENA    0x00000002
+#define SOCFPGA_PLL_PWR_DOWN   0x00000004
+#define SOCFPGA_PLL_DIVF_MASK 0x0000FFF8
+#define SOCFPGA_PLL_DIVF_SHIFT 3
+#define SOCFPGA_PLL_DIVQ_MASK 0x003F0000
+#define SOCFPGA_PLL_DIVQ_SHIFT 15
+
+extern void __iomem *clk_mgr_base_addr;
+
+struct socfpga_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+	char *parent_name;
+	char *clk_name;
+};
+#define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw)
+
+static int clk_pll_enable(struct clk_hw *hwclk)
+{
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
+	u32 reg;
+
+	reg = readl(socfpgaclk->reg);
+	reg |= SOCFPGA_PLL_EXT_ENA;
+	writel(reg, socfpgaclk->reg);
+
+	return 0;
+}
+
+static void clk_pll_disable(struct clk_hw *hwclk)
 {
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
+	u32 reg;
+
+	reg = readl(socfpgaclk->reg);
+	reg &= ~SOCFPGA_PLL_EXT_ENA;
+	writel(reg, socfpgaclk->reg);
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
+					 unsigned long parent_rate)
+{
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
+	unsigned long divf, divq, vco_freq, reg;
+	unsigned long bypass;
+
+	reg = readl(socfpgaclk->reg);
+	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
+	if (bypass & MAINPLL_BYPASS)
+		return parent_rate;
+
+	divf = (reg & SOCFPGA_PLL_DIVF_MASK) >> SOCFPGA_PLL_DIVF_SHIFT;
+	divq = (reg & SOCFPGA_PLL_DIVQ_MASK) >> SOCFPGA_PLL_DIVQ_SHIFT;
+	vco_freq = parent_rate * (divf + 1);
+	return vco_freq / (1 << divq);
+}
+
+
+static const struct clk_ops clk_pll_ops = {
+	.enable = clk_pll_enable,
+	.disable = clk_pll_disable,
+	.recalc_rate = clk_pll_recalc_rate,
+};
+
+static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
+					     unsigned long parent_rate)
+{
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
+	u32 div;
+
+	if (socfpgaclk->fixed_div)
+		div = socfpgaclk->fixed_div;
+	else
+		div = ((readl(socfpgaclk->reg) & 0x1ff) + 1);
+
+	return parent_rate / div;
+}
+
+static const struct clk_ops periclk_ops = {
+	.recalc_rate = clk_periclk_recalc_rate,
+};
+
+static __init struct clk *socfpga_clk_init(struct device_node *node, const struct clk_ops *ops)
+{
+	u32 reg;
 	struct clk *clk;
+	struct socfpga_clk *socfpga_clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct clk_init_data init;
+	int rc;
+	u32 fixed_div;
+
+	rc = of_property_read_u32(node, "reg", &reg);
+	if (WARN_ON(rc))
+		return NULL;
+
+	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
+	if (WARN_ON(!socfpga_clk))
+		return NULL;
+
+	socfpga_clk->reg = clk_mgr_base_addr + reg;
 
-	clk = clk_register_fixed_rate(NULL, "osc1_clk", NULL, CLK_IS_ROOT, SOCFPGA_OSC1_CLK);
-	clk_register_clkdev(clk, "osc1_clk", NULL);
+	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
+	if (rc)
+		socfpga_clk->fixed_div = 0;
+	else
+		socfpga_clk->fixed_div = fixed_div;
 
-	clk = clk_register_fixed_rate(NULL, "mpu_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK);
-	clk_register_clkdev(clk, "mpu_clk", NULL);
+	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate(NULL, "main_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK/2);
-	clk_register_clkdev(clk, "main_clk", NULL);
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = 0;
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
 
-	clk = clk_register_fixed_rate(NULL, "dbg_base_clk", NULL, CLK_IS_ROOT, SOCFPGA_MPU_CLK/2);
-	clk_register_clkdev(clk, "dbg_base_clk", NULL);
+	socfpga_clk->hw.init = &init;
 
-	clk = clk_register_fixed_rate(NULL, "main_qspi_clk", NULL, CLK_IS_ROOT, SOCFPGA_MAIN_QSPI_CLK);
-	clk_register_clkdev(clk, "main_qspi_clk", NULL);
+	clk = clk_register(NULL, &socfpga_clk->hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(socfpga_clk);
+		return NULL;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return clk;
+}
+
+static void __init socfpga_pll_init(struct device_node *node)
+{
+	socfpga_clk_init(node, &clk_pll_ops);
+}
+CLK_OF_DECLARE(socfpga_pll, "altr,socfpga-pll-clock", socfpga_pll_init);
+
+static void __init socfpga_periph_init(struct device_node *node)
+{
+	socfpga_clk_init(node, &periclk_ops);
+}
+CLK_OF_DECLARE(socfpga_periph, "altr,socfpga-perip-clk", socfpga_periph_init);
 
-	clk = clk_register_fixed_rate(NULL, "main_nand_sdmmc_clk", NULL, CLK_IS_ROOT, SOCFPGA_MAIN_NAND_SDMMC_CLK);
-	clk_register_clkdev(clk, "main_nand_sdmmc_clk", NULL);
+void __init socfpga_init_clocks(void)
+{
+	struct clk *clk;
+	int ret;
 
-	clk = clk_register_fixed_rate(NULL, "s2f_usr_clk", NULL, CLK_IS_ROOT, SOCFPGA_S2F_USR_CLK);
-	clk_register_clkdev(clk, "s2f_usr_clk", NULL);
+	clk = clk_register_fixed_factor(NULL, "smp_twd", "mpuclk", 0, 1, 4);
+	ret = clk_register_clkdev(clk, NULL, "smp_twd");
+	if (ret)
+		pr_err("smp_twd alias not registered\n");
 }
-- 
1.7.9.5
