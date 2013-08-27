From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:30 -0300
Subject: [PATCH 06/15] watchdog: orion: Introduce an orion_watchdog device
 structure
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prepare to support multiple compatible-strings, this
commit adds a device structure to hold the driver's state.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 106 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 3f8e7ad..1736d27 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -39,63 +39,70 @@
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
-static unsigned int wdt_max_duration;	/* (seconds) */
-static struct clk *clk;
-static unsigned int wdt_tclk;
-static void __iomem *wdt_reg;
-static DEFINE_SPINLOCK(wdt_lock);
+
+struct orion_watchdog {
+	struct watchdog_device wdt;
+	void __iomem *reg;
+	spinlock_t lock;
+	unsigned long clk_rate;
+	struct clk *clk;
+};
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
-	spin_lock(&wdt_lock);
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	spin_lock(&dev->lock);
 
 	/* Reload watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
 
-	spin_unlock(&wdt_lock);
+	spin_unlock(&dev->lock);
 	return 0;
 }
 
 static int orion_wdt_start(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 	u32 reg;
 
-	spin_lock(&wdt_lock);
+	spin_lock(&dev->lock);
 
 	/* Set watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
 
 	/* Enable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
+	reg = readl(dev->reg + TIMER_CTRL);
 	reg |= WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	writel(reg, dev->reg + TIMER_CTRL);
 
-	spin_unlock(&wdt_lock);
+	spin_unlock(&dev->lock);
 	return 0;
 }
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 	u32 reg;
 
-	spin_lock(&wdt_lock);
+	spin_lock(&dev->lock);
 
 	/* Disable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
+	reg = readl(dev->reg + TIMER_CTRL);
 	reg &= ~WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	writel(reg, dev->reg + TIMER_CTRL);
 
-	spin_unlock(&wdt_lock);
+	spin_unlock(&dev->lock);
 	return 0;
 }
 
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 	unsigned int time_left;
 
-	spin_lock(&wdt_lock);
-	time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
-	spin_unlock(&wdt_lock);
+	spin_lock(&dev->lock);
+	time_left = readl(dev->reg + WDT_VAL) / dev->clk_rate;
+	spin_unlock(&dev->lock);
 
 	return time_left;
 }
@@ -121,60 +128,73 @@ static const struct watchdog_ops orion_wdt_ops = {
 	.get_timeleft = orion_wdt_get_timeleft,
 };
 
-static struct watchdog_device orion_wdt = {
-	.info = &orion_wdt_info,
-	.ops = &orion_wdt_ops,
-	.min_timeout = 1,
-};
-
 static int orion_wdt_probe(struct platform_device *pdev)
 {
+	struct orion_watchdog *dev;
+	unsigned int wdt_max_duration;	/* (seconds) */
 	struct resource *res;
 	int ret;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct orion_watchdog),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->wdt.info = &orion_wdt_info;
+	dev->wdt.ops = &orion_wdt_ops;
+	dev->wdt.min_timeout = 1;
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
 		return -ENODEV;
 	}
-	clk_prepare_enable(clk);
-	wdt_tclk = clk_get_rate(clk);
+	clk_prepare_enable(dev->clk);
+	dev->clk_rate = clk_get_rate(dev->clk);
+	spin_lock_init(&dev->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
-	wdt_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_reg)
+	dev->reg = devm_ioremap(&pdev->dev, res->start,
+			       resource_size(res));
+	if (!dev->reg)
 		return -ENOMEM;
 
-	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
+	wdt_max_duration = WDT_MAX_CYCLE_COUNT / dev->clk_rate;
 
-	orion_wdt.timeout = wdt_max_duration;
-	orion_wdt.max_timeout = wdt_max_duration;
-	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
+	dev->wdt.timeout = wdt_max_duration;
+	dev->wdt.max_timeout = wdt_max_duration;
+	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
-	watchdog_set_nowayout(&orion_wdt, nowayout);
-	ret = watchdog_register_device(&orion_wdt);
+	platform_set_drvdata(pdev, &dev->wdt);
+	watchdog_set_drvdata(&dev->wdt, dev);
+	watchdog_set_nowayout(&dev->wdt, nowayout);
+	ret = watchdog_register_device(&dev->wdt);
 	if (ret) {
-		clk_disable_unprepare(clk);
+		clk_disable_unprepare(dev->clk);
 		return ret;
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		orion_wdt.timeout, nowayout ? ", nowayout" : "");
+		dev->wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
 static int orion_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&orion_wdt);
-	clk_disable_unprepare(clk);
+	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	watchdog_unregister_device(wdt_dev);
+	clk_disable_unprepare(dev->clk);
 	return 0;
 }
 
 static void orion_wdt_shutdown(struct platform_device *pdev)
 {
-	orion_wdt_stop(&orion_wdt);
+	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
+	orion_wdt_stop(wdt_dev);
 }
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.8.1.5
