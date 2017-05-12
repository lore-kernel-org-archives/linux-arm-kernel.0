From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 12 May 2017 15:34:36 +0200
Subject: [PATCH v2 2/3] watchdog: dw_wdt: get reset lines from dt
In-Reply-To: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
References: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
Message-ID: <4aa9252b45f2334eb429bb195d5d2963b4e61db1.1494595189.git-series.s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_wdt has an external reset line, that can keep the device in reset
and therefore rendering it useless and also is the only way of stopping
the watchdog once it was started.

Get the reset lines for this core from the devicetree.
If resets are not specified just warn but don't fail probing to be compatible
with all users.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog at vger.kernel.org
---
 drivers/watchdog/dw_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 914da3a4d334..3accddf1f381 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
@@ -54,6 +55,7 @@ struct dw_wdt {
 	struct clk		*clk;
 	unsigned long		rate;
 	struct watchdog_device	wdd;
+	struct reset_control	*rst;
 };
 
 #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
@@ -234,6 +236,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 		goto out_disable_clk;
 	}
 
+	dw_wdt->rst = devm_reset_control_get(&pdev->dev, NULL);
+
 	wdd = &dw_wdt->wdd;
 	wdd->info = &dw_wdt_ident;
 	wdd->ops = &dw_wdt_ops;
@@ -267,6 +271,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk;
 
+	if (dw_wdt->rst)
+		reset_control_deassert(dw_wdt->rst);
+
 	return 0;
 
 out_disable_clk:
-- 
git-series 0.9.1
