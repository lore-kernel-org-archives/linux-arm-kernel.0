From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:02 +0100
Subject: [PATCH v4 12/52] mtd: nand: omap2: use mtd_ooblayout_xxx() helpers
 where appropriate
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/omap2.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 0749ca1..4ebf16b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1495,9 +1495,8 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required, int page)
 {
-	int i;
+	int ret;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	/* Enable GPMC ecc engine */
 	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -1508,8 +1507,10 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	/* Update ecc vector from GPMC result registers */
 	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	/* Write ecc vector to OOB area */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -1536,10 +1537,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-	uint8_t *oob = &chip->oob_poi[eccpos[0]];
-	uint32_t oob_pos = mtd->writesize + chip->ecc.layout->eccpos[0];
-	int stat;
+	int stat, ret;
 	unsigned int max_bitflips = 0;
 
 	/* Enable GPMC ecc engine */
@@ -1549,13 +1547,16 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, buf, mtd->writesize);
 
 	/* Read oob bytes */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
-	chip->read_buf(mtd, oob, chip->ecc.total);
+	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	/* Calculate ecc bytes */
 	chip->ecc.calculate(mtd, buf, ecc_calc);
 
-	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	stat = chip->ecc.correct(mtd, buf, ecc_code, ecc_calc);
 
-- 
2.1.4
