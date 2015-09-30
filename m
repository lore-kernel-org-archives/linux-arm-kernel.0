From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:25 +0200
Subject: [PATCH v2 3/7] mtd: nand: sunxi: make use of
 sunxi_nfc_hw_ecc_read/write_chunk()
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_nfc_hw_ecc_read/write_chunk() functions have been created to
factorize the code in the normal and syndrome ECC implementation.
Make use of them where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 168 ++++++++++--------------------------------
 1 file changed, 40 insertions(+), 128 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 9d8cf06..176d0f0 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -663,61 +663,25 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_ecclayout *layout = ecc->layout;
 	unsigned int max_bitflips = 0;
+	int ret, i, cur_off = 0;
 	int offset;
-	int ret;
-	u32 tmp;
-	int i;
 	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		if (i)
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, i * ecc->size, -1);
-
-		offset = mtd->writesize + layout->eccpos[i * ecc->bytes] - 4;
-
-		chip->read_buf(mtd, NULL, ecc->size);
-
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-
-		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+		int data_off = i * ecc->size;
+		int oob_off = i * (ecc->bytes + 4);
+		u8 *data = buf + data_off;
+		u8 *oob = chip->oob_poi + oob_off;
+
+		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
+						  oob_off + mtd->writesize,
+						  &cur_off, &max_bitflips);
 		if (ret)
 			return ret;
-
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
-
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
-		if (ret)
-			return ret;
-
-		memcpy_fromio(buf + (i * ecc->size),
-			      nfc->regs + NFC_RAM0_BASE, ecc->size);
-
-		if (readl(nfc->regs + NFC_REG_ECC_ST) & NFC_ECC_ERR(0)) {
-			mtd->ecc_stats.failed++;
-		} else {
-			tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0));
-			mtd->ecc_stats.corrected += NFC_ECC_ERR_CNT(0, tmp);
-			max_bitflips = max_t(unsigned int, max_bitflips, tmp);
-		}
-
-		if (oob_required) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-
-			ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-			if (ret)
-				return ret;
-
-			offset -= mtd->writesize;
-			chip->read_buf(mtd, chip->oob_poi + offset,
-				      ecc->bytes + 4);
-		}
 	}
 
 	if (oob_required) {
@@ -740,40 +704,22 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 				       struct nand_chip *chip,
 				       const uint8_t *buf, int oob_required)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_ecclayout *layout = ecc->layout;
+	int ret, i, cur_off = 0;
 	int offset;
-	int ret;
-	u32 tmp;
-	int i;
 	int cnt;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		if (i)
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, i * ecc->size, -1);
-
-		chip->write_buf(mtd, buf + (i * ecc->size), ecc->size);
-
-		offset = layout->eccpos[i * ecc->bytes] - 4 + mtd->writesize;
-
-		/* Fill OOB data in */
-		writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
-					    layout->oobfree[i].offset),
-		       nfc->regs + NFC_REG_USER_DATA(0));
-
-		chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
-
-		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-		if (ret)
-			return ret;
-
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		int data_off = i * ecc->size;
+		int oob_off = i * (ecc->bytes + 4);
+		const u8 *data = buf + data_off;
+		const u8 *oob = chip->oob_poi + oob_off;
+
+		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
+						   oob_off + mtd->writesize,
+						   &cur_off);
 		if (ret)
 			return ret;
 	}
@@ -799,53 +745,31 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 					       uint8_t *buf, int oob_required,
 					       int page)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
-	uint8_t *oob = chip->oob_poi;
-	int offset = 0;
-	int ret;
+	int ret, i, cur_off = 0;
 	int cnt;
-	u32 tmp;
-	int i;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		chip->read_buf(mtd, NULL, ecc->size);
-
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
-
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		int data_off = i * (ecc->size + ecc->bytes + 4);
+		int oob_off = data_off + ecc->size;
+		u8 *data = buf + (i * ecc->size);
+		u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
+
+		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
+						  oob_off, &cur_off,
+						  &max_bitflips);
 		if (ret)
 			return ret;
-
-		memcpy_fromio(buf, nfc->regs + NFC_RAM0_BASE, ecc->size);
-		buf += ecc->size;
-		offset += ecc->size;
-
-		if (readl(nfc->regs + NFC_REG_ECC_ST) & NFC_ECC_ERR(0)) {
-			mtd->ecc_stats.failed++;
-		} else {
-			tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0));
-			mtd->ecc_stats.corrected += NFC_ECC_ERR_CNT(0, tmp);
-			max_bitflips = max_t(unsigned int, max_bitflips, tmp);
-		}
-
-		if (oob_required) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-			chip->read_buf(mtd, oob, ecc->bytes + ecc->prepad);
-			oob += ecc->bytes + ecc->prepad;
-		}
-
-		offset += ecc->bytes + ecc->prepad;
 	}
 
 	if (oob_required) {
-		cnt = mtd->oobsize - (oob - chip->oob_poi);
+		cnt = mtd->writesize + mtd->oobsize - cur_off;
 		if (cnt > 0) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
+			u8 *oob = chip->oob_poi + mtd->oobsize - cnt;
+
 			chip->read_buf(mtd, oob, cnt);
 		}
 	}
@@ -860,41 +784,29 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						const uint8_t *buf,
 						int oob_required)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	uint8_t *oob = chip->oob_poi;
-	int offset = 0;
-	int ret;
+	int ret, i, cur_off = 0;
 	int cnt;
-	u32 tmp;
-	int i;
 
 	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		chip->write_buf(mtd, buf + (i * ecc->size), ecc->size);
-		offset += ecc->size;
-
-		/* Fill OOB data in */
-		writel(NFC_BUF_TO_USER_DATA(oob),
-		       nfc->regs + NFC_REG_USER_DATA(0));
-
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
+		int data_off = i * (ecc->size + ecc->bytes + 4);
+		int oob_off = data_off + ecc->size;
+		const u8 *data = buf + (i * ecc->size);
+		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
 
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
+						   oob, oob_off, &cur_off);
 		if (ret)
 			return ret;
-
-		offset += ecc->bytes + ecc->prepad;
-		oob += ecc->bytes + ecc->prepad;
 	}
 
 	if (oob_required) {
-		cnt = mtd->oobsize - (oob - chip->oob_poi);
+		cnt = mtd->writesize + mtd->oobsize - cur_off;
 		if (cnt > 0) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
+			u8 *oob = chip->oob_poi + mtd->oobsize - cnt;
+
 			chip->write_buf(mtd, oob, cnt);
 		}
 	}
-- 
2.1.4
