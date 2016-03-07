From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:46:53 +0100
Subject: [PATCH v4 03/52] mtd: mtdswap: remove useless if (!mtd->ecclayout)
 test
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the MTD device does not have OOB, the mtd->oobsize and mtd->oobavail
fields are set to zero, and we are testing those values in the following
test.
Remove the useless if (!mtd->ecclayout) test.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdswap.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index d330eb1..cb06bdd 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1417,7 +1417,6 @@ static void mtdswap_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 	unsigned long part;
 	unsigned int eblocks, eavailable, bad_blocks, spare_cnt;
 	uint64_t swap_size, use_size, size_limit;
-	struct nand_ecclayout *oinfo;
 	int ret;
 
 	parts = &partitions[0];
@@ -1447,13 +1446,6 @@ static void mtdswap_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		return;
 	}
 
-	oinfo = mtd->ecclayout;
-	if (!oinfo) {
-		printk(KERN_ERR "%s: mtd%d does not have OOB\n",
-			MTDSWAP_PREFIX, mtd->index);
-		return;
-	}
-
 	if (!mtd->oobsize || mtd->oobavail < MTDSWAP_OOBSIZE) {
 		printk(KERN_ERR "%s: Not enough free bytes in OOB, "
 			"%d available, %zu needed.\n",
-- 
2.1.4
