From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 9 Dec 2013 18:02:53 -0600
Subject: [PATCHv2] clk: socfpga: Map the clk manager base address in the clock
 driver
Message-ID: <1386633773-11713-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The clk manager's base address was being mapped in SOCFPGA's arch code and
being extern'ed out to the clock driver. This method is not correct, and the
arch code was not really doing anything with that clk manager anyways.

This patch moves the mapping of the clk manager's base address in the clock
driver itself. Cleans up CLK_OF_DECLARE() into a single registration of all
the clocks.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v2: Use a static declaration for the clk_mgr_base_addr. Clean up the
    CLK_OF_DECLARE() as suggested by Arnd.
---
 arch/arm/mach-socfpga/socfpga.c |    4 ----
 drivers/clk/socfpga/clk.c       |   20 ++++++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 60cb2f5..280c983 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -22,6 +22,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 /* Clock Manager offsets */
 #define CLKMGR_CTRL	0x0
@@ -55,7 +56,7 @@
 #define div_mask(width)	((1 << (width)) - 1)
 #define streq(a, b) (strcmp((a), (b)) == 0)
 
-extern void __iomem *clk_mgr_base_addr;
+static void __iomem *clk_mgr_base_addr;
 
 struct socfpga_clk {
 	struct clk_gate hw;
@@ -320,19 +321,30 @@ static void __init socfpga_pll_init(struct device_node *node)
 {
 	socfpga_clk_init(node, &clk_pll_ops);
 }
-CLK_OF_DECLARE(socfpga_pll, "altr,socfpga-pll-clock", socfpga_pll_init);
 
 static void __init socfpga_periph_init(struct device_node *node)
 {
 	socfpga_clk_init(node, &periclk_ops);
 }
-CLK_OF_DECLARE(socfpga_periph, "altr,socfpga-perip-clk", socfpga_periph_init);
 
 static void __init socfpga_gate_init(struct device_node *node)
 {
 	socfpga_gate_clk_init(node, &gateclk_ops);
 }
-CLK_OF_DECLARE(socfpga_gate, "altr,socfpga-gate-clk", socfpga_gate_init);
+
+static struct of_device_id socfpga_child_clocks[] = {
+	{ .compatible = "altr,socfpga-pll-clock", socfpga_pll_init, },
+	{ .compatible = "altr,socfpga-perip-clk", socfpga_periph_init, },
+	{ .compatible = "altr,socfpga-gate-clk", socfpga_gate_init, },
+	{},
+};
+
+static void __init socfpga_clkmgr_init(struct device_node *node)
+{
+	clk_mgr_base_addr = of_iomap(node, 0);
+	of_clk_init(socfpga_child_clocks);
+}
+CLK_OF_DECLARE(socfpga_mgr, "altr,clk-mgr", socfpga_clkmgr_init);
 
 void __init socfpga_init_clocks(void)
 {
-- 
1.7.9.5
