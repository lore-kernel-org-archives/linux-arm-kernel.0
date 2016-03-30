From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:20 +0200
Subject: [PATCH v5 05/50] mtd: nand: fsl_ifc: use mtd_ooblayout_xxx() helpers
 where appropriate
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 43f5a3a..2e970ac 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -257,18 +257,22 @@ static int is_blank(struct mtd_info *mtd, unsigned int bufnum)
 	u8 __iomem *addr = priv->vbase + bufnum * (mtd->writesize * 2);
 	u32 __iomem *mainarea = (u32 __iomem *)addr;
 	u8 __iomem *oob = addr + mtd->writesize;
-	int i;
+	struct mtd_oob_region oobregion = { };
+	int i, section = 0;
 
 	for (i = 0; i < mtd->writesize / 4; i++) {
 		if (__raw_readl(&mainarea[i]) != 0xffffffff)
 			return 0;
 	}
 
-	for (i = 0; i < chip->ecc.layout->eccbytes; i++) {
-		int pos = chip->ecc.layout->eccpos[i];
+	mtd_ooblayout_ecc(mtd, section++, &oobregion);
+	while (oobregion.length) {
+		for (i = 0; i < oobregion.length; i++) {
+			if (__raw_readb(&oob[oobregion.offset + i]) != 0xff)
+				return 0;
+		}
 
-		if (__raw_readb(&oob[pos]) != 0xff)
-			return 0;
+		mtd_ooblayout_ecc(mtd, section++, &oobregion);
 	}
 
 	return 1;
-- 
2.5.0
