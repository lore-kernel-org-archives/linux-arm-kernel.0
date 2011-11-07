From: zonque@gmail.com (Daniel Mack)
Date: Mon,  7 Nov 2011 16:43:28 +0100
Subject: [PATCH 1/4] mtd: pxa3xx_nand: fix a memory leak
In-Reply-To: <1320680611-29448-1-git-send-email-zonque@gmail.com>
References: <1320680611-29448-1-git-send-email-zonque@gmail.com>
Message-ID: <1320680611-29448-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@gmail.com>

In pxa3xx_nand_remove, we should call nand_release instead of
mtd_device_unregister to properly free bad block table memory
and bad block descriptor memory.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 1fb3b3a..f7040ea 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1119,7 +1119,7 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_put(info->clk);
 
 	if (mtd) {
-		mtd_device_unregister(mtd);
+		nand_release(mtd);
 		kfree(mtd);
 	}
 	return 0;
-- 
1.7.6.4
