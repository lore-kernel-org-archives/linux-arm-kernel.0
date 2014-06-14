From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 13 Jun 2014 22:00:35 -0500
Subject: [PATCHv2] clk: socfpga: Add a second parent option for the
 dbg_base_clk
Message-ID: <1402714835-19861-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The debug base clock can be bypassed from the main PLL to the OSC1 clock.
The bypass register is the staysoc1(0x10) register that is in the clock
manager.

This patch adds the option to get the correct parent for the debug base
clock.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v2: Update socfpga_periph_init to support multiple parents
---
 arch/arm/boot/dts/socfpga.dtsi   |    2 +-
 drivers/clk/socfpga/clk-periph.c |   21 +++++++++++++++++----
 drivers/clk/socfpga/clk.h        |    1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 291eff1..26d755b 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -139,7 +139,7 @@
 						dbg_base_clk: dbg_base_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
-							clocks = <&main_pll>;
+							clocks = <&main_pll>, <&osc1>;
 							div-reg = <0xe8 0 9>;
 							reg = <0x50>;
 						};
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 46531c3..9b64847 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -45,8 +45,17 @@ static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
+static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
+{
+	u32 clk_src;
+
+	clk_src = readl(clk_mgr_base_addr + CLKMGR_DBCTRL);
+	return clk_src & 0x1;
+}
+
 static const struct clk_ops periclk_ops = {
 	.recalc_rate = clk_periclk_recalc_rate,
+	.get_parent = clk_periclk_get_parent,
 };
 
 static __init void __socfpga_periph_init(struct device_node *node,
@@ -56,11 +65,12 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	struct clk *clk;
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
-	const char *parent_name;
+	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	int rc;
 	u32 fixed_div;
 	u32 div_reg[3];
+	int i = 0;
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -90,9 +100,12 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	init.name = clk_name;
 	init.ops = ops;
 	init.flags = 0;
-	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
+			of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	init.parent_names = parent_name;
+	init.num_parents = i;
 
 	periph_clk->hw.hw.init = &init;
 
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d291f60..d036de2 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -23,6 +23,7 @@
 /* Clock Manager offsets */
 #define CLKMGR_CTRL		0x0
 #define CLKMGR_BYPASS		0x4
+#define CLKMGR_DBCTRL		0x10
 #define CLKMGR_L4SRC		0x70
 #define CLKMGR_PERPLL_SRC	0xAC
 
-- 
1.7.9.5
