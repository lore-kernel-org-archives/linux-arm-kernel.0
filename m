From: steven.lin1@broadcom.com (Steve Lin)
Date: Wed, 22 Feb 2017 15:42:25 -0500
Subject: [PATCH 1/2] mailbox: bcm-pdc: Add Northstar Plus support to PDC driver
In-Reply-To: <1487796146-14690-1-git-send-email-steven.lin1@broadcom.com>
References: <1487796146-14690-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <1487796146-14690-2-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for Northstar Plus (NS+) products to the PDC mailbox
driver.  The PDC driver was originally written to support the PDC
ring manager in the Northstar2 (64-bit) device.  The NS+ (32 bit
device) uses an almost identical ring manager, though with a
different name.  We just need to check for the type of hardware in
use, in order to write the appropriate interrupt configuration register.
Also updated DMA width to be correct for both NS+ and NS2.

Tested on NS+ and NS2.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
---
 drivers/mailbox/Kconfig           |  9 +++---
 drivers/mailbox/bcm-pdc-mailbox.c | 61 +++++++++++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ceff415..91eafb5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -144,12 +144,11 @@ config XGENE_SLIMPRO_MBOX
 	  want to use the APM X-Gene SLIMpro IPCM support.
 
 config BCM_PDC_MBOX
-	tristate "Broadcom PDC Mailbox"
-	depends on ARM64 || COMPILE_TEST
+	tristate "Broadcom FlexSparx DMA Mailbox"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on HAS_DMA
-	default ARCH_BCM_IPROC
 	help
-	  Mailbox implementation for the Broadcom PDC ring manager,
+	  Mailbox implementation for the Broadcom FlexSparx DMA ring manager,
 	  which provides access to various offload engines on Broadcom
-	  SoCs. Say Y here if you want to use the Broadcom PDC.
+	  SoCs, including FA2/FA+ on Northstar Plus and PDC on Northstar 2.
 endif
diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 2aeb034..4fe7be0 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -18,7 +18,8 @@
  * Broadcom PDC Mailbox Driver
  * The PDC provides a ring based programming interface to one or more hardware
  * offload engines. For example, the PDC driver works with both SPU-M and SPU2
- * cryptographic offload hardware. In some chips the PDC is referred to as MDE.
+ * cryptographic offload hardware. In some chips the PDC is referred to as MDE,
+ * and in others the FA2/FA+ hardware is used with this PDC driver.
  *
  * The PDC driver registers with the Linux mailbox framework as a mailbox
  * controller, once for each PDC instance. Ring 0 for each PDC is registered as
@@ -108,6 +109,7 @@
 #define PDC_INTMASK_OFFSET   0x24
 #define PDC_INTSTATUS_OFFSET 0x20
 #define PDC_RCVLAZY0_OFFSET  (0x30 + 4 * PDC_RINGSET)
+#define FA_RCVLAZY0_OFFSET   0x100
 
 /*
  * For SPU2, configure MDE_CKSUM_CONTROL to write 17 bytes of metadata
@@ -162,6 +164,11 @@
 /* Maximum size buffer the DMA engine can handle */
 #define PDC_DMA_BUF_MAX 16384
 
+enum pdc_hw {
+	FA_HW,		/* FA2/FA+ hardware (i.e. Northstar Plus) */
+	PDC_HW		/* PDC/MDE hardware (i.e. Northstar 2, Pegasus) */
+};
+
 struct pdc_dma_map {
 	void *ctx;          /* opaque context associated with frame */
 };
