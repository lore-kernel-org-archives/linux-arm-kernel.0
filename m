From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:20 -0300
Subject: [PATCH v4 16/31] mtd: nand: pxa3xx: Use waitfunc() to wait for the
 device to be ready
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-17-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In pxa3xx_nand_sensing() instead of simply using info->is_ready
after issuing a command, the correct way of checking is to wait
for the device to be ready through the chip's waitfunc().

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 588b23a..6997a25 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1041,10 +1041,11 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 		return ret;
 
 	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
-	if (info->is_ready)
-		return 0;
+	ret = chip->waitfunc(mtd, chip);
+	if (ret & NAND_STATUS_FAIL)
+		return -ENODEV;
 
-	return -ENODEV;
+	return 0;
 }
 
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
-- 
1.8.1.5
