From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 11 May 2018 18:00:10 -0500
Subject: [PATCH] edac: altera: Add Stratix10 SDRAM Uncorrectable Errors
Message-ID: <1526079610-5527-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

On Stratix10, uncorrectable errors are routed to the SError
exception instead of the IRQ exceptions. In Stratix10,
uncorrectable SErrors must be treated as fatal and will cause
a panic.
Older Altera/Intel parts printed out a message for UE so do
that here using the notifier framework.

Record the UE in sticky registers that retain the state
through a reset. Check these registers on probe and printout the
error on startup.

Depends on previous patch:
commit 2a4ff60626b0 ("arm64: dts: stratix10: add sdram ecc")

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 67 +++++++++++++++++++++++++++++++++++++++-------
 drivers/edac/altera_edac.h |  8 +++++-
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0ee6d5969ef2..5672f6718262 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -14,6 +14,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -725,6 +726,13 @@ static int altr_s10_sdram_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	if (regmap_write(regmap, S10_SYSMGR_ECC_INTMASK_CLR_OFST,
+			 S10_DDR0_IRQ_MASK)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Error clearing SDRAM ECC count\n");
+		return -ENODEV;
+	}
+
 	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
 			       priv->ecc_irq_en_mask, priv->ecc_irq_en_mask)) {
 		edac_mc_printk(mci, KERN_ERR,
@@ -2228,23 +2236,50 @@ module_platform_driver(altr_edac_a10_driver);
 
 /************** Stratix 10 EDAC Device Controller Functions> ************/
 
+#define to_s10edac(p, m) container_of(p, struct altr_stratix10_edac, m)
+
+/*
+ * The double bit error is handled through SError which is fatal. This is
+ * called as a panic notifier to printout ECC error info as part of the panic.
+ */
+static int s10_edac_dberr_handler(struct notifier_block *this,
+				  unsigned long event, void *ptr)
+{
+	int bit, err_addr, dberror;
+	struct altr_stratix10_edac *edac = to_s10edac(this, panic_notifier);
+
+	s10_protected_reg_read(edac, S10_SYSMGR_ECC_INTSTAT_DERR_OFST,
+			       &dberror);
+	/* Remember the UE Errors for a reboot */
+	s10_protected_reg_write(edac, S10_SYSMGR_UE_VAL_OFST, dberror);
+	if (dberror & S10_DDR0_IRQ_MASK) {
+		s10_protected_reg_read(edac, S10_DERRADDR_OFST, &err_addr);
+		/* Remember the UE Error address */
+		s10_protected_reg_write(edac, S10_SYSMGR_UE_ADDR_OFST,
+					err_addr);
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "EDAC: [Uncorrectable errors @ 0x%08X]\n\n",
+			    err_addr);
+	}
+
+	return NOTIFY_DONE;
+}
+
 static void altr_edac_s10_irq_handler(struct irq_desc *desc)
 {
-	int dberr, bit, sm_offset, irq_status;
+	int bit, sm_offset, irq_status;
 	struct altr_stratix10_edac *edac = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int irq = irq_desc_get_irq(desc);
 
-	dberr = (irq == edac->db_irq) ? 1 : 0;
-	sm_offset = dberr ? S10_SYSMGR_ECC_INTSTAT_DERR_OFST :
-			    S10_SYSMGR_ECC_INTSTAT_SERR_OFST;
+	sm_offset = S10_SYSMGR_ECC_INTSTAT_SERR_OFST;
 
 	chained_irq_enter(chip, desc);
 
 	s10_protected_reg_read(NULL, sm_offset, &irq_status);
 
 	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
-		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
+		irq = irq_linear_revmap(edac->domain, bit);
 		if (irq)
 			generic_handle_irq(irq);
 	}
@@ -2289,6 +2324,7 @@ static int altr_edac_s10_probe(struct platform_device *pdev)
 {
 	struct altr_stratix10_edac *edac;
 	struct device_node *child;
+	int dberror, err_addr;
 
 	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
 	if (!edac)
@@ -2318,11 +2354,22 @@ static int altr_edac_s10_probe(struct platform_device *pdev)
 					 altr_edac_s10_irq_handler,
 					 edac);
 
-	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq >= 0)
-		irq_set_chained_handler_and_data(edac->db_irq,
-						 altr_edac_s10_irq_handler,
-						 edac);
+	edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &edac->panic_notifier);
+
+	/* Printout a message if uncorrectable error previously. */
+	s10_protected_reg_read(edac, S10_SYSMGR_UE_VAL_OFST, &dberror);
+	if (dberror) {
+		s10_protected_reg_read(edac, S10_SYSMGR_UE_ADDR_OFST,
+				       &err_addr);
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Previous Boot UE detected[0x%X] @ 0x%X\n",
+			    dberror, err_addr);
+		/* Reset the sticky registers */
+		s10_protected_reg_write(edac, S10_SYSMGR_UE_VAL_OFST, 0);
+		s10_protected_reg_write(edac, S10_SYSMGR_UE_ADDR_OFST, 0);
+	}
 
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 747481081072..81f0554e09de 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -180,6 +180,10 @@
 /* SDRAM Single Bit Error Count Compare Set Register */
 #define S10_SERRCNTREG_OFST        0xF801113C
 
+/* Sticky registers for Uncorrected Errors */
+#define S10_SYSMGR_UE_VAL_OFST     0xFFD12220
+#define S10_SYSMGR_UE_ADDR_OFST    0xFFD12224
+
 struct altr_sdram_prv_data {
 	int ecc_ctrl_offset;
 	int ecc_ctl_en_mask;
@@ -322,6 +326,8 @@ struct altr_sdram_mc_data {
 #define S10_SYSMGR_ECC_INTSTAT_SERR_OFST  0xFFD1209C
 #define S10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xFFD120A0
 
+#define S10_DDR0_IRQ_MASK                 BIT(16)
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
@@ -434,10 +440,10 @@ struct altr_arria10_edac {
 struct altr_stratix10_edac {
 	struct device		*dev;
 	int sb_irq;
-	int db_irq;
 	struct irq_domain	*domain;
 	struct irq_chip		irq_chip;
 	struct list_head	s10_ecc_devices;
+	struct notifier_block	panic_notifier;
 };
 
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.7.4
