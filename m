From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:32 +0200
Subject: [PATCH 7/8] mtd: rawnand: orion_nand: Kill orion_nand_data.dev_ready()
In-Reply-To: <20180705102733.29673-1-boris.brezillon@bootlin.com>
References: <20180705102733.29673-1-boris.brezillon@bootlin.com>
Message-ID: <20180705102733.29673-8-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the boards seem to overload the ->dev_ready() hook, just drop
this field from orion_nand_data.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/orion_nand.c            | 3 ---
 include/linux/platform_data/mtd-orion_nand.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index c54d865c1ba1..27cc902545f3 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -153,9 +153,6 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	if (board->width == 16)
 		nc->options |= NAND_BUSWIDTH_16;
 
-	if (board->dev_ready)
-		nc->dev_ready = board->dev_ready;
-
 	platform_set_drvdata(pdev, info);
 
 	/* Not all platforms can gate the clock, so it is not
diff --git a/include/linux/platform_data/mtd-orion_nand.h b/include/linux/platform_data/mtd-orion_nand.h
index a7ce77c7c1a8..34828eb85982 100644
--- a/include/linux/platform_data/mtd-orion_nand.h
+++ b/include/linux/platform_data/mtd-orion_nand.h
@@ -12,7 +12,6 @@
  */
 struct orion_nand_data {
 	struct mtd_partition *parts;
-	int (*dev_ready)(struct mtd_info *mtd);
 	u32 nr_parts;
 	u8 ale;		/* address line number connected to ALE */
 	u8 cle;		/* address line number connected to CLE */
-- 
2.14.1
