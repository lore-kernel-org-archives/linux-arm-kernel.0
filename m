From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 12 Mar 2012 09:52:05 +0530
Subject: [PATCH V2 10/22] watchdog/mpcore_wdt: Use dev_(crit, err,
 info) instead of dev_printk
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
Message-ID: <6e02b1c0f3c1540da56b92a06161a800a1089145.1331524811.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 19aaad7..c820e4f 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -71,8 +71,7 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 
 	/* Check it really was our interrupt */
 	if (readl(wdt->base + TWD_WDOG_INTSTAT)) {
-		dev_printk(KERN_CRIT, wdt->dev,
-					"Triggered - Reboot ignored.\n");
+		dev_crit(wdt->dev, "Triggered - Reboot ignored.\n");
 		/* Clear the interrupt on the watchdog */
 		writel(1, wdt->base + TWD_WDOG_INTSTAT);
 		return IRQ_HANDLED;
@@ -123,7 +122,7 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	dev_printk(KERN_INFO, wdt->dev, "enabling watchdog.\n");
+	dev_info(wdt->dev, "enabling watchdog.\n");
 
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_ping(wdd);
@@ -192,7 +191,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
 				"mpcore_wdt", wdt);
 		if (ret) {
-			dev_printk(KERN_ERR, wdt->dev,
+			dev_err(wdt->dev,
 					"cannot register IRQ%d for watchdog\n",
 					wdt->irq);
 			return ret;
-- 
1.7.8.110.g4cb5d
