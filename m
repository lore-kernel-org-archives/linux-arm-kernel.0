From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 17 Apr 2014 11:40:52 -0700
Subject: [PATCH] clk: zynq: Leave debug clocks in bootup state
Message-ID: <1397760052-3310-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure debug clocks stay enabled if the bootloader enabled them.
Otherwise debug HW may crash due to bus-hangs caused by stopped clocks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/clkc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 52c09afdcfb7..246cf1226eaa 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -53,6 +53,9 @@ static void __iomem *zynq_clkc_base;
 
 #define NUM_MIO_PINS	54
 
+#define DBG_CLK_CTRL_CLKACT_TRC		BIT(0)
+#define DBG_CLK_CTRL_CPU_1XCLKACT	BIT(1)
+
 enum zynq_clk {
 	armpll, ddrpll, iopll,
 	cpu_6or4x, cpu_3or2x, cpu_2x, cpu_1x,
@@ -499,6 +502,15 @@ static void __init zynq_clk_setup(struct device_node *np)
 			clk_output_name[cpu_1x], 0, SLCR_DBG_CLK_CTRL, 1, 0,
 			&dbgclk_lock);
 
+	/* leave debug clocks in the state the bootloader set them up to */
+	tmp = clk_readl(SLCR_DBG_CLK_CTRL);
+	if (tmp & DBG_CLK_CTRL_CLKACT_TRC)
+		if (clk_prepare_enable(clks[dbg_trc]))
+			pr_warn("%s: trace clk enable failed\n", __func__);
+	if (tmp & DBG_CLK_CTRL_CPU_1XCLKACT)
+		if (clk_prepare_enable(clks[dbg_apb]))
+			pr_warn("%s: debug APB clk enable failed\n", __func__);
+
 	/* One gated clock for all APER clocks. */
 	clks[dma] = clk_register_gate(NULL, clk_output_name[dma],
 			clk_output_name[cpu_2x], 0, SLCR_APER_CLK_CTRL, 0, 0,
-- 
1.9.2.1.g06c4abd
