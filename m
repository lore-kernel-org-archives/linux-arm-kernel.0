From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 20:05:00 -0300
Subject: [PATCH v4 03/18] watchdog: orion: Add clock error handling
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390431915-5115-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a check for clk_prepare_enable success and introduces
an error path to disable the clock properly.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index f7722a4..7f19fa3 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -151,17 +151,24 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
-		return -ENODEV;
+		return PTR_ERR(clk);
 	}
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
 	wdt_tclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto disable_clk;
+	}
+
 	wdt_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_reg)
-		return -ENOMEM;
+	if (!wdt_reg) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
@@ -171,14 +178,16 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
-	if (ret) {
-		clk_disable_unprepare(clk);
-		return ret;
-	}
+	if (ret)
+		goto disable_clk;
 
 	pr_info("Initial timeout %d sec%s\n",
 		orion_wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 
 static int orion_wdt_remove(struct platform_device *pdev)
-- 
1.8.1.5
