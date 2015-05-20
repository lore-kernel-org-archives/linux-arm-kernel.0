From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 19 May 2015 22:22:41 -0500
Subject: [PATCHv4 1/2] clk: socfpga: update clk.h so for Arria10 platform to
 use
In-Reply-To: <1432092162-8889-1-git-send-email-dinguyen@opensource.altera.com>
References: <1432092162-8889-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1432092162-8889-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

There are 5 possible parent clocks for the SoCFPGA Arria10. Move the define
SYSMGR_SDMMC_CTRL_SET and streq() to clk.h so that the Arria clock driver
can use.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 drivers/clk/socfpga/clk-gate.c | 4 ----
 drivers/clk/socfpga/clk.h      | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index dd3a78c..607ab35 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -32,14 +32,10 @@
 #define SOCFPGA_MMC_CLK			"sdmmc_clk"
 #define SOCFPGA_GPIO_DB_CLK_OFFSET	0xA8
 
-#define streq(a, b) (strcmp((a), (b)) == 0)
-
 #define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
 
 /* SDMMC Group for System Manager defines */
 #define SYSMGR_SDMMCGRP_CTRL_OFFSET    0x108
-#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
-	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
 
 static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 {
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d291f60..b09a5d5 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -26,9 +26,13 @@
 #define CLKMGR_L4SRC		0x70
 #define CLKMGR_PERPLL_SRC	0xAC
 
-#define SOCFPGA_MAX_PARENTS		3
+#define SOCFPGA_MAX_PARENTS		5
 #define div_mask(width) ((1 << (width)) - 1)
 
+#define streq(a, b) (strcmp((a), (b)) == 0)
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
 extern void __iomem *clk_mgr_base_addr;
 
 void __init socfpga_pll_init(struct device_node *node);
-- 
2.2.1
