From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:16 +0100
Subject: [PATCH v2 19/25] staging: mt29f_spinand: remove useless mtd->priv =
 chip assignment
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-20-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info m;
struct mtd_info *mp;
struct nand_chip *c;
@@
(
-(m).priv = c;
|
-(mp)->priv = c;
|
-(mp)->priv = (void *)c;
)
---8<----
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 8171b74..b7d429d 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -907,7 +907,6 @@ static int spinand_probe(struct spi_device *spi_nand)
 
 	dev_set_drvdata(&spi_nand->dev, mtd);
 
-	mtd->priv = chip;
 	mtd->dev.parent = &spi_nand->dev;
 	mtd->oobsize = 64;
 
-- 
2.1.4
