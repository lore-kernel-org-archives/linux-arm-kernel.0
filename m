From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 17 Sep 2018 19:14:28 +0530
Subject: [PATCH v6 1/6] edac: synopsys: Fix code comments and naming convention
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1537191873-6582-2-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the comments in the Synopsys EDAC driver. Minor changes to function
names and return types are also included.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 176 ++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 96 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..4963930 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED	0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,15 +142,13 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_geterror_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise returns zero.
  */
-static int synps_edac_geterror_info(void __iomem *base,
+static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
@@ -172,7 +170,7 @@ static int synps_edac_geterror_info(void __iomem *base,
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -196,13 +194,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_handle_error - Handle controller error types CE and UE.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
+static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -232,38 +230,38 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * edac_check - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. Called by the polling thread.
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
 
-	edac_dbg(3, "Total error count ce %d ue %d\n",
+	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type edac_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +284,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool edac_get_eccstate(void __iomem *base)
 {
+	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
-	dt = synps_edac_get_dtype(base);
+	dt = edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +309,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
-static u32 synps_edac_get_memsize(void)
+static u32 edac_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,15 +323,15 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * edac_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type edac_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,54 +347,47 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * edac_init_csrows - Initialize the cs row data.
+ * @mci:	EDAC memory controller instance.
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
- *
- * Return: Unconditionally 0.
+ * controller instance.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static void edac_init_csrows(struct mem_ctl_info *mci)
 {
+	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	struct synps_edac_priv *priv = mci->pvt_info;
-	u32 size;
-	int row, j;
+	u32 size, row;
+	int j;
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
-			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
-
-	return 0;
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * edac_mc_init - Initialize driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform_device struct.
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
- *
- * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
+static void edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
-	int status;
 	struct synps_edac_priv *priv;
 
 	mci->pdev = &pdev->dev;
@@ -415,17 +406,15 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
-
-	return status;
+	edac_init_csrows(mci);
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_probe - Check controller and bind driver.
+ * @pdev:	platform_device struct.
  *
  * Probes a specific controller instance for binding with the driver.
  *
@@ -434,19 +423,19 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
-	struct resource *res;
+	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
+	struct resource *res;
+	int rc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!edac_get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,12 +457,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed to initialize instance\n");
-		goto free_edac_mc;
-	}
+	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -496,8 +480,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform_device struct.
  *
  * Return: Unconditionally 0
  */
-- 
2.1.1
