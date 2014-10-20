From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Oct 2014 10:46:17 +0200
Subject: [PATCH v4 4/4] mtd: nand: gpmi: add raw oob access functions
In-Reply-To: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1413794777-32220-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement raw OOB access functions to retrieve OOB bytes when accessing the
NAND in raw mode.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index bd4dedc..d7c483a 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1473,6 +1473,22 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 	return 0;
 }
 
+static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
+				 int page)
+{
+	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
+
+	return gpmi_ecc_read_page_raw(mtd, chip, NULL, 1, page);
+}
+
+static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
+				 int page)
+{
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, 0, page);
+
+	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1);
+}
+
 static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
 	struct nand_chip *chip = mtd->priv;
@@ -1792,6 +1808,8 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	ecc->write_oob	= gpmi_ecc_write_oob;
 	ecc->read_page_raw = gpmi_ecc_read_page_raw;
 	ecc->write_page_raw = gpmi_ecc_write_page_raw;
+	ecc->read_oob_raw = gpmi_ecc_read_oob_raw;
+	ecc->write_oob_raw = gpmi_ecc_write_oob_raw;
 	ecc->mode	= NAND_ECC_HW;
 	ecc->size	= bch_geo->ecc_chunk_size;
 	ecc->strength	= bch_geo->ecc_strength;
-- 
1.9.1
