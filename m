From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:53 +0100
Subject: [PATCH 45/52] mtd: rawnand: sm_common: make use of the new flash_ids
 table entry
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-46-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new entry in nand_chip to fill a local ID table instead of the
traditional way through nand_scan_ident() as part of the transition to
use nand_scan() in every driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sm_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index c378705c6e2b..71b791634ee4 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -169,8 +169,9 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 	chip->options |= NAND_SKIP_BBTSCAN;
 
 	/* Scan for card properties */
-	ret = nand_scan_ident(mtd, 1, smartmedia ?
-		nand_smartmedia_flash_ids : nand_xd_flash_ids);
+	chip->flash_ids = smartmedia ? nand_smartmedia_flash_ids :
+				       nand_xd_flash_ids;
+	ret = nand_scan_ident(mtd, 1, NULL);
 
 	if (ret)
 		return ret;
-- 
2.14.1
