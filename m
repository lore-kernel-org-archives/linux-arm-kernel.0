From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Sep 2012 14:57:52 +0800
Subject: [PATCH v2 1/9] mtd: add helpers to set/get features for ONFI nand
In-Reply-To: <1347519480-31106-1-git-send-email-b32955@freescale.com>
References: <1347519480-31106-1-git-send-email-b32955@freescale.com>
Message-ID: <1347519480-31106-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the set-features(0xef)/get-features(0xee) helpers for ONFI nand.
Also add the necessary macros.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/nand_base.c |   50 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h     |   14 +++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 88f671c..d06a80d 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2700,6 +2700,50 @@ static int nand_block_markbad(struct mtd_info *mtd, loff_t ofs)
 }
 
 /**
+ * nand_onfi_set_features- [REPLACEABLE] set features for ONFI nand
+ * @mtd: MTD device structure
+ * @chip: nand chip info structure
+ * @addr: feature address.
+ * @subfeature_param: the subfeature parameters, a four bytes array.
+ */
+static int nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
+			int addr, uint8_t *subfeature_param)
+{
+	int status;
+
+	if (!chip->onfi_version)
+		return -EINVAL;
+
+	chip->cmdfunc(mtd, NAND_CMD_SET_FEATURES, addr, -1);
+	chip->write_buf(mtd, subfeature_param, ONFI_SUBFEATURE_PARAM_LEN);
+	status = chip->waitfunc(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+	return 0;
+}
+
+/**
+ * nand_onfi_get_features- [REPLACEABLE] get features for ONFI nand
+ * @mtd: MTD device structure
+ * @chip: nand chip info structure
+ * @addr: feature address.
+ * @subfeature_param: the subfeature parameters, a four bytes array.
+ */
+static int nand_onfi_get_features(struct mtd_info *mtd, struct nand_chip *chip,
+			int addr, uint8_t *subfeature_param)
+{
+	if (!chip->onfi_version)
+		return -EINVAL;
+
+	/* clear the sub feature parameters */
+	memset(subfeature_param, 0, ONFI_SUBFEATURE_PARAM_LEN);
+
+	chip->cmdfunc(mtd, NAND_CMD_GET_FEATURES, addr, -1);
+	chip->read_buf(mtd, subfeature_param, ONFI_SUBFEATURE_PARAM_LEN);
+	return 0;
+}
+
+/**
  * nand_suspend - [MTD Interface] Suspend the NAND flash
  * @mtd: MTD device structure
  */
@@ -3223,6 +3267,12 @@ int nand_scan_tail(struct mtd_info *mtd)
 	if (!chip->write_page)
 		chip->write_page = nand_write_page;
 
+	/* set for ONFI nand */
+	if (!chip->onfi_set_features)
+		chip->onfi_set_features = nand_onfi_set_features;
+	if (!chip->onfi_get_features)
+		chip->onfi_get_features = nand_onfi_get_features;
+
 	/*
 	 * Check ECC mode, default to software if 3byte/512byte hardware ECC is
 	 * selected and we have 256 byte pagesize fallback to software ECC
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 8f99d36..537f59c 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -92,6 +92,8 @@ extern int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 #define NAND_CMD_READID		0x90
 #define NAND_CMD_ERASE2		0xd0
 #define NAND_CMD_PARAM		0xec
+#define NAND_CMD_GET_FEATURES	0xee
+#define NAND_CMD_SET_FEATURES	0xef
 #define NAND_CMD_RESET		0xff
 
 #define NAND_CMD_LOCK		0x2a
@@ -229,6 +231,12 @@ typedef enum {
 /* Keep gcc happy */
 struct nand_chip;
 
+/* ONFI feature address */
+#define ONFI_FEATURE_ADDR_TIMING_MODE	0x1
+
+/* ONFI subfeature parameters length */
+#define ONFI_SUBFEATURE_PARAM_LEN	4
+
 struct nand_onfi_params {
 	/* rev info and features block */
 	/* 'O' 'N' 'F' 'I'  */
@@ -452,6 +460,8 @@ struct nand_buffers {
  *			non 0 if ONFI supported.
  * @onfi_params:	[INTERN] holds the ONFI page parameter when ONFI is
  *			supported, 0 otherwise.
+ * @onfi_set_features	[REPLACEABLE] set the features for ONFI nand
+ * @onfi_get_features	[REPLACEABLE] get the features for ONFI nand
  * @ecclayout:		[REPLACEABLE] the default ECC placement scheme
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
@@ -494,6 +504,10 @@ struct nand_chip {
 	int (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, int oob_required, int page,
 			int cached, int raw);
+	int (*onfi_set_features)(struct mtd_info *mtd, struct nand_chip *chip,
+			int feature_addr, uint8_t *subfeature_para);
+	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
+			int feature_addr, uint8_t *subfeature_para);
 
 	int chip_delay;
 	unsigned int options;
-- 
1.7.0.4
