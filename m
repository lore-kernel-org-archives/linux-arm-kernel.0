From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jun 2013 20:50:38 +0530
Subject: [PATCH V3 14/14] watchdog/mpcore_wdt: Add DT probing support for ARM
 mpcore watchdog
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Message-ID: <51fb528c67247ea5ef6c66650f6adf7a2a21bc81.1371535243.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Device tree probing support for ARM Mpcore watchdog. Its binding
were already documented in Documentation/devicetree/bindings/arm/twd.txt.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index d7ee4eb..50f5a0b 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -403,6 +404,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");
 
+#ifdef CONFIG_OF
+static const struct of_device_id mpcore_wdt_id_table[] = {
+	{ .compatible = "arm,cortex-a9-twd-wdt" },
+	{ .compatible = "arm,cortex-a5-twd-wdt" },
+	{ .compatible = "arm,arm11mp-twd-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpcore_wdt_id_table);
+#endif
+
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= mpcore_wdt_remove,
@@ -411,6 +422,7 @@ static struct platform_driver mpcore_wdt_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
 		.pm	= &mpcore_wdt_dev_pm_ops,
+		.of_match_table = of_match_ptr(mpcore_wdt_id_table),
 	},
 };
 
-- 
1.7.12.rc2.18.g61b472e
