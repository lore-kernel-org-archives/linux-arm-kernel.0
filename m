From: b32955@freescale.com (Huang Shijie)
Date: Fri, 17 Feb 2012 11:22:37 +0800
Subject: [PATCH] mtd :  change the location of the ONFI detected log
Message-ID: <1329448957-9756-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some strange nand chip(such as Hynix H27UBG8T2A) can pass the `ONFI` signature
check. So the log can be printed out even it is not an ONFI nand indeed.

Change this log to the end of the function. Print out the log only when we
really detect an ONFI nand.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/nand_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 5822e3a..1e907dc 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2853,7 +2853,6 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->read_byte(mtd) != 'F' || chip->read_byte(mtd) != 'I')
 		return 0;
 
-	pr_info("ONFI flash detected\n");
 	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
 	for (i = 0; i < 3; i++) {
 		chip->read_buf(mtd, (uint8_t *)p, sizeof(*p));
@@ -2903,6 +2902,7 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->options |= (NAND_NO_READRDY |
 			NAND_NO_AUTOINCR) & NAND_CHIPOPTIONS_MSK;
 
+	pr_info("ONFI flash detected\n");
 	return 1;
 }
 
-- 
1.7.0.4
