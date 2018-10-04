From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 4 Oct 2018 21:05:23 +0530
Subject: [PATCH v8 05/10] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1538667328-9465-6-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 675155f..f0f4704 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,8 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "edac_module.h"
 
@@ -130,6 +132,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller.
  * @message:	Buffer for framing the event specific info.
  * @stat:	ECC status information.
+ * @p_data:	Platform data.
  * @ce_cnt:	Correctable Error count.
  * @ue_cnt:	Uncorrectable Error count.
  */
@@ -137,21 +140,41 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
- * edac_geterror_info - Get the current ECC error info.
- * @base:	Base address of the DDR memory controller.
- * @p:		Synopsys ECC status structure.
+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:	EDAC error info.
+ * @get_mtype:		Get mtype.
+ * @get_dtype:		Get dtype.
+ * @get_eccstate:	Get ECC state.
+ * @quirks:		To differentiate IPs.
+ */
+struct synps_platform_data {
+	int (*geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*get_mtype)(const void __iomem *base);
+	enum dev_type (*get_dtype)(const void __iomem *base);
+	bool (*get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
+ * zynq_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int zynq_geterror_info(struct synps_edac_priv *priv)
 {
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
 
 	regval = readl(base + STAT_OFST);
 	if (!regval)
@@ -230,17 +253,18 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors.
+ * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
  * Used to check and post ECC errors. Called by the polling thread.
  */
-static void edac_check(struct mem_ctl_info *mci)
+static void edac_error_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->geterror_info(priv);
 	if (status)
 		return;
 
@@ -253,7 +277,7 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width.
+ * zynq_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -261,7 +285,7 @@ static void edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type edac_get_dtype(const void __iomem *base)
+static enum dev_type zynq_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -284,20 +308,20 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool edac_get_eccstate(void __iomem *base)
+static bool zynq_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = edac_get_dtype(base);
+	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -323,7 +347,7 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type.
+ * zynq_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -331,7 +355,7 @@ static u32 edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type edac_get_mtype(const void __iomem *base)
+static enum mem_type zynq_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -356,11 +380,14 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
+	p_data = priv->p_data;
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = edac_get_memsize();
@@ -368,10 +395,10 @@ static void edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -406,12 +433,27 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_check;
+	mci->edac_check = edac_error_check;
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.geterror_info	= zynq_geterror_info,
+	.get_mtype	= zynq_get_mtype,
+	.get_dtype	= zynq_get_dtype,
+	.get_eccstate	= zynq_get_eccstate,
+	.quirks		= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
+	const struct synps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
@@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!p_data->get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -457,6 +501,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
@@ -495,13 +541,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1
