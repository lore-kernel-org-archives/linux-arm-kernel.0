From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:00 +0100
Subject: [PATCH v4 10/52] mtd: nand: gpmi: use mtd_ooblayout_xxx() helpers
 where appropriate
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 8122c69..3a29b65 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1327,18 +1327,19 @@ static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 static int
 gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
 {
-	struct nand_oobfree *of = mtd->ecclayout->oobfree;
+	struct mtd_oob_region of = { };
 	int status = 0;
 
 	/* Do we have available oob area? */
-	if (!of->length)
+	mtd_ooblayout_free(mtd, 0, &of);
+	if (!of.length)
 		return -EPERM;
 
 	if (!nand_is_slc(chip))
 		return -EPERM;
 
-	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize + of->offset, page);
-	chip->write_buf(mtd, chip->oob_poi + of->offset, of->length);
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize + of.offset, page);
+	chip->write_buf(mtd, chip->oob_poi + of.offset, of.length);
 	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
 
 	status = chip->waitfunc(mtd, chip);
-- 
2.1.4
