From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:14 +0200
Subject: [PATCH v2 2/8] mxc_nand: fix PM
In-Reply-To: <1274942000-3580-1-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* when resuming, we get the following log :
nand_resume called for a chip which is not in suspended state
* this happens because mtd->suspend and mtd->resume are already
called from the mtd layer, thus they were called a second time
in mxc_nand so mtd complains when trying to resume for the
second time
* the fix is to remove these call and thus remove the supend and
resume functions of mxc_nand

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/mtd/nand/mxc_nand.c |   44 +------------------------------------------
 1 files changed, 1 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 314e2bf..217b247 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -892,53 +892,11 @@ static int __devexit mxcnd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mxcnd_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct nand_chip *nand_chip = mtd->priv;
-	struct mxc_nand_host *host = nand_chip->priv;
-	int ret = 0;
-
-	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND suspend\n");
-
-	ret = mtd->suspend(mtd);
-
-	/*
-	 * nand_suspend locks the device for exclusive access, so
-	 * the clock must already be off.
-	 */
-	BUG_ON(!ret && host->clk_act);
-
-	return ret;
-}
-
-static int mxcnd_resume(struct platform_device *pdev)
-{
-	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct nand_chip *nand_chip = mtd->priv;
-	struct mxc_nand_host *host = nand_chip->priv;
-	int ret = 0;
-
-	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND resume\n");
-
-	mtd->resume(mtd);
-
-	return ret;
-}
-
-#else
-# define mxcnd_suspend   NULL
-# define mxcnd_resume    NULL
-#endif				/* CONFIG_PM */
-
 static struct platform_driver mxcnd_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
-		   },
+	},
 	.remove = __devexit_p(mxcnd_remove),
-	.suspend = mxcnd_suspend,
-	.resume = mxcnd_resume,
 };
 
 static int __init mxc_nd_init(void)
-- 
1.6.3.3
