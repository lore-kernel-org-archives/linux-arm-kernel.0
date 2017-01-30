From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Jan 2017 18:18:48 +0100
Subject: [PATCH 2/2] watchdog: sama5d4: Implement resume hook
In-Reply-To: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
References: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170130171848.31598-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When resuming for the deepest state on sama5d2, it is necessary to restore
MR as the registers are lost.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/sama5d4_wdt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 6dd07bef515a..de8ff10a032e 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -258,11 +258,28 @@ static const struct of_device_id sama5d4_wdt_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sama5d4_wdt_of_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int sama5d4_wdt_resume(struct device *dev)
+{
+	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
+
+	wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
+	if (wdt->mr & AT91_WDT_WDDIS)
+		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sama5d4_wdt_pm_ops, NULL,
+			 sama5d4_wdt_resume);
+
 static struct platform_driver sama5d4_wdt_driver = {
 	.probe		= sama5d4_wdt_probe,
 	.remove		= sama5d4_wdt_remove,
 	.driver		= {
 		.name	= "sama5d4_wdt",
+		.pm	= &sama5d4_wdt_pm_ops,
 		.of_match_table = sama5d4_wdt_of_match,
 	}
 };
-- 
2.11.0
