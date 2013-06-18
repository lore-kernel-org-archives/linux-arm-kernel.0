From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jun 2013 20:50:32 +0530
Subject: [PATCH V3 08/14] watchdog/mpcore_wdt: disable wdt in suspend only if
 it is busy
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Message-ID: <8bad206e36e575433374b1ae6a18753ea00d6fa3.1371535243.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to call mpcore_wdt_stop() in suspend, if wdt is not BUSY. So, call
mpcore_wdt_stop() conditionally in suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index b4d06f1..75cc518 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -261,7 +261,9 @@ static int mpcore_wdt_remove(struct platform_device *pdev)
 static int mpcore_wdt_suspend(struct device *dev)
 {
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
-	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+
+	if (watchdog_active(&wdt->wdd))
+		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
