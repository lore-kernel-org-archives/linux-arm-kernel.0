From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:11:56 +0530
Subject: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
In-Reply-To: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
Message-ID: <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Device tree probing support for ARM Mpcore watchdog. Its binding
were already documented in Documentation/devicetree/bindings/arm/twd.txt.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V1->V2:
- Reuse earlier bindings defined in twd.txt

 drivers/watchdog/mpcore_wdt.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c00455..98df379 100644
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
@@ -402,6 +403,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
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
 	.remove		= __devexit_p(mpcore_wdt_remove),
@@ -410,6 +421,7 @@ static struct platform_driver mpcore_wdt_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
 		.pm	= &mpcore_wdt_dev_pm_ops,
+		.of_match_table = of_match_ptr(mpcore_wdt_id_table),
 	},
 };
 
-- 
1.7.9