@@ -211,13 +218,13 @@ struct pdc_regs {
 	u32  gptimer;                /* 0x028 */
 
 	u32  PAD;
-	u32  intrcvlazy_0;           /* 0x030 */
-	u32  intrcvlazy_1;           /* 0x034 */
-	u32  intrcvlazy_2;           /* 0x038 */
-	u32  intrcvlazy_3;           /* 0x03c */
+	u32  intrcvlazy_0;           /* 0x030 (Only in PDC, not FA2) */
+	u32  intrcvlazy_1;           /* 0x034 (Only in PDC, not FA2) */
+	u32  intrcvlazy_2;           /* 0x038 (Only in PDC, not FA2) */
+	u32  intrcvlazy_3;           /* 0x03c (Only in PDC, not FA2) */
 
 	u32  PAD[48];
-	u32  removed_intrecvlazy;    /* 0x100 */
+	u32  fa_intrecvlazy;         /* 0x100 (Only in FA2, not PDC) */
 	u32  flowctlthresh;          /* 0x104 */
 	u32  wrrthresh;              /* 0x108 */
 	u32  gmac_idle_cnt_thresh;   /* 0x10c */
@@ -243,7 +250,7 @@ struct pdc_regs {
 	u32  serdes_status1;         /* 0x1b0 */
 	u32  PAD[11];                /* 0x1b4-1dc */
 	u32  clk_ctl_st;             /* 0x1e0 */
-	u32  hw_war;                 /* 0x1e4 */
+	u32  hw_war;                 /* 0x1e4 (Only in PDC, not FA2) */
 	u32  pwrctl;                 /* 0x1e8 */
 	u32  PAD[5];
 
@@ -410,6 +417,9 @@ struct pdc_state {
 	u32  txnobuf;          /* unable to create tx descriptor */
 	u32  rxnobuf;          /* unable to create rx descriptor */
 	u32  rx_oflow;         /* count of rx overflows */
+
+	/* hardware type - FA2 or PDC/MDE */
+	enum pdc_hw hw_type;
 };
 
 /* Global variables */
@@ -1396,7 +1406,13 @@ static int pdc_interrupts_init(struct pdc_state *pdcs)
 
 	/* interrupt configuration */
 	iowrite32(PDC_INTMASK, pdcs->pdc_reg_vbase + PDC_INTMASK_OFFSET);
-	iowrite32(PDC_LAZY_INT, pdcs->pdc_reg_vbase + PDC_RCVLAZY0_OFFSET);
+
+	if (pdcs->hw_type == FA_HW)
+		iowrite32(PDC_LAZY_INT, pdcs->pdc_reg_vbase +
+			  FA_RCVLAZY0_OFFSET);
+	else
+		iowrite32(PDC_LAZY_INT, pdcs->pdc_reg_vbase +
+			  PDC_RCVLAZY0_OFFSET);
 
 	/* read irq from device tree */
 	pdcs->pdc_irq = irq_of_parse_and_map(dn, 0);
@@ -1465,6 +1481,17 @@ static int pdc_mb_init(struct pdc_state *pdcs)
 	return 0;
 }
 
+/* Device tree API */
+static const int pdc_hw = PDC_HW;
+static const int fa_hw = FA_HW;
+
+static const struct of_device_id pdc_mbox_of_match[] = {
+	{.compatible = "brcm,iproc-pdc-mbox", .data = &pdc_hw},
+	{.compatible = "brcm,iproc-fa2-mbox", .data = &fa_hw},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pdc_mbox_of_match);
+
 /**
  * pdc_dt_read() - Read application-specific data from device tree.
  * @pdev:  Platform device
@@ -1481,6 +1508,8 @@ static int pdc_dt_read(struct platform_device *pdev, struct pdc_state *pdcs)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = pdev->dev.of_node;
+	const struct of_device_id *match;
+	const int *hw_type;
 	int err;
 
 	err = of_property_read_u32(dn, "brcm,rx-status-len",
@@ -1492,6 +1521,14 @@ static int pdc_dt_read(struct platform_device *pdev, struct pdc_state *pdcs)
 
 	pdcs->use_bcm_hdr = of_property_read_bool(dn, "brcm,use-bcm-hdr");
 
+	pdcs->hw_type = PDC_HW;
+
+	match = of_match_device(of_match_ptr(pdc_mbox_of_match), dev);
+	if (match != NULL) {
+		hw_type = match->data;
+		pdcs->hw_type = *hw_type;
+	}
+
 	return 0;
 }
 
@@ -1525,7 +1562,7 @@ static int pdc_probe(struct platform_device *pdev)
 	pdcs->pdc_idx = pdcg.num_spu;
 	pdcg.num_spu++;
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(39));
 	if (err) {
 		dev_warn(dev, "PDC device cannot perform DMA. Error %d.", err);
 		goto cleanup;
@@ -1611,12 +1648,6 @@ static int pdc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id pdc_mbox_of_match[] = {
-	{.compatible = "brcm,iproc-pdc-mbox"},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, pdc_mbox_of_match);
-
 static struct platform_driver pdc_mbox_driver = {
 	.probe = pdc_probe,
 	.remove = pdc_remove,
-- 
2.1.0
