From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 4 Oct 2018 21:05:20 +0530
Subject: [PATCH v8 02/10] edac: synopsys: Rename the static functions to a
 shorter name
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the static functions to a shorter name. Since this is Synopsys
EDAC driver, better to remove unnecessary 'synps_' prefix in function
names.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 56 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1936c73..abb5de8 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -142,7 +142,7 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
+ * edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
  *
@@ -150,7 +150,7 @@ struct synps_edac_priv {
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
+static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
@@ -196,13 +196,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
+ * edac_handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
  *
  * Handles the controller ECC correctable and un correctable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
+static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -232,30 +232,30 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
+ * edac_check - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
  * Used to check and post ECC errors. Called by the polling thread
  */
-static void synps_edac_check(struct mem_ctl_info *mci)
+static void edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = edac_geterror_info(priv->baseaddr, &priv->stat);
 	if (status)
 		return;
 
 	priv->ce_cnt += priv->stat.ce_cnt;
 	priv->ue_cnt += priv->stat.ue_cnt;
-	synps_edac_handle_error(mci, &priv->stat);
+	edac_handle_error(mci, &priv->stat);
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
+ * edac_get_dtype - Return the controller memory width
  * @base:	Pointer to the ddr memory controller base address
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -263,7 +263,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type edac_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +286,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
+ * edac_get_eccstate - Return the controller ecc enable/disable status
  * @base:	Pointer to the ddr memory controller base address
  *
  * Get the ECC enable/disable status for the controller
  *
  * Return: a ecc status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool edac_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = synps_edac_get_dtype(base);
+	dt = edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +311,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
  */
-static u32 synps_edac_get_memsize(void)
+static u32 edac_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,7 +325,7 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
+ * edac_get_mtype - Returns controller memory type
  * @base:	pointer to the synopsys ecc status structure
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -333,7 +333,7 @@ static u32 synps_edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type edac_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,7 +349,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
+ * edac_init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
  * Initializes the chip select rows associated with the EDAC memory
@@ -357,7 +357,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
  *
  * Return: Unconditionally 0.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static int edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
@@ -367,15 +367,15 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= edac_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -383,7 +383,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
+ * edac_mc_init - Initialize driver instance
  * @mci:	Pointer to the edac memory controller instance
  * @pdev:	Pointer to the platform_device struct
  *
@@ -393,7 +393,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
  *
  * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
+static int edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
 	int status;
@@ -415,10 +415,10 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
+	status = edac_init_csrows(mci);
 
 	return status;
 }
@@ -446,7 +446,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!edac_get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,7 +468,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
+	rc = edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Failed to initialize instance\n");
-- 
2.1.1
