From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 23 Jul 2013 20:01:53 +0200
Subject: [PATCH 20/27] drivers/watchdog: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1374602524-3398-21-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 drivers/watchdog/nuc900_wdt.c |    5 -----
 drivers/watchdog/ts72xx_wdt.c |   10 ----------
 2 files changed, 15 deletions(-)

diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index e2b6d2c..b15b6ef 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -256,11 +256,6 @@ static int nuc900wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&nuc900_wdt->wdt_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource specified\n");
-		return -ENOENT;
-	}
-
 	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(nuc900_wdt->wdt_base))
 		return PTR_ERR(nuc900_wdt->wdt_base);
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 4da59b4..42913f1 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -403,21 +403,11 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	}
 
 	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r1) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -ENODEV;
-	}
-
 	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
 	if (IS_ERR(wdt->control_reg))
 		return PTR_ERR(wdt->control_reg);
 
 	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!r2) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -ENODEV;
-	}
-
 	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
 	if (IS_ERR(wdt->feed_reg))
 		return PTR_ERR(wdt->feed_reg);
-- 
1.7.10.4
