From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 20 Aug 2012 13:50:55 -0600
Subject: [PATCH] drivers/watchdog: Adding PRCMU based WD for ux500 processors
Message-ID: <1345492255-28900-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

This patch is a partial re-write of the driver developed by
Jonas Aaberg and brings it up to the new watchdog interface
now the standard in the mainline kernel.

Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/watchdog/Kconfig      |   10 +++
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/ux500_wdt.c  |  168 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ux500_wdt.h |   19 +++++
 4 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/ux500_wdt.c
 create mode 100644 include/linux/mfd/ux500_wdt.h

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 53d7571..5e5f2e5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -352,6 +352,16 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
 
+config UX500_WATCHDOG
+	bool "ST-Ericsson Ux500 watchdog"
+	depends on UX500_SOC_DB8500
+	default y
+	help
+	  Say Y here to include Watchdog timer support for the
+	  watchdog existing in the prcmu of ST-Ericsson Ux500 series platforms.
+	  This watchdog is used to reset the system and thus cannot be
+	  compiled as a module.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 572b39b..bec0ef8 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
+obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
new file mode 100644
index 0000000..7b8cfe27
--- /dev/null
+++ b/drivers/watchdog/ux500_wdt.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org> for ST-Ericsson
+ * Author: Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
+ *
+ * Heavily based upon geodewdt.c
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/moduleparam.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/ux500_wdt.h>
+#include <linux/mfd/db8500-prcmu.h>
+#include <mach/id.h>
+
+#define WATCHDOG_TIMEOUT 600 /* 10 minutes */
+#define WATCHDOG_MIN	0
+#define WATCHDOG_MAX	268435 /* 28 bit resolution in ms == 268435.455 s */
+
+static int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in seconds. default="
+				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+static bool wdt_en;
+static bool wdt_auto_off;
+
+static int ux500_wdt_start(struct watchdog_device *wdd)
+{
+	wdt_en = true;
+	return db8500_prcmu_enable_a9wdog(0);
+}
+
+static int ux500_wdt_stop(struct watchdog_device *wdd)
+{
+	return  db8500_prcmu_disable_a9wdog(0);
+}
+
+static int ux500_wdt_keepalive(struct watchdog_device *wdd)
+{
+	return db8500_prcmu_kick_a9wdog(0);
+}
+
+static int ux500_wdt_set_timeout(struct watchdog_device *wdd,
+						unsigned int timeout)
+{
+	ux500_wdt_stop(wdd);
+	db8500_prcmu_load_a9wdog(0, timeout);
+	ux500_wdt_start(wdd);
+
+	return 0;
+}
+
+static const struct watchdog_info ux500_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "Ux500 WDT",
+	.firmware_version = 1,
+};
+
+static struct watchdog_ops ux500_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ux500_wdt_start,
+	.stop  = ux500_wdt_stop,
+	.ping  = ux500_wdt_keepalive,
+	.set_timeout = ux500_wdt_set_timeout,
+
+};
+
+static struct watchdog_device ux500_wdt = {
+	.info = &ux500_wdt_info,
+	.ops = &ux500_wdt_ops,
+	.min_timeout = WATCHDOG_MIN,
+	.max_timeout = WATCHDOG_MAX,
+};
+
+static int __init ux500_wdt_probe(struct platform_device *pdev)
+{
+	int err;
+
+	watchdog_set_nowayout(&ux500_wdt, nowayout);
+
+	/* auto off on sleep */
+	db8500_prcmu_config_a9wdog(1, wdt_auto_off);
+
+	/* set HW initial value */
+	db8500_prcmu_load_a9wdog(0, timeout * 1000);
+
+	err = watchdog_register_device(&ux500_wdt);
+	if (err)
+		return err;
+
+	dev_info(&pdev->dev, "initialized\n");
+
+	return 0;
+}
+
+static int __exit ux500_wdt_remove(struct platform_device *dev)
+{
+	watchdog_unregister_device(&ux500_wdt);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ux500_wdt_suspend(struct platform_device *pdev,
+			     pm_message_t state)
+{
+	if (wdt_en && !wdt_auto_off) {
+		ux500_wdt_stop(&ux500_wdt);
+		db8500_prcmu_config_a9wdog(1, true);
+
+		db8500_prcmu_load_a9wdog(0, timeout * 1000);
+		ux500_wdt_start(&ux500_wdt);
+	}
+	return 0;
+}
+
+static int ux500_wdt_resume(struct platform_device *pdev)
+{
+	if (wdt_en && !wdt_auto_off) {
+		ux500_wdt_stop(&ux500_wdt);
+		db8500_prcmu_config_a9wdog(1, true);
+
+		db8500_prcmu_load_a9wdog(0, timeout * 1000);
+		ux500_wdt_start(&ux500_wdt);
+	}
+	return 0;
+}
+
+#else
+#define ux500_wdt_suspend NULL
+#define ux500_wdt_resume NULL
+#endif
+static struct platform_driver ux500_wdt_driver = {
+	.remove		= __exit_p(ux500_wdt_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ux500_wdt",
+	},
+	.suspend	= ux500_wdt_suspend,
+	.resume		= ux500_wdt_resume,
+};
+
+static int __init ux500_wdt_init(void)
+{
+	return platform_driver_probe(&ux500_wdt_driver, ux500_wdt_probe);
+}
+module_init(ux500_wdt_init);
+
+MODULE_AUTHOR("Jonas Aaberg <jonas.aberg@stericsson.com>");
+MODULE_DESCRIPTION("Ux500 Watchdog Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/include/linux/mfd/ux500_wdt.h b/include/linux/mfd/ux500_wdt.h
new file mode 100644
index 0000000..bfb91f1
--- /dev/null
+++ b/include/linux/mfd/ux500_wdt.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) ST Ericsson SA 2011
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * STE Ux500 PRCMU API
+ */
+#ifndef __UX500_WDT_H
+#define __UX500_WDT_H
+
+/**
+ * struct ux500_wdt_data
+ */
+struct ux500_wdt_data {
+	int timeout;
+	int nowayout;
+};
+
+#endif /* __UX500_WDT_H */
-- 
1.7.5.4
