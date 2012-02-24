From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 24 Feb 2012 15:12:37 +0530
Subject: [PATCH] watchdog/sp805: add pm callbacks to support
 standby/S2R/hibernation
Message-ID: <a4e84464d736569c1ea3b06e39c473edc7a8107a.1330076518.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index eef1524..e2d5249 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -351,6 +352,37 @@ static int __devexit sp805_wdt_remove(struct amba_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int sp805_wdt_suspend(struct device *dev)
+{
+	if (test_bit(WDT_BUSY, &wdt->status)) {
+		wdt_disable();
+		clk_disable(wdt->clk);
+	}
+
+	return 0;
+}
+
+static int sp805_wdt_resume(struct device *dev)
+{
+	int ret = 0;
+
+	if (test_bit(WDT_BUSY, &wdt->status)) {
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(dev, "clock enable fail");
+			return ret;
+		}
+		wdt_enable();
+	}
+
+	return ret;
+}
+#endif /* CONFIG_PM */
+
+static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
+		sp805_wdt_resume);
+
 static struct amba_id sp805_wdt_ids[] = {
 	{
 		.id	= 0x00141805,
@@ -364,6 +396,7 @@ MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
 static struct amba_driver sp805_wdt_driver = {
 	.drv = {
 		.name	= MODULE_NAME,
+		.pm	= &sp805_wdt_dev_pm_ops,
 	},
 	.id_table	= sp805_wdt_ids,
 	.probe		= sp805_wdt_probe,
-- 
1.7.8.110.g4cb5d
