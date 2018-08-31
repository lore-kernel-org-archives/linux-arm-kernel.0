From: manish.narani@xilinx.com (Manish Narani)
Date: Fri, 31 Aug 2018 18:57:47 +0530
Subject: [PATCH v5 1/4] edac: synps: Add platform specific structures for ddrc
 controller
In-Reply-To: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 78 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..2470d35 100644
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
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,24 +140,47 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @edac_geterror_info:	function pointer to synps edac error info
+ * @edac_get_mtype:	function pointer to synps edac mtype
+ * @edac_get_dtype:	function pointer to synps edac dtype
+ * @edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:		to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*edac_geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*edac_get_dtype)(const void __iomem *base);
+	bool (*edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * @priv:	Pointer to DDR memory controller private instance data
  *
  * Determines there is any ecc error or not
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int synps_edac_geterror_info(struct synps_edac_priv *priv)
 {
+	void __iomem *base;
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
 
+	if (!priv)
+		return 1;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
 	regval = readl(base + STAT_OFST);
 	if (!regval)
 		return 1;
@@ -240,9 +266,10 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 static void synps_edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->edac_geterror_info(priv);
 	if (status)
 		return;
 
@@ -362,6 +389,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	u32 size;
 	int row, j;
 
@@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		size = synps_edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
-			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->mtype	= p_data->edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= p_data->edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -423,6 +451,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.edac_geterror_info	= synps_edac_geterror_info,
+	.edac_get_mtype		= synps_edac_get_mtype,
+	.edac_get_dtype		= synps_edac_get_dtype,
+	.edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks			= 0,
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
@@ -440,13 +483,15 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!(p_data->edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +513,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -511,13 +558,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
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
