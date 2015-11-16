From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Nov 2015 14:37:54 +0100
Subject: [PATCH 21/27] staging: mt29f_spinand: remove useless mtd->priv = chip
 assignment
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1447681080-31232-22-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand_chip() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info mtd;
struct mtd_info *mtdptr;
struct nand_chip *chipptr;
expression d;
@@
(
-(mtd).priv = (chipptr);
|
-(mtdptr)->priv = (chipptr);
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
