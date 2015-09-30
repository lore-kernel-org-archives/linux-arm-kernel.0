From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:24 +0200
Subject: [PATCH v2 2/7] mtd: nand: sunxi: introduce
 sunxi_nfc_hw_ecc_read/write_chunk()
In-Reply-To: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1443649529-9852-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The logic behind normal and syndrome ECC handling is pretty much the same,
the only difference is the ECC bytes placement.
Create two functions to read/write ECC chunks. Those functions will later
be used by the sunxi_nfc_hw_ecc_read/write_page() and
sunxi_nfc_hw_syndrome_ecc_read/write_page() functions.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Brian,

Introducing those two functions without making use of them is the only
solution I found to make the patch more readable, but this also means
that this commit generates compilation warnings (unused static functions)
which are only fixed by the next commit.

Let me know if you see a more elegant solution.

Best Regards,

Boris
---
 drivers/mtd/nand/sunxi_nand.c | 92 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 471fc2b..9d8cf06 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -567,6 +567,98 @@ static void sunxi_nfc_hw_ecc_disable(struct mtd_info *mtd)
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
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
+
+	if (*cur_off != data_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, data_off, -1);
+
+	sunxi_nfc_read_buf(mtd, data, ecc->size);
+
+	if (data_off + ecc->bytes != oob_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
+
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
+
+	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	if (ret)
+		return ret;
+
+	status = readl(nfc->regs + NFC_REG_ECC_ST);
+	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0)));
+
+	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
+
+	nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+	sunxi_nfc_read_buf(mtd, oob, ecc->bytes + 4);
+
+	if (status & NFC_ECC_ERR(0))
+		ret = -EIO;
+
+	if (ret < 0) {
+		mtd->ecc_stats.failed++;
+	} else {
+		mtd->ecc_stats.corrected += ret;
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+	}
+
+	*cur_off = oob_off + ecc->bytes + 4;
+
+	return 0;
+}
+
+static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
+					const u8 *data, int data_off,
+					const u8 *oob, int oob_off,
+					int *cur_off)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int ret;
+
+	if (data_off != *cur_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN, data_off, -1);
+
+	sunxi_nfc_write_buf(mtd, data, ecc->size);
+
+	/* Fill OOB data in */
+	writel(NFC_BUF_TO_USER_DATA(oob), nfc->regs + NFC_REG_USER_DATA(0));
+
+	if (data_off + ecc->bytes != oob_off)
+		nand->cmdfunc(mtd, NAND_CMD_RNDIN, oob_off, -1);
+
+	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
+	if (ret)
+		return ret;
+
+	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
+	       NFC_ACCESS_DIR | NFC_ECC_OP,
+	       nfc->regs + NFC_REG_CMD);
+
+	ret = sunxi_nfc_wait_int(nfc, NFC_CMD_INT_FLAG, 0);
+	if (ret)
+		return ret;
+
+	*cur_off = oob_off + ecc->bytes + 4;
+
+	return 0;
+}
+
 static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 				      struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
-- 
2.1.4
