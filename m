From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Sep 2015 09:46:37 +0200
Subject: [PATCH 2/2] mtd: sunxi: nand: refactor ->read_page()/->write_page()
 code
In-Reply-To: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1442389597-30698-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the logic to read/write pages with the HW ECC engine enabled
is common to the HW_ECC and NAND_ECC_HW_SYNDROME scheme.
Refactor the code to avoid code duplication.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 404 ++++++++++++++++++++++--------------------
 1 file changed, 212 insertions(+), 192 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index dc44435..640b96c 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -159,6 +159,13 @@
 /* NFC_USER_DATA helper macros */
 #define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
 					((buf)[2] << 16) | ((buf)[3] << 24))
+#define NFC_USER_DATA_TO_BUF(buf, val)	\
+	{				\
+		(buf)[0] = val;		\
+		(buf)[1] = val >> 8;	\
+		(buf)[2] = val >> 16;	\
+		(buf)[3] = val >> 24;	\
+	}
 
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
@@ -543,153 +550,228 @@ static void sunxi_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
 	sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
 }
 
-static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
-				      struct nand_chip *chip, uint8_t *buf,
-				      int oob_required, int page)
+static void sunxi_nfc_hw_ecc_enable(struct mtd_info *mtd)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_ecclayout *layout = ecc->layout;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
-	unsigned int max_bitflips = 0;
-	int offset;
-	int ret;
-	u32 tmp;
-	int i;
-	int cnt;
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct sunxi_nand_hw_ecc *data = nand->ecc.priv;
+	u32 ecc_ctl;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
+	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
+		     NFC_ECC_BLOCK_SIZE_MSK);
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
+}
 
-	for (i = 0; i < ecc->steps; i++) {
-		if (i)
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, i * ecc->size, -1);
+static void sunxi_nfc_hw_ecc_disable(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 
-		offset = mtd->writesize + layout->eccpos[i * ecc->bytes] - 4;
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
+	       nfc->regs + NFC_REG_ECC_CTL);
+}
 
-		chip->read_buf(mtd, NULL, ecc->size);
+static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
+				       u8 *data, int data_off,
+				       u8 *oob, int oob_off,
+				       int *cur_off,
+				       unsigned int *max_bitflips)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	u32 status;
+	int ret;
 
-		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
+	if (*cur_off != data_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
 
-		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-		if (ret)
-			return ret;
+	sunxi_nfc_read_buf(mtd, data, ecc->size);
 
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
+	if (data_off + ecc->bytes != oob_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
 
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
-		if (ret)
-			return ret;
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
 
-		memcpy_fromio(buf + (i * ecc->size),
-			      nfc->regs + NFC_RAM0_BASE, ecc->size);
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
 
-		if (readl(nfc->regs + NFC_REG_ECC_ST) & NFC_ECC_ERR(0)) {
-			mtd->ecc_stats.failed++;
-		} else {
-			tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0));
-			mtd->ecc_stats.corrected += NFC_ECC_ERR_CNT(0, tmp);
-			max_bitflips = max_t(unsigned int, max_bitflips, tmp);
-		}
+	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	if (ret)
+		return ret;
 
-		if (oob_required) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
+	status = readl(nfc->regs + NFC_REG_ECC_ST);
+	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0)));
 
-			ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-			if (ret)
-				return ret;
+	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
-			offset -= mtd->writesize;
-			chip->read_buf(mtd, chip->oob_poi + offset,
-				      ecc->bytes + 4);
-		}
+	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+	sunxi_nfc_read_buf(mtd, oob, ecc->bytes + 4);
+
+	if (status & NFC_ECC_ERR(0)) {
+		ret = -EIO;
+	} else {
+		/*
+		 * The engine protects 4 bytes OOB data per chunk.
+		 * Retrieve the corrected OOB bytes.
+		 */
+		NFC_USER_DATA_TO_BUF(oob,
+				     readl(nfc->regs + NFC_REG_USER_DATA(0)));
 	}
 
-	if (oob_required) {
-		cnt = ecc->layout->oobfree[ecc->steps].length;
-		if (cnt > 0) {
-			offset = mtd->writesize +
-				 ecc->layout->oobfree[ecc->steps].offset;
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-			offset -= mtd->writesize;
-			chip->read_buf(mtd, chip->oob_poi + offset, cnt);
-		}
+	if (ret < 0) {
+		mtd->ecc_stats.failed++;
+	} else {
+		mtd->ecc_stats.corrected += ret;
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
+	*cur_off = oob_off + ecc->bytes + 4;
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	return 0;
+}
 
-	return max_bitflips;
+static void sunxi_nfc_hw_ecc_read_extra_oob(struct mtd_info *mtd,
+					    u8 *oob, int *cur_off)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int offset = ((ecc->bytes + 4) * ecc->steps);
+	int len = mtd->oobsize - offset;
+
+	if (len <= 0)
+		return;
+
+	if (*cur_off != offset)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT,
+			      offset + mtd->writesize, -1);
+
+	sunxi_nfc_read_buf(mtd, oob + offset, len);
+
+	*cur_off = mtd->oobsize + mtd->writesize;
 }
 
-static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
-				       struct nand_chip *chip,
-				       const uint8_t *buf, int oob_required)
+static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
+					const u8 *data, int data_off,
+					const u8 *oob, int oob_off,
+					int *cur_off)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_ecclayout *layout = ecc->layout;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
-	int offset;
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int ret;
-	u32 tmp;
-	int i;
-	int cnt;
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	if (data_off != *cur_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_write_buf(mtd, data, ecc->size);
 
-	for (i = 0; i < ecc->steps; i++) {
-		if (i)
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, i * ecc->size, -1);
+	/* Fill OOB data in */
+	writel(NFC_BUF_TO_USER_DATA(oob), nfc->regs + NFC_REG_USER_DATA(0));
 
-		chip->write_buf(mtd, buf + (i * ecc->size), ecc->size);
+	if (data_off + ecc->bytes != oob_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
 
-		offset = layout->eccpos[i * ecc->bytes] - 4 + mtd->writesize;
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
 
-		/* Fill OOB data in */
-		writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
-					    layout->oobfree[i].offset),
-		       nfc->regs + NFC_REG_USER_DATA(0));
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
+	       NFC_ACCESS_DIR | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
 
