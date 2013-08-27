From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:33 -0300
Subject: [PATCH 09/15] watchdog: orion: Add support for Armada 370 and Armada
 XP SoC
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the added infrastructure for handling SoC differences,
this commit adds support for the watchdog controller available
in Armada 370 and Armada XP SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 696f383..91becef 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -36,6 +36,12 @@
 #define WDT_IN_USE		0
 #define WDT_OK_TO_CLOSE		1
 
+#define WDT_A370_RATIO_MASK(v)	((v) << 16)
+#define WDT_A370_RATIO_SHIFT	5
+#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
+
+#define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 
@@ -68,6 +74,44 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int armada370_wdt_clock_init(struct platform_device *pdev,
+				    struct orion_watchdog *dev)
+{
+	u32 reg;
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
+	clk_prepare_enable(dev->clk);
+
+	/* Setup watchdog input clock */
+	reg = readl(dev->reg + TIMER_CTRL);
+	reg |= WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT);
+	writel(reg, dev->reg + TIMER_CTRL);
+
+	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
+	return 0;
+}
+
+static int armadaxp_wdt_clock_init(struct platform_device *pdev,
+				   struct orion_watchdog *dev)
+{
+	u32 reg;
+
+	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
+	clk_prepare_enable(dev->clk);
+
+	/* Enable the fixed watchdog clock input */
+	reg = readl(dev->reg + TIMER_CTRL);
+	reg |= WDT_AXP_FIXED_ENABLE_BIT;
+	writel(reg, dev->reg + TIMER_CTRL);
+
+	dev->clk_rate = clk_get_rate(dev->clk);
+	return 0;
+}
+
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -157,11 +201,31 @@ static const struct orion_watchdog_data orion_data = {
 	.clock_init = orion_wdt_clock_init,
 };
 
+static const struct orion_watchdog_data armada370_data = {
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armada370_wdt_clock_init,
+};
+
+static const struct orion_watchdog_data armadaxp_data = {
+	.wdt_enable_bit = BIT(8),
+	.wdt_counter_offset = 0x34,
+	.clock_init = armadaxp_wdt_clock_init,
+};
+
 static const struct of_device_id orion_wdt_of_match_table[] = {
 	{
 		.compatible = "marvell,orion-wdt",
 		.data = &orion_data,
 	},
+	{
+		.compatible = "marvell,armada-370-wdt",
+		.data = &armada370_data,
+	},
+	{
+		.compatible = "marvell,armada-xp-wdt",
+		.data = &armadaxp_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
-- 
1.8.1.5
