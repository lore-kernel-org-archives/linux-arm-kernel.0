From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:09 +0100
Subject: [PATCH 14/23] mtd: use mtd_set_ecclayout() where appropriate
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the mtd_set_ecclayout() helper instead of directly assigning the
mtd->ecclayout field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/docg3.c        | 2 +-
 drivers/mtd/mtdconcat.c            | 2 +-
 drivers/mtd/mtdpart.c              | 2 +-
 drivers/mtd/nand/nand_base.c       | 2 +-
 drivers/mtd/onenand/onenand_base.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index e7b2e43..6b516e1 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1857,7 +1857,7 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 	mtd->_read_oob = doc_read_oob;
 	mtd->_write_oob = doc_write_oob;
 	mtd->_block_isbad = doc_block_isbad;
-	mtd->ecclayout = &docg3_oobinfo;
+	mtd_set_ecclayout(mtd, &docg3_oobinfo);
 	mtd->oobavail = 8;
 	mtd->ecc_strength = DOC_ECC_BCH_T;
 
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 239a8c8..481565e 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -777,7 +777,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 	}
 
-	concat->mtd.ecclayout = subdev[0]->ecclayout;
+	mtd_set_ecclayout(&concat->mtd, subdev[0]->ecclayout);
 
 	concat->num_subdev = num_devs;
 	concat->mtd.name = name;
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index c32b127..244faa8 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -536,7 +536,7 @@ static struct mtd_part *allocate_partition(struct mtd_info *master,
 			part->name);
 	}
 
-	slave->mtd.ecclayout = master->ecclayout;
+	mtd_set_ecclayout(&slave->mtd, master->ecclayout);
 	slave->mtd.ecc_step_size = master->ecc_step_size;
 	slave->mtd.ecc_strength = master->ecc_strength;
 	slave->mtd.bitflip_threshold = master->bitflip_threshold;
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 30a0721..2b334cf 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4365,7 +4365,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 	mtd->writebufsize = mtd->writesize;
 
 	/* propagate ecc info to mtd_info */
-	mtd->ecclayout = ecc->layout;
+	mtd_set_ecclayout(mtd, ecc->layout);
 	mtd->ecc_strength = ecc->strength;
 	mtd->ecc_step_size = ecc->size;
 	/*
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 25e6bf2..b5937b7 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -4059,7 +4059,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	     mtd_oobfree(mtd, i++, &oobfree))
 		mtd->oobavail += oobfree.length;
 
-	mtd->ecclayout = this->ecclayout;
+	mtd_set_ecclayout(mtd, this->ecclayout);
 	mtd->ecc_strength = 1;
 
 	/* Fill in remaining MTD driver data */
-- 
2.1.4
