From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 9 Dec 2013 13:30:47 -0600
Subject: [PATCH] clk: socfpga: Map the clk manager base address in the clock
 driver
Message-ID: <1386617447-1260-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The clk manager's base address was being mapped in SOCFPGA's arch code and
being extern'ed out to the clock driver. This method is not correct, and the
arch code was not really doing anything with that clk manager anyways.

This patch moves the mapping of the clk manager's base address in the clock
driver itself.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/socfpga.c |    4 ----
 drivers/clk/socfpga/clk.c       |   43 +++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dd0d49c..c43c281 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -29,7 +29,6 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
-void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -78,9 +77,6 @@ void __init socfpga_sysmgr_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
-
-	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
-	clk_mgr_base_addr = of_iomap(np, 0);
 }
 
 static void __init socfpga_init_irq(void)
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 81dd31a..d1bc773 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -22,6 +22,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 /* Clock Manager offsets */
 #define CLKMGR_CTRL	0x0
@@ -55,12 +56,11 @@
 #define div_mask(width)	((1 << (width)) - 1)
 #define streq(a, b) (strcmp((a), (b)) == 0)
 
-extern void __iomem *clk_mgr_base_addr;
-
 struct socfpga_clk {
 	struct clk_gate hw;
 	char *parent_name;
 	char *clk_name;
+	void __iomem *clk_mgr_base_addr;
 	u32 fixed_div;
 	void __iomem *div_reg;
 	u32 width;	/* only valid if div_reg != 0 */
@@ -76,7 +76,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 	unsigned long bypass;
 
 	reg = readl(socfpgaclk->hw.reg);
-	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
+	bypass = readl(socfpgaclk->hw.reg + CLKMGR_BYPASS);
 	if (bypass & MAINPLL_BYPASS)
 		return parent_rate;
 
@@ -118,6 +118,7 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
 	const char *clk_name = node->name;
 	const char *parent_name;
 	struct clk_init_data init;
+	struct device_node *clk_mgr_np;
 	int rc;
 	u32 fixed_div;
 
@@ -129,7 +130,11 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
 	if (WARN_ON(!socfpga_clk))
 		return NULL;
 
-	socfpga_clk->hw.reg = clk_mgr_base_addr + reg;
+	/* Map the clk manager register */
+	clk_mgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	socfpga_clk->hw.reg = of_iomap(clk_mgr_np, 0);
+	BUG_ON(!socfpga_clk->hw.reg);
+	socfpga_clk->hw.reg += reg;
 
 	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
 	if (rc)
@@ -167,19 +172,20 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
 
 static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 {
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
 	u32 l4_src;
 	u32 perpll_src;
 
 	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
-		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		l4_src = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 		return l4_src &= 0x1;
 	}
 	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
-		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		l4_src = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 		return !!(l4_src & 2);
 	}
 
-	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+	perpll_src = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
 		return perpll_src &= 0x3;
 	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
@@ -193,20 +199,21 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 
 static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 {
+	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
 	u32 src_reg;
 
 	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		src_reg = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 		src_reg &= ~0x1;
 		src_reg |= parent;
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+		writel(src_reg, socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 	} else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		src_reg = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 		src_reg &= ~0x2;
 		src_reg |= (parent << 1);
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+		writel(src_reg, socfpgaclk->clk_mgr_base_addr + CLKMGR_L4SRC);
 	} else {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+		src_reg = readl(socfpgaclk->clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 		if (streq(hwclk->init->name, SOCFPGA_MMC_CLK)) {
 			src_reg &= ~0x3;
 			src_reg |= parent;
@@ -218,7 +225,7 @@ static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 			src_reg &= ~0x30;
 			src_reg |= (parent << 4);
 		}
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+		writel(src_reg, socfpgaclk->clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 	}
 
 	return 0;
@@ -261,6 +268,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFGPA_MAX_PARENTS];
 	struct clk_init_data init;
+	struct device_node *clk_mgr_np;
 	int rc;
 	int i = 0;
 
@@ -268,12 +276,17 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	if (WARN_ON(!socfpga_clk))
 		return;
 
+	/* Map the clk manager register */
+	clk_mgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	socfpga_clk->clk_mgr_base_addr = of_iomap(clk_mgr_np, 0);
+	BUG_ON(!socfpga_clk->clk_mgr_base_addr);
+
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
 		clk_gate[0] = 0;
 
 	if (clk_gate[0]) {
-		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
+		socfpga_clk->hw.reg = socfpga_clk->clk_mgr_base_addr + clk_gate[0];
 		socfpga_clk->hw.bit_idx = clk_gate[1];
 
 		gateclk_ops.enable = clk_gate_ops.enable;
@@ -288,7 +301,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 
 	rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
 	if (!rc) {
-		socfpga_clk->div_reg = clk_mgr_base_addr + div_reg[0];
+		socfpga_clk->div_reg = socfpga_clk->clk_mgr_base_addr + div_reg[0];
 		socfpga_clk->shift = div_reg[1];
 		socfpga_clk->width = div_reg[2];
 	} else {
-- 
1.7.9.5
