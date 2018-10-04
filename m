From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 4 Oct 2018 21:05:19 +0530
Subject: [PATCH v8 01/10] edac: synopsys: Update the driver code for better
 readability
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1538667328-9465-2-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the driver with some changes for code clean up. Update the debug
messages for EDAC errors reported. Increase the indentation of the
macros for better readability.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 104 +++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..1936c73 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -26,74 +26,74 @@
 #include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
-#define SYNPS_EDAC_NR_CSROWS	1
+#define SYNPS_EDAC_NR_CSROWS		1
 
 /* Number of channels per memory controller */
-#define SYNPS_EDAC_NR_CHANS	1
+#define SYNPS_EDAC_NR_CHANS		1
 
 /* Granularity of reported error in bytes */
-#define SYNPS_EDAC_ERR_GRAIN	1
+#define SYNPS_EDAC_ERR_GRAIN		1
 
-#define SYNPS_EDAC_MSG_SIZE	256
+#define SYNPS_EDAC_MSG_SIZE		256
 
-#define SYNPS_EDAC_MOD_STRING	"synps_edac"
-#define SYNPS_EDAC_MOD_VER	"1"
+#define SYNPS_EDAC_MOD_STRING		"synps_edac"
+#define SYNPS_EDAC_MOD_VER		"1"
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
-#define CTRL_OFST		0x0
-#define T_ZQ_OFST		0xA4
+#define CTRL_OFST			0x0
+#define T_ZQ_OFST			0xA4
 
 /* ECC control register */
-#define ECC_CTRL_OFST		0xC4
+#define ECC_CTRL_OFST			0xC4
 /* ECC log register */
-#define CE_LOG_OFST		0xC8
+#define CE_LOG_OFST			0xC8
 /* ECC address register */
-#define CE_ADDR_OFST		0xCC
+#define CE_ADDR_OFST			0xCC
 /* ECC data[31:0] register */
-#define CE_DATA_31_0_OFST	0xD0
+#define CE_DATA_31_0_OFST		0xD0
 
 /* Uncorrectable error info registers */
-#define UE_LOG_OFST		0xDC
-#define UE_ADDR_OFST		0xE0
-#define UE_DATA_31_0_OFST	0xE4
+#define UE_LOG_OFST			0xDC
+#define UE_ADDR_OFST			0xE0
+#define UE_DATA_31_0_OFST		0xE4
 
-#define STAT_OFST		0xF0
-#define SCRUB_OFST		0xF4
+#define STAT_OFST			0xF0
+#define SCRUB_OFST			0xF4
 
 /* Control register bit field definitions */
-#define CTRL_BW_MASK		0xC
-#define CTRL_BW_SHIFT		2
+#define CTRL_BW_MASK			0xC
+#define CTRL_BW_SHIFT			2
 
-#define DDRCTL_WDTH_16		1
-#define DDRCTL_WDTH_32		0
+#define DDRCTL_WDTH_16			1
+#define DDRCTL_WDTH_32			0
 
 /* ZQ register bit field definitions */
-#define T_ZQ_DDRMODE_MASK	0x2
+#define T_ZQ_DDRMODE_MASK		0x2
 
 /* ECC control register bit field definitions */
-#define ECC_CTRL_CLR_CE_ERR	0x2
-#define ECC_CTRL_CLR_UE_ERR	0x1
+#define ECC_CTRL_CLR_CE_ERR		0x2
+#define ECC_CTRL_CLR_UE_ERR		0x1
 
 /* ECC correctable/uncorrectable error log register definitions */
-#define LOG_VALID		0x1
-#define CE_LOG_BITPOS_MASK	0xFE
-#define CE_LOG_BITPOS_SHIFT	1
+#define LOG_VALID			0x1
+#define CE_LOG_BITPOS_MASK		0xFE
+#define CE_LOG_BITPOS_SHIFT		1
 
 /* ECC correctable/uncorrectable error address register definitions */
-#define ADDR_COL_MASK		0xFFF
-#define ADDR_ROW_MASK		0xFFFF000
-#define ADDR_ROW_SHIFT		12
-#define ADDR_BANK_MASK		0x70000000
-#define ADDR_BANK_SHIFT		28
+#define ADDR_COL_MASK			0xFFF
+#define ADDR_ROW_MASK			0xFFFF000
+#define ADDR_ROW_SHIFT			12
+#define ADDR_BANK_MASK			0x70000000
+#define ADDR_BANK_SHIFT			28
 
 /* ECC statistic register definitions */
-#define STAT_UECNT_MASK		0xFF
-#define STAT_CECNT_MASK		0xFF00
-#define STAT_CECNT_SHIFT	8
+#define STAT_UECNT_MASK			0xFF
+#define STAT_CECNT_MASK			0xFF00
+#define STAT_CECNT_SHIFT		8
 
 /* ECC scrub register definitions */
-#define SCRUB_MODE_MASK		0x7
-#define SCRUB_MODE_SECDED	0x4
+#define SCRUB_MODE_MASK			0x7
+#define SCRUB_MODE_SECDED		0x4
 
 /**
  * struct ecc_error_info - ECC error log information
@@ -172,7 +172,7 @@ static int synps_edac_geterror_info(void __iomem *base,
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -250,7 +250,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	priv->ue_cnt += priv->stat.ue_cnt;
 	synps_edac_handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count ce %d ue %d\n",
+	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
@@ -295,9 +295,9 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
  */
 static bool synps_edac_get_eccstate(void __iomem *base)
 {
+	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
 	dt = synps_edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
@@ -359,23 +359,23 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
  */
 static int synps_edac_init_csrows(struct mem_ctl_info *mci)
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
+			dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -434,12 +434,12 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
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
-- 
2.1.1
