From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:22 +0200
Subject: [PATCH v5 07/50] mtd: nand: lpc32xx: use mtd_ooblayout_xxx() helpers
 where appropriate
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/lpc32xx_slc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 3b8f373..10cf8e62 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -604,7 +604,8 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 					   int oob_required, int page)
 {
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
-	int stat, i, status;
+	struct mtd_oob_region oobregion = { };
+	int stat, i, status, error;
 	uint8_t *oobecc, tmpecc[LPC32XX_ECC_SAVE_SIZE];
 
 	/* Issue read command */
@@ -620,7 +621,11 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 	lpc32xx_slc_ecc_copy(tmpecc, (uint32_t *) host->ecc_buf, chip->ecc.steps);
 
 	/* Pointer to ECC data retrieved from NAND spare area */
-	oobecc = chip->oob_poi + chip->ecc.layout->eccpos[0];
+	error = mtd_ooblayout_ecc(mtd, 0, &oobregion);
+	if (error)
+		return error;
+
+	oobecc = chip->oob_poi + oobregion.offset;
 
 	for (i = 0; i < chip->ecc.steps; i++) {
 		stat = chip->ecc.correct(mtd, buf, oobecc,
@@ -666,7 +671,8 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 					    int oob_required, int page)
 {
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
-	uint8_t *pb = chip->oob_poi + chip->ecc.layout->eccpos[0];
+	struct mtd_oob_region oobregion = { };
+	uint8_t *pb;
 	int error;
 
 	/* Write data, calculate ECC on outbound data */
@@ -678,6 +684,11 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 	 * The calculated ECC needs some manual work done to it before
 	 * committing it to NAND. Process the calculated ECC and place
 	 * the resultant values directly into the OOB buffer. */
+	error = mtd_ooblayout_ecc(mtd, 0, &oobregion);
+	if (error)
+		return error;
+
+	pb = chip->oob_poi + oobregion.offset;
 	lpc32xx_slc_ecc_copy(pb, (uint32_t *)host->ecc_buf, chip->ecc.steps);
 
 	/* Write ECC data to device */
-- 
2.5.0
