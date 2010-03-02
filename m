From: chripell@fsfe.org (Christian Pellegrin)
Date: Tue,  2 Mar 2010 18:27:56 +0100
Subject: [PATCH v2.6.33] fix CONFIG_MTD_NAND_S3C2410_CLKSTOP
Message-ID: <1267550876-2348-1-git-send-email-chripell@fsfe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Option CONFIG_MTD_NAND_S3C2410_CLKSTOP was broken by higher MTD layers
calling select_chip with -1 twice in a row. This patch fixes the problem
by making sure that clk_disable is not called too many times.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 drivers/mtd/nand/s3c2410.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index fa6e9c7..9adecc6 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/bitops.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -135,6 +136,9 @@ struct s3c2410_nand_info {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
+#ifdef CONFIG_MTD_NAND_S3C2410_CLKSTOP
+	unsigned long                   clk_running;
+#endif
 };
 
 /* conversion functions */
@@ -333,7 +337,8 @@ static void s3c2410_nand_select_chip(struct mtd_info *mtd, int chip)
 	nmtd = this->priv;
 	info = nmtd->info;
 
-	if (chip != -1 && allow_clk_stop(info))
+	if (chip != -1 && allow_clk_stop(info) &&
+	    !test_and_set_bit(0, &info->clk_running))
 		clk_enable(info->clk);
 
 	cur = readl(info->sel_reg);
@@ -356,7 +361,8 @@ static void s3c2410_nand_select_chip(struct mtd_info *mtd, int chip)
 
 	writel(cur, info->sel_reg);
 
-	if (chip == -1 && allow_clk_stop(info))
+	if (chip == -1 && allow_clk_stop(info) &&
+	    test_and_clear_bit(0, &info->clk_running))
 		clk_disable(info->clk);
 }
 
-- 
1.5.6.5
