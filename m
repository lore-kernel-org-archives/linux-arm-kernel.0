From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 6 Apr 2016 20:22:54 -0500
Subject: [PATCHv3 6/8] EDAC, altera: Addition of Arria10 OCRAM ECC
Message-ID: <1459992174-8015-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Addition of the Arria10 On-Chip RAM ECC handling. Addition
of private data structure for Arria10 OCRAM ECC.
Addition of a new file operations function and trigger
function for Arria10 OCRAM and other peripheral memories.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v3-2: Remove the Arria10 ECC block init functions.
---
 drivers/edac/altera_edac.c |   78 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |   35 ++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index f7ffc77..11775dc 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -550,6 +550,7 @@ module_platform_driver(altr_edac_driver);
 
 const struct edac_device_prv_data ocramecc_data;
 const struct edac_device_prv_data l2ecc_data;
+const struct edac_device_prv_data a10_ocramecc_data;
 const struct edac_device_prv_data a10_l2ecc_data;
 
 static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
@@ -674,6 +675,16 @@ static const struct file_operations altr_edac_device_inject_fops = {
 	.llseek = generic_file_llseek,
 };
 
+static ssize_t altr_edac_a10_device_trig(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos);
+
+static const struct file_operations altr_edac_a10_device_inject_fops = {
+	.open = simple_open,
+	.write = altr_edac_a10_device_trig,
+	.llseek = generic_file_llseek,
+};
+
 static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 				      const struct edac_device_prv_data *priv)
 {
@@ -701,6 +712,8 @@ static const struct of_device_id altr_edac_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
 	{ .compatible = "altr,socfpga-ocram-ecc",
 	  .data = (void *)&ocramecc_data },
+	{ .compatible = "altr,socfpga-a10-ocram-ecc",
+	  .data = (void *)&a10_ocramecc_data },
 #endif
 	{},
 };
@@ -889,6 +902,24 @@ const struct edac_device_prv_data ocramecc_data = {
 	.inject_fops = &altr_edac_device_inject_fops,
 };
 
+static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
+					 bool sberr);
+
+const struct edac_device_prv_data a10_ocramecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
+	.irq_status_mask = A10_SYSMGR_ECC_INTSTAT_OCRAM,
+	.dbgfs_name = "altr_ocram_trigger",
+	.ecc_enable_mask = ALTR_A10_OCRAM_ECC_EN_CTL,
+	.ecc_en_ofst = ALTR_A10_ECC_CTRL_OFST,
+	.ce_set_mask = ALTR_A10_ECC_TSERRA,
+	.ue_set_mask = ALTR_A10_ECC_TDERRA,
+	.set_err_ofst = ALTR_A10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM */
 
 /********************* L2 Cache EDAC Device Functions ********************/
@@ -1007,6 +1038,50 @@ const struct edac_device_prv_data a10_l2ecc_data = {
  * Based on xgene_edac.c peripheral code.
  */
 
+static ssize_t altr_edac_a10_device_trig(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
+	const struct edac_device_prv_data *priv = drvdata->data;
+	void __iomem *set_addr = (drvdata->base + priv->set_err_ofst);
+	unsigned long flags;
+	u8 trig_type;
+
+	if (!user_buf || get_user(trig_type, user_buf))
+		return -EFAULT;
+
+	local_irq_save(flags);
+	if (trig_type == ALTR_UE_TRIGGER_CHAR)
+		writel(priv->ue_set_mask, set_addr);
+	else
+		writel(priv->ce_set_mask, set_addr);
+	/* Ensure the interrupt test bits are set */
+	wmb();
+	local_irq_restore(flags);
+
+	return count;
+}
+
+static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
+					 bool sberr)
+{
+	void __iomem  *base = dci->base;
+
+	if (sberr) {
+		writel(ALTR_A10_ECC_SERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	} else {
+		writel(ALTR_A10_ECC_DERRPENA,
+		       base + ALTR_A10_ECC_INTSTAT_OFST);
+		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
+	}
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t altr_edac_a10_irq_handler(int irq, void *dev_id)
 {
 	irqreturn_t rc = IRQ_NONE;
@@ -1171,6 +1246,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			continue;
 		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc"))
 			altr_edac_a10_device_add(edac, child);
+		else if (of_device_is_compatible(child,
+						 "altr,socfpga-a10-ocram-ecc"))
+			altr_edac_a10_device_add(edac, child);
 	}
 
 	return 0;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index cb6b2b9..42090f3 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -220,9 +220,41 @@ struct altr_sdram_mc_data {
 #define ALTR_L2_ECC_INJD                BIT(2)
 
 /* Arria10 General ECC Block Module Defines */
+#define ALTR_A10_ECC_CTRL_OFST          0x08
+#define ALTR_A10_ECC_EN                 BIT(0)
+#define ALTR_A10_ECC_INITA              BIT(16)
+#define ALTR_A10_ECC_INITB              BIT(24)
+
+#define ALTR_A10_ECC_INITSTAT_OFST      0x0C
+#define ALTR_A10_ECC_INITCOMPLETEA      BIT(0)
+#define ALTR_A10_ECC_INITCOMPLETEB      BIT(8)
+
+#define ALTR_A10_ECC_ERRINTEN_OFST      0x10
+#define ALTR_A10_ECC_SERRINTEN          BIT(0)
+
+#define ALTR_A10_ECC_INTSTAT_OFST       0x20
+#define ALTR_A10_ECC_SERRPENA           BIT(0)
+#define ALTR_A10_ECC_DERRPENA           BIT(8)
+#define ALTR_A10_ECC_ERRPENA_MASK       (ALTR_A10_ECC_SERRPENA | \
+					 ALTR_A10_ECC_DERRPENA)
+#define ALTR_A10_ECC_SERRPENB           BIT(16)
+#define ALTR_A10_ECC_DERRPENB           BIT(24)
+#define ALTR_A10_ECC_ERRPENB_MASK       (ALTR_A10_ECC_SERRPENB | \
+					 ALTR_A10_ECC_DERRPENB)
+
+#define ALTR_A10_ECC_INTTEST_OFST       0x24
+#define ALTR_A10_ECC_TSERRA             BIT(0)
+#define ALTR_A10_ECC_TDERRA             BIT(8)
+
+/* ECC Manager Defines */
+#define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
+#define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
+#define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
 #define A10_SYSMGR_ECC_INTSTAT_L2         BIT(0)
+#define A10_SYSMGR_ECC_INTSTAT_OCRAM      BIT(1)
 
 #define A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST  0xA8
 #define A10_SYSGMR_MPU_CLEAR_L2_ECC_SB    BIT(15)
@@ -245,6 +277,9 @@ struct altr_sdram_mc_data {
 #define ALTR_A10_L2_ECC_CE_INJ_MASK     0x00000101
 #define ALTR_A10_L2_ECC_UE_INJ_MASK     0x00010101
 
+/* Arria 10 OCRAM ECC Management Group Defines */
+#define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
-- 
1.7.9.5
