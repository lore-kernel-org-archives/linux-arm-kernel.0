From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 21 Nov 2016 10:03:04 +0100
Subject: [PATCH] mtd: nand: tango: Use nand_to_mtd() instead of directly
 accessing chip->mtd
Message-ID: <1479718984-26491-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand_to_mtd() helper is here to hide internal mtd_info <-> nand_chip
association and ease future refactors.

Make use of this helper instead of directly accessing chip->mtd.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/tango_nand.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 7ed35348993e..ec87516b87f5 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -171,6 +171,7 @@ static void tango_select_chip(struct mtd_info *mtd, int idx)
  */
 static int check_erased_page(struct nand_chip *chip, u8 *buf)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 *meta = chip->oob_poi + BBM_SIZE;
 	u8 *ecc = chip->oob_poi + BBM_SIZE + METADATA_SIZE;
 	const int ecc_size = chip->ecc.bytes;
@@ -183,7 +184,7 @@ static int check_erased_page(struct nand_chip *chip, u8 *buf)
 						  meta, meta_len,
 						  chip->ecc.strength);
 		if (res < 0)
-			chip->mtd.ecc_stats.failed++;
+			mtd->ecc_stats.failed++;
 
 		bitflips = max(res, bitflips);
 		buf += pkt_size;
@@ -300,26 +301,30 @@ static int tango_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 static void aux_read(struct nand_chip *chip, u8 **buf, int len, int *pos)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	*pos += len;
 
 	if (!*buf) {
 		/* skip over "len" bytes */
-		chip->cmdfunc(&chip->mtd, NAND_CMD_RNDOUT, *pos, -1);
+		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, *pos, -1);
 	} else {
-		tango_read_buf(&chip->mtd, *buf, len);
+		tango_read_buf(mtd, *buf, len);
 		*buf += len;
 	}
 }
 
 static void aux_write(struct nand_chip *chip, const u8 **buf, int len, int *pos)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	*pos += len;
 
 	if (!*buf) {
 		/* skip over "len" bytes */
-		chip->cmdfunc(&chip->mtd, NAND_CMD_SEQIN, *pos, -1);
+		chip->cmdfunc(mtd, NAND_CMD_SEQIN, *pos, -1);
 	} else {
-		tango_write_buf(&chip->mtd, *buf, len);
+		tango_write_buf(mtd, *buf, len);
 		*buf += len;
 	}
 }
@@ -345,8 +350,9 @@ static void aux_write(struct nand_chip *chip, const u8 **buf, int len, int *pos)
  */
 static void raw_read(struct nand_chip *chip, u8 *buf, u8 *oob)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 *oob_orig = oob;
-	const int page_size = chip->mtd.writesize;
+	const int page_size = mtd->writesize;
 	const int ecc_size = chip->ecc.bytes;
 	const int pkt_size = chip->ecc.size;
 	int pos = 0; /* position within physical page */
@@ -371,8 +377,9 @@ static void raw_read(struct nand_chip *chip, u8 *buf, u8 *oob)
 
 static void raw_write(struct nand_chip *chip, const u8 *buf, const u8 *oob)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	const u8 *oob_orig = oob;
-	const int page_size = chip->mtd.writesize;
+	const int page_size = mtd->writesize;
 	const int ecc_size = chip->ecc.bytes;
 	const int pkt_size = chip->ecc.size;
 	int pos = 0; /* position within physical page */
@@ -522,7 +529,7 @@ static int chip_init(struct device *dev, struct device_node *np)
 
 	chip = &tchip->nand_chip;
 	ecc = &chip->ecc;
-	mtd = &chip->mtd;
+	mtd = nand_to_mtd(chip);
 
 	chip->read_byte = tango_read_byte;
 	chip->write_buf = tango_write_buf;
@@ -584,7 +591,7 @@ static int tango_nand_remove(struct platform_device *pdev)
 
 	for (cs = 0; cs < MAX_CS; ++cs) {
 		if (nfc->chips[cs])
-			nand_release(&nfc->chips[cs]->nand_chip.mtd);
+			nand_release(nand_to_mtd(&nfc->chips[cs]->nand_chip));
 	}
 
 	return 0;
-- 
2.7.4
