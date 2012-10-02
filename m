From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue,  2 Oct 2012 18:01:00 +0200
Subject: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <1349193662-23482-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349193662-23482-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349193662-23482-2-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on an at91sam9260 board (evk-pro3)

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
new file mode 100644
index 0000000..2957ebb
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -0,0 +1,15 @@
+* Atmel Watchdog Timers
+
+** at91sam9-wdt
+
+Required properties:
+- compatible: must be "atmel,at91sam9260-wdt".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+Example:
+
+	watchdog at fffffd40 {
+		compatible = "atmel,at91sam9260-wdt";
+		reg = <0xfffffd40 0x10>;
+	};
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 05e1be8..6dad954 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/timer.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/of.h>
 
 #include "at91sam9_wdt.h"
 
@@ -302,11 +303,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	return res;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id at91_wdt_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9260-wdt" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
+#endif
+
 static struct platform_driver at91wdt_driver = {
 	.remove		= __exit_p(at91wdt_remove),
 	.driver		= {
 		.name	= "at91_wdt",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
 	},
 };
 
-- 
1.7.11.3
