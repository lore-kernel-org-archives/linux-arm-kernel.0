From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:13 +0100
Subject: [PATCH v2 16/25] mtd: nand: update mtd_to_nand()
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-17-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all drivers are using the mtd instance embedded in the nand_chip
struct we can safely update the mtd_to_nand() implementation to use
the container_of macro instead of returning the content of mtd->priv.
This will allow us to remove mtd->priv = chip assignments done in all
NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 8ec071e..873646d 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -734,7 +734,7 @@ static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
 
 static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
 {
-	return mtd->priv;
+	return container_of(mtd, struct nand_chip, mtd);
 }
 
 static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
-- 
2.1.4
