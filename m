From: silviupopescu1990@gmail.com (Silviu-Mihai Popescu)
Date: Mon, 11 Mar 2013 09:38:23 +0200
Subject: [PATCH] watchdog: convert to devm_ioremap_resource()
Message-ID: <1362987503-6449-1-git-send-email-silviupopescu1990@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 drivers/watchdog/ath79_wdt.c   |    8 +++-----
 drivers/watchdog/davinci_wdt.c |    8 +++-----
 drivers/watchdog/s3c2410_wdt.c |    9 +++------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 8987990..d184c48 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -253,11 +253,9 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	wdt_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!wdt_base) {
-		dev_err(&pdev->dev, "unable to remap memory region\n");
-		return -ENOMEM;
-	}
+	wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
 
 	wdt_clk = devm_clk_get(&pdev->dev, "wdt");
 	if (IS_ERR(wdt_clk))
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 7df1fdc..005fd71 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -221,11 +221,9 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	wdt_base = devm_request_and_ioremap(dev, wdt_mem);
-	if (!wdt_base) {
-		dev_err(dev, "ioremap failed\n");
-		return -EADDRNOTAVAIL;
-	}
+	wdt_base = devm_ioremap_resource(dev, wdt_mem);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
 
 	ret = misc_register(&davinci_wdt_miscdev);
 	if (ret < 0) {
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index c1a221c..393496c 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -330,12 +330,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	/* get the memory region for the watchdog timer */
-	wdt_base = devm_request_and_ioremap(dev, wdt_mem);
-	if (wdt_base == NULL) {
-		dev_err(dev, "failed to devm_request_and_ioremap() region\n");
-		ret = -ENOMEM;
-		goto err;
-	}
+	wdt_base = devm_ioremap_resource(dev, wdt_mem);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
 
 	DBG("probe: mapped wdt_base=%p\n", wdt_base);
 
-- 
1.7.9.5
