From: b32955@freescale.com (Huang Shijie)
Date: Wed, 15 Feb 2012 18:33:28 +0800
Subject: [PATCH] mtd: fix the wrong check condition
Message-ID: <1329302008-10228-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we use `||` check condition, many NAND chips which are not
ONFI nands have to do the ONFI detection.

Use `&&` here to detect the ONFI NAND when we can not find any type
in the nand_flash_ids.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/nand_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 8a393f9..90020a5 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2966,7 +2966,7 @@ static struct nand_flash_dev *nand_get_flash_type(struct mtd_info *mtd,
 			break;
 
 	chip->onfi_version = 0;
-	if (!type->name || !type->pagesize) {
+	if (!type->name && !type->pagesize) {
 		/* Check is chip is ONFI compliant */
 		ret = nand_flash_detect_onfi(mtd, chip, &busw);
 		if (ret)
-- 
1.7.3.2
