From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:25:59 +0100
Subject: [PATCH 04/23] mtd: nand: s3c2410: kill the ->ecc_layout field
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c2410 is allowing board data to overload the default ECC layout
defined inside the driver, but this feature is not used by board
specific definitions.
Kill this field so that we can easily move to a model where ecclayout
are dynamically allocated by the NAND controller driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/plat-samsung/devs.c                   | 9 ---------
 drivers/mtd/nand/s3c2410.c                     | 3 ---
 include/linux/platform_data/mtd-nand-s3c2410.h | 1 -
 3 files changed, 13 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 8207462..a903ee8 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -710,15 +710,6 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 			return -ENOMEM;
 	}
 
-	if (set->ecc_layout) {
-		ptr = kmemdup(set->ecc_layout,
-			      sizeof(struct nand_ecclayout), GFP_KERNEL);
-		set->ecc_layout = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 05105ca..b569200 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -860,9 +860,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->ecc.mode	    = NAND_ECC_SOFT;
 #endif
 
-	if (set->ecc_layout != NULL)
-		chip->ecc.layout = set->ecc_layout;
-
 	if (set->disable_ecc)
 		chip->ecc.mode	= NAND_ECC_NONE;
 
diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
index 36bb921..c55e42ee 100644
--- a/include/linux/platform_data/mtd-nand-s3c2410.h
+++ b/include/linux/platform_data/mtd-nand-s3c2410.h
@@ -40,7 +40,6 @@ struct s3c2410_nand_set {
 	char			*name;
 	int			*nr_map;
 	struct mtd_partition	*partitions;
-	struct nand_ecclayout	*ecc_layout;
 };
 
 struct s3c2410_platform_nand {
-- 
2.1.4
