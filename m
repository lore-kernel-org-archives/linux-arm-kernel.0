From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:37:03 +0200
Subject: [PATCH 3/5] EDAC, altera: Convert to debugfs wrappers
In-Reply-To: <1442939825-13455-1-git-send-email-bp@alien8.de>
References: <20150922163405.GC3437@pd.tnic>
 <1442939825-13455-1-git-send-email-bp@alien8.de>
Message-ID: <1442939825-13455-3-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Use the EDAC-specific wrappers. Drop CONFIG_EDAC_DEBUG ifdeffery.

Cc: Thor Thayer <tthayer@opensource.altera.com>
Cc: <linux-edac@vger.kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/altera_edac.c | 20 ++++++++------------
 drivers/edac/altera_edac.h |  2 --
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 23ef0917483c..929640981d8a 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -51,11 +51,9 @@ static const struct altr_sdram_prv_data c5_data = {
 	.ecc_irq_clr_mask   = (CV_DRAMINTR_INTRCLR | CV_DRAMINTR_INTREN),
 	.ecc_cnt_rst_offset = CV_DRAMINTR_OFST,
 	.ecc_cnt_rst_mask   = CV_DRAMINTR_INTRCLR,
-#ifdef CONFIG_EDAC_DEBUG
 	.ce_ue_trgr_offset  = CV_CTLCFG_OFST,
 	.ce_set_mask        = CV_CTLCFG_GEN_SB_ERR,
 	.ue_set_mask        = CV_CTLCFG_GEN_DB_ERR,
-#endif
 };
 
 static const struct altr_sdram_prv_data a10_data = {
@@ -72,11 +70,9 @@ static const struct altr_sdram_prv_data a10_data = {
 	.ecc_irq_clr_mask   = (A10_INTSTAT_SBEERR | A10_INTSTAT_DBEERR),
 	.ecc_cnt_rst_offset = A10_ECCCTRL1_OFST,
 	.ecc_cnt_rst_mask   = A10_ECC_CNT_RESET_MASK,
-#ifdef CONFIG_EDAC_DEBUG
 	.ce_ue_trgr_offset  = A10_DIAGINTTEST_OFST,
 	.ce_set_mask        = A10_DIAGINT_TSERRA_MASK,
 	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
-#endif
 };
 
 static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
@@ -116,7 +112,6 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-#ifdef CONFIG_EDAC_DEBUG
 static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 					    const char __user *data,
 					    size_t count, loff_t *ppos)
@@ -191,14 +186,15 @@ static const struct file_operations altr_sdr_mc_debug_inject_fops = {
 
 static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
-	if (mci->debugfs)
-		debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
-				    &altr_sdr_mc_debug_inject_fops);
+	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
+		return;
+
+	if (!mci->debugfs)
+		return;
+
+	edac_debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
+				 &altr_sdr_mc_debug_inject_fops);
 }
-#else
-static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
-{}
-#endif
 
 /* Get total memory size from Open Firmware DTB */
 static unsigned long get_total_mem(void)
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 7b64dc7c4eb7..4ef4fff463e1 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -181,13 +181,11 @@ struct altr_sdram_prv_data {
 	int ecc_irq_clr_mask;
 	int ecc_cnt_rst_offset;
 	int ecc_cnt_rst_mask;
-#ifdef CONFIG_EDAC_DEBUG
 	struct edac_dev_sysfs_attribute *eccmgr_sysfs_attr;
 	int ecc_enable_mask;
 	int ce_set_mask;
 	int ue_set_mask;
 	int ce_ue_trgr_offset;
-#endif
 };
 
 /* Altera SDRAM Memory Controller data */
-- 
2.3.5
