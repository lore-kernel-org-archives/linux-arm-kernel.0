From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:24 +0100
Subject: [PATCH 07/16] mtd: nand: sunxi: implement ->read_subpage()
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being able to read subpages can greatly improve read performances if the
MTD user is only interested in a small section of a NAND page.
This is particularly true with large pages (>= 8k).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 8977a5f..df73e55 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -974,6 +974,39 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	return max_bitflips;
 }
 
+static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
+					 struct nand_chip *chip,
+					 u32 data_offs, u32 readlen,
+					 u8 *bufpoi, int page)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int ret, i, cur_off = 0;
+	unsigned int max_bitflips = 0;
+
+	sunxi_nfc_hw_ecc_enable(mtd);
+
+	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+	for (i = data_offs / ecc->size;
+	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
+		int data_off = i * ecc->size;
+		int oob_off = i * (ecc->bytes + 4);
+		u8 *data = bufpoi + data_off;
+		u8 *oob = chip->oob_poi + oob_off;
+
+		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off,
+						  oob,
+						  oob_off + mtd->writesize,
+						  &cur_off, &max_bitflips,
+						  !i, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	sunxi_nfc_hw_ecc_disable(mtd);
+
+	return max_bitflips;
+}
+
 static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 				       struct nand_chip *chip,
 				       const uint8_t *buf, int oob_required,
@@ -1384,6 +1417,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
 	ecc->read_oob_raw = nand_read_oob_std;
 	ecc->write_oob_raw = nand_write_oob_std;
+	ecc->read_subpage = sunxi_nfc_hw_ecc_read_subpage;
 	layout = ecc->layout;
 	nsectors = mtd->writesize / ecc->size;
 
@@ -1630,6 +1664,8 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	if (nand->options & NAND_NEED_SCRAMBLING)
 		nand->options |= NAND_NO_SUBPAGE_WRITE;
 
+	nand->options |= NAND_SUBPAGE_READ;
+
 	ret = sunxi_nand_chip_init_timings(chip, np);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
-- 
2.1.4
