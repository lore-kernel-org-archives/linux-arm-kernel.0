From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:31 -0300
Subject: [PATCH 07/15] watchdog: orion: Introduce per-compatible of_device_id
 data
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds an orion_watchdog_data structure to holda compatible-data
information. This allows to remove the driver-wide definition and to
future add support for multiple compatible-strings.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 49 ++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 1736d27..ed1df3a 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -25,13 +25,12 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 /*
  * Watchdog timer block registers.
  */
 #define TIMER_CTRL		0x0000
-#define WDT_EN			0x0010
-#define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
@@ -40,12 +39,18 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
+struct orion_watchdog_data {
+	int wdt_counter_offset;
+	int wdt_enable_bit;
+};
+
 struct orion_watchdog {
 	struct watchdog_device wdt;
 	void __iomem *reg;
 	spinlock_t lock;
 	unsigned long clk_rate;
 	struct clk *clk;
+	struct orion_watchdog_data *data;
 };
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
@@ -54,7 +59,8 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	spin_lock(&dev->lock);
 
 	/* Reload watchdog duration */
-	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout,
+	       dev->reg + dev->data->wdt_counter_offset);
 
 	spin_unlock(&dev->lock);
 	return 0;
@@ -68,11 +74,12 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	spin_lock(&dev->lock);
 
 	/* Set watchdog duration */
-	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout,
+	       dev->reg + dev->data->wdt_counter_offset);
 
 	/* Enable watchdog timer */
 	reg = readl(dev->reg + TIMER_CTRL);
-	reg |= WDT_EN;
+	reg |= dev->data->wdt_enable_bit;
 	writel(reg, dev->reg + TIMER_CTRL);
 
 	spin_unlock(&dev->lock);
@@ -88,7 +95,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 
 	/* Disable watchdog timer */
 	reg = readl(dev->reg + TIMER_CTRL);
-	reg &= ~WDT_EN;
+	reg &= ~(dev->data->wdt_enable_bit);
 	writel(reg, dev->reg + TIMER_CTRL);
 
 	spin_unlock(&dev->lock);
@@ -101,7 +108,8 @@ static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 	unsigned int time_left;
 
 	spin_lock(&dev->lock);
-	time_left = readl(dev->reg + WDT_VAL) / dev->clk_rate;
+	time_left = readl(dev->reg + dev->data->wdt_counter_offset);
+	time_left /= dev->clk_rate;
 	spin_unlock(&dev->lock);
 
 	return time_left;
@@ -128,9 +136,24 @@ static const struct watchdog_ops orion_wdt_ops = {
 	.get_timeleft = orion_wdt_get_timeleft,
 };
 
+static const struct orion_watchdog_data orion_data = {
+	.wdt_enable_bit = BIT(4),
+	.wdt_counter_offset = 0x24,
+};
+
+static const struct of_device_id orion_wdt_of_match_table[] = {
+	{
+		.compatible = "marvell,orion-wdt",
+		.data = &orion_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct orion_watchdog *dev;
+	const struct of_device_id *match;
 	unsigned int wdt_max_duration;	/* (seconds) */
 	struct resource *res;
 	int ret;
@@ -140,9 +163,15 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
+	match = of_match_device(orion_wdt_of_match_table, &pdev->dev);
+	if (!match)
+		/* Default legacy match */
+		match = &orion_wdt_of_match_table[0];
+
 	dev->wdt.info = &orion_wdt_info;
 	dev->wdt.ops = &orion_wdt_ops;
 	dev->wdt.min_timeout = 1;
+	dev->data = (struct orion_watchdog_data *)match->data;
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
@@ -197,12 +226,6 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 	orion_wdt_stop(wdt_dev);
 }
 
-static const struct of_device_id orion_wdt_of_match_table[] = {
-	{ .compatible = "marvell,orion-wdt", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
-
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
 	.remove		= orion_wdt_remove,
-- 
1.8.1.5
