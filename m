From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 16 Apr 2014 15:14:29 -0500
Subject: [PATCH 1/2] clk: socfpga: add divider registers to the main pll
 outputs
Message-ID: <1397679270-29695-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The C0(mpu_clk), C1(main_clk), and C2(dbg_base_clk) outputs from the main
PLL go through a pre-divider before coming into the system. These registers
were hidden for the CycloneV platform, but are not used for the ArriaV
platform.

This patch updates the clock driver to read the div-reg property for the
socfpga-periph-clk clocks. Also moves the div_mask define to clk.h for re-use.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 drivers/clk/socfpga/clk-gate.c   |    1 -
 drivers/clk/socfpga/clk-periph.c |   22 +++++++++++++++++++---
 drivers/clk/socfpga/clk.h        |    4 ++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 501d513..dd3a78c 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -32,7 +32,6 @@
 #define SOCFPGA_MMC_CLK			"sdmmc_clk"
 #define SOCFPGA_GPIO_DB_CLK_OFFSET	0xA8
 
-#define div_mask(width)	((1 << (width)) - 1)
 #define streq(a, b) (strcmp((a), (b)) == 0)
 
 #define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 81623a3..46531c3 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -29,12 +29,18 @@ static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
 					     unsigned long parent_rate)
 {
 	struct socfpga_periph_clk *socfpgaclk = to_socfpga_periph_clk(hwclk);
-	u32 div;
+	u32 div, val;
 
-	if (socfpgaclk->fixed_div)
+	if (socfpgaclk->fixed_div) {
 		div = socfpgaclk->fixed_div;
-	else
+	} else {
+		if (socfpgaclk->div_reg) {
+			val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
+			val &= div_mask(socfpgaclk->width);
+			parent_rate /= (val + 1);
+		}
 		div = ((readl(socfpgaclk->hw.reg) & 0x1ff) + 1);
+	}
 
 	return parent_rate / div;
 }
@@ -54,6 +60,7 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	struct clk_init_data init;
 	int rc;
 	u32 fixed_div;
+	u32 div_reg[3];
 
 	of_property_read_u32(node, "reg", &reg);
 
@@ -63,6 +70,15 @@ static __init void __socfpga_periph_init(struct device_node *node,
 
 	periph_clk->hw.reg = clk_mgr_base_addr + reg;
 
+	rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
+	if (!rc) {
+		periph_clk->div_reg = clk_mgr_base_addr + div_reg[0];
+		periph_clk->shift = div_reg[1];
+		periph_clk->width = div_reg[2];
+	} else {
+		periph_clk->div_reg = 0;
+	}
+
 	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
 	if (rc)
 		periph_clk->fixed_div = 0;
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d2e5401..d291f60 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -27,6 +27,7 @@
 #define CLKMGR_PERPLL_SRC	0xAC
 
 #define SOCFPGA_MAX_PARENTS		3
+#define div_mask(width) ((1 << (width)) - 1)
 
 extern void __iomem *clk_mgr_base_addr;
 
@@ -52,6 +53,9 @@ struct socfpga_periph_clk {
 	struct clk_gate hw;
 	char *parent_name;
 	u32 fixed_div;
+	void __iomem *div_reg;
+	u32 width;      /* only valid if div_reg != 0 */
+	u32 shift;      /* only valid if div_reg != 0 */
 };
 
 #endif /* SOCFPGA_CLK_H */
-- 
1.7.9.5
