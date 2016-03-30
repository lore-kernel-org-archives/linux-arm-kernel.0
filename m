From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 30 Mar 2016 10:27:42 -0500
Subject: [PATCH 1/7] EDAC, altera: New file operations for Arria10 ECC modules
In-Reply-To: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
References: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1459351668-14622-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for the Arria10 peripheral ECCs, new file
operations are used because the Arria10 IRQ trigger mechanism
is different than Cyclone5/Arria5 and Arria10 L2 cache.

Add new pointer for file operations function to ecc data
structure and point to current file operations function.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |    5 ++++-
 drivers/edac/altera_edac.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0afdc58..fb6fe56 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -668,7 +668,7 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 
 	if (!edac_debugfs_create_file(priv->dbgfs_name, S_IWUSR,
 				      drvdata->debugfs_dir, edac_dci,
-				      &altr_edac_device_inject_fops))
+				      priv->inject_fops))
 		debugfs_remove_recursive(drvdata->debugfs_dir);
 }
 
@@ -886,6 +886,7 @@ const struct edac_device_prv_data ocramecc_data = {
 	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
 	.set_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
+	.inject_fops = &altr_edac_device_inject_fops,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
@@ -975,6 +976,7 @@ const struct edac_device_prv_data l2ecc_data = {
 	.ue_set_mask = (ALTR_L2_ECC_EN | ALTR_L2_ECC_INJD),
 	.set_err_ofst = ALTR_L2_ECC_REG_OFFSET,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.inject_fops = &altr_edac_device_inject_fops,
 };
 
 const struct edac_device_prv_data a10_l2ecc_data = {
@@ -991,6 +993,7 @@ const struct edac_device_prv_data a10_l2ecc_data = {
 	.set_err_ofst = ALTR_A10_L2_ECC_INJ_OFST,
 	.ecc_irq_handler = altr_edac_a10_l2_irq,
 	.trig_alloc_sz = ALTR_TRIG_L2C_BYTE_SIZE,
+	.inject_fops = &altr_edac_device_inject_fops,
 };
 
 #endif	/* CONFIG_EDAC_ALTERA_L2C */
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index b0a17d0..c995388 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -262,6 +262,7 @@ struct edac_device_prv_data {
 	irqreturn_t (*ecc_irq_handler)(struct altr_edac_device_dev *dci,
 				       bool sb);
 	int trig_alloc_sz;
+	const struct file_operations *inject_fops;
 };
 
 struct altr_edac_device_dev {
-- 
1.7.9.5
