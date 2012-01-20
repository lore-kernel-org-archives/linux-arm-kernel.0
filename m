From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:42:16 +0000
Subject: [PATCH 1/2] MTD: sa11x0: Remove shutdown handler
Message-ID: <E1RoBvE-0005qY-BC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c4a9f88daf ([MTD] [NOR] fix ctrl-alt-del can't reboot for
intel flash bug) interferes with this work-around, causing MTD to
issue this warning:

	Flash device refused suspend due to active operation (state 0)

The commit makes our work-around in the map driver unnecessary, so
let's remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mtd/maps/sa1100-flash.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index 5028219..c735569 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -373,21 +373,9 @@ static int __exit sa1100_mtd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static void sa1100_mtd_shutdown(struct platform_device *dev)
-{
-	struct sa_info *info = platform_get_drvdata(dev);
-	if (info && mtd_suspend(info->mtd) == 0)
-		mtd_resume(info->mtd);
-}
-#else
-#define sa1100_mtd_shutdown NULL
-#endif
-
 static struct platform_driver sa1100_mtd_driver = {
 	.probe		= sa1100_mtd_probe,
 	.remove		= __exit_p(sa1100_mtd_remove),
-	.shutdown	= sa1100_mtd_shutdown,
 	.driver		= {
 		.name	= "sa1100-mtd",
 		.owner	= THIS_MODULE,
-- 
1.7.4.4
