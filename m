From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:05 +0100
Subject: [PATCH v2 08/25] staging: mt29f_spinand: make use of mtd_to_nand()
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() was recently introduced to avoid direct accesses to the
mtd->priv field. Use it where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 6536066..8924a96 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -31,7 +31,7 @@
 
 static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
 {
-	struct nand_chip *chip = (struct nand_chip *)mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct spinand_info *info = (struct spinand_info *)chip->priv;
 	struct spinand_state *state = (struct spinand_state *)info->priv;
 
@@ -744,7 +744,7 @@ static void spinand_reset(struct spi_device *spi_nand)
 static void spinand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			    int column, int page)
 {
-	struct nand_chip *chip = (struct nand_chip *)mtd->priv;
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct spinand_info *info = (struct spinand_info *)chip->priv;
 	struct spinand_state *state = (struct spinand_state *)info->priv;
 
-- 
2.1.4
