From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:34 +0200
Subject: [PATCH 6/6] watchdog: sama5d4: try to set timeout from device tree
 first
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-7-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

watchdog_init_timeout function doesn't try to get the "timeout-sec" DT
property if timeout_parm is not zero. This change makes this DT property
working for the sama5d4 watchdog driver.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/sama5d4_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index a49634c..2e2049b 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -222,7 +222,10 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
+	/* Try to set timeout from device tree first */
+	ret = watchdog_init_timeout(wdd, 0, &pdev->dev);
+	if (ret)
+		ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to set timeout value\n");
 		return ret;
@@ -243,7 +246,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 
 	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
-		 wdt_timeout, nowayout);
+		 wdd->timeout, nowayout);
 
 	return 0;
 }
-- 
2.5.1
