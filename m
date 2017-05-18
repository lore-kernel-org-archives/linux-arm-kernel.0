From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 18 May 2017 10:42:37 +0200
Subject: [PATCH v3 2/3] watchdog: dw_wdt: get reset lines from dt
In-Reply-To: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
References: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
Message-ID: <8b116c77d30013b067676fb2f61744840ef51c32.1495096910.git-series.s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_wdt has an external reset line, that can keep the device in reset
and therefore rendering it useless and also is the only way of stopping
the watchdog once it was started.

Get the reset lines for this core from the devicetree. As these lines are
optional, use devm_reset_control_get_optional_shared. If the reset line
is not specified in the devicetree, the reset framework will just skip
deasserting and continue.
This way all users of the driver will continue to function without
any harm, even if the reset line is not specified in the devicetree.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog at vger.kernel.org
---
 drivers/watchdog/dw_wdt.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 914da3a4d334..61cbae3a9331 100644
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
@@ -234,6 +236,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 		goto out_disable_clk;
 	}
 
+	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(dw_wdt->rst))
+		return PTR_ERR(dw_wdt->rst);
+
+	reset_control_deassert(dw_wdt->rst);
+
 	wdd = &dw_wdt->wdd;
 	wdd->info = &dw_wdt_ident;
 	wdd->ops = &dw_wdt_ops;
@@ -278,6 +286,7 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
 	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
 
+	reset_control_assert(dw_wdt->rst);
 	watchdog_unregister_device(&dw_wdt->wdd);
 	clk_disable_unprepare(dw_wdt->clk);
 
-- 
git-series 0.9.1