-		chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
+	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	if (ret)
+		return ret;
 
-		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
-		if (ret)
-			return ret;
+	*cur_off = oob_off + ecc->bytes + 4;
 
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	return 0;
+}
+
+static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
+					     u8 *oob, int *cur_off)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int offset = ((ecc->bytes + 4) * ecc->steps);
+	int len = mtd->oobsize - offset;
+
+	if (len <= 0)
+		return;
+
+	if (*cur_off != offset)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN,
+			      offset + mtd->writesize, -1);
+
+	sunxi_nfc_write_buf(mtd, oob + offset, len);
+
+	*cur_off = mtd->oobsize + mtd->writesize;
+}
+
+static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
+				      struct nand_chip *chip, uint8_t *buf,
+				      int oob_required, int page)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	unsigned int max_bitflips = 0;
+	int ret, i, cur_off = 0;
+
+	sunxi_nfc_hw_ecc_enable(mtd);
+
+	for (i = 0; i < ecc->steps; i++) {
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
 	}
 
-	if (oob_required) {
-		cnt = ecc->layout->oobfree[i].length;
-		if (cnt > 0) {
-			offset = mtd->writesize +
-				 ecc->layout->oobfree[i].offset;
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
-			offset -= mtd->writesize;
-			chip->write_buf(mtd, chip->oob_poi + offset, cnt);
-		}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi,
+						&cur_off);
+
+	sunxi_nfc_hw_ecc_disable(mtd);
+
+	return max_bitflips;
+}
+
+static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
+				       struct nand_chip *chip,
+				       const uint8_t *buf, int oob_required)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int ret, i, cur_off = 0;
+
+	sunxi_nfc_hw_ecc_enable(mtd);
+
+	for (i = 0; i < ecc->steps; i++) {
+		int data_off = i * ecc->size;
+		int oob_off = i * (ecc->bytes + 4);
+		const u8 *data = buf + data_off;
+		const u8 *oob = chip->oob_poi + oob_off;
+
+		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off, oob,
+						   oob_off + mtd->writesize,
+						   &cur_off);
+		if (ret)
+			return ret;
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
+	if (oob_required)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return 0;
 }
@@ -699,64 +781,29 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 					       uint8_t *buf, int oob_required,
 					       int page)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
 	unsigned int max_bitflips = 0;
-	uint8_t *oob = chip->oob_poi;
-	int offset = 0;
-	int ret;
-	int cnt;
-	u32 tmp;
-	int i;
-
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	int ret, i, cur_off = 0;
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
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
 
-	if (oob_required) {
-		cnt = mtd->oobsize - (oob - chip->oob_poi);
-		if (cnt > 0) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
-			chip->read_buf(mtd, oob, cnt);
-		}
-	}
+	if (oob_required)
+		sunxi_nfc_hw_ecc_read_extra_oob(mtd, chip->oob_poi, &cur_off);
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
-	       nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return max_bitflips;
 }
@@ -766,54 +813,27 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 						const uint8_t *buf,
 						int oob_required)
 {
-	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->controller);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct sunxi_nand_hw_ecc *data = ecc->priv;
-	uint8_t *oob = chip->oob_poi;
-	int offset = 0;
-	int ret;
-	int cnt;
-	u32 tmp;
-	int i;
-
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE | NFC_ECC_BLOCK_SIZE_MSK);
-	tmp |= NFC_ECC_EN | NFC_ECC_MODE(data->mode) | NFC_ECC_EXCEPTION;
+	int ret, i, cur_off = 0;
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_enable(mtd);
 
 	for (i = 0; i < ecc->steps; i++) {
-		chip->write_buf(mtd, buf + (i * ecc->size), ecc->size);
-		offset += ecc->size;
+		int data_off = i * (ecc->size + ecc->bytes + 4);
+		int oob_off = data_off + ecc->size;
+		const u8 *data = buf + (i * ecc->size);
+		const u8 *oob = chip->oob_poi + (i * (ecc->bytes + 4));
 
-		/* Fill OOB data in */
-		writel(NFC_BUF_TO_USER_DATA(oob),
-		       nfc->regs + NFC_REG_USER_DATA(0));
-
-		tmp = NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ACCESS_DIR |
-		      NFC_ECC_OP;
-		writel(tmp, nfc->regs + NFC_REG_CMD);
-
-		ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+		ret = sunxi_nfc_hw_ecc_write_chunk(mtd, data, data_off,
+						   oob, oob_off, &cur_off);
 		if (ret)
 			return ret;
-
-		offset += ecc->bytes + ecc->prepad;
-		oob += ecc->bytes + ecc->prepad;
-	}
-
-	if (oob_required) {
-		cnt = mtd->oobsize - (oob - chip->oob_poi);
-		if (cnt > 0) {
-			chip->cmdfunc(mtd, NAND_CMD_RNDIN, offset, -1);
-			chip->write_buf(mtd, oob, cnt);
-		}
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_CTL);
-	tmp &= ~NFC_ECC_EN;
+	if (oob_required)
+		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi, &cur_off);
 
-	writel(tmp, nfc->regs + NFC_REG_ECC_CTL);
+	sunxi_nfc_hw_ecc_disable(mtd);
 
 	return 0;
 }
-- 
1.9.1
