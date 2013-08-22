From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:54 -0300
Subject: [PATCH 3/7] watchdog: orion: Make RSTOUT register a separate resource
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377182518-12554-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support other SoC, it's required to distinguish
the 'control' timer register, from the 'rstout' register
that enables system reset on watchdog expiration.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/plat-orion/common.c |  1 +
 drivers/watchdog/orion_wdt.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 4e30ed6..860db39 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -597,6 +597,7 @@ void __init orion_spi_1_init(unsigned long mapbase)
 static struct resource orion_wdt_resource[] = {
 		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
 		DEFINE_RES_MEM(TIMER_PHYS_BASE + WDT_COUNTER_OFF, 0x04),
+		DEFINE_RES_MEM(RSTOUTn_MASK, 0x04),
 };
 
 static struct platform_device orion_wdt_device = {
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 739e79c..b4fd0a9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -47,6 +47,7 @@ static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
 static void __iomem *wdt_val;
+static void __iomem *wdt_rstout;
 static DEFINE_SPINLOCK(wdt_lock);
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
@@ -75,9 +76,9 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(reg, wdt_reg + TIMER_CTRL);
 
 	/* Enable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
+	reg = readl(wdt_rstout);
 	reg |= WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	writel(reg, wdt_rstout);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -90,9 +91,9 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	spin_lock(&wdt_lock);
 
 	/* Disable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
+	reg = readl(wdt_rstout);
 	reg &= ~WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	writel(reg, wdt_rstout);
 
 	/* Disable watchdog timer */
 	reg = readl(wdt_reg + TIMER_CTRL);
@@ -168,6 +169,13 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_val)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!res)
+		return -ENODEV;
+	wdt_rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!wdt_rstout)
+		return -ENOMEM;
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5
