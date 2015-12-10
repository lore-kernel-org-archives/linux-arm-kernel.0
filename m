From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:31 +0100
Subject: [PATCH v4 47/58] staging: mt29f_spinand: use the mtd instance
 embedded in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-48-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device, use it instead of allocating
a new one.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 8924a96..8171b74 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -903,9 +903,7 @@ static int spinand_probe(struct spi_device *spi_nand)
 	chip->options	|= NAND_CACHEPRG;
 	chip->select_chip = spinand_select_chip;
 
-	mtd = devm_kzalloc(&spi_nand->dev, sizeof(struct mtd_info), GFP_KERNEL);
-	if (!mtd)
-		return -ENOMEM;
+	mtd = nand_to_mtd(chip);
 
 	dev_set_drvdata(&spi_nand->dev, mtd);
 
-- 
2.1.4
