From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 19 Jul 2018 15:35:44 +0530
Subject: [PATCH 1/4] edac: synps: Add platform specific structures for ddrc
 controller
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1531994747-15196-2-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds platform specific structures, so that we can add
different IP support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 70 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..447396e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include "edac_module.h"
 
@@ -95,6 +96,9 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+
 /**
  * struct ecc_error_info - ECC error log information
  * @row:	Row number
@@ -130,6 +134,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,11 +142,29 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @synps_edac_geterror_info:	function pointer to synps edac error info
+ * @synps_edac_get_mtype:	function pointer to synps edac mtype
+ * @synps_edac_get_dtype:	function pointer to synps edac dtype
+ * @synps_edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:			to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*synps_edac_geterror_info)(void __iomem *base,
+					struct synps_ecc_status *p);
+	enum mem_type (*synps_edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*synps_edac_get_dtype)(const void __iomem *base);
+	bool (*synps_edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
@@ -242,7 +265,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+							&priv->stat);
 	if (status)
 		return;
 
@@ -372,10 +396,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm            = csi->channels[j]->dimm;
 			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
+						priv->baseaddr);
 			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
+						priv->baseaddr);
 		}
 	}
 
@@ -423,6 +449,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.synps_edac_geterror_info	= synps_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks				= 0,
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
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -440,13 +481,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct of_device_id *match;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	match = of_match_node(synps_edac_match, pdev->dev.of_node);
+	if (!match && !match->data) {
+		dev_err(&pdev->dev, "of_match_node() failed\n");
+		return -EINVAL;
+	}
+
+	p_data = (struct synps_platform_data *)match->data;
+	if (!(p_data->synps_edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +518,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = match->data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -486,7 +538,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -511,13 +564,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
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
