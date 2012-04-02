From: stigge@antcom.de (Roland Stigge)
Date: Mon,  2 Apr 2012 14:56:04 +0200
Subject: [PATCH 7/7] wdt: Device tree support for pnx4008-wdt
In-Reply-To: <1333371364-21347-1-git-send-email-stigge@antcom.de>
References: <1333371364-21347-1-git-send-email-stigge@antcom.de>
Message-ID: <1333371364-21347-8-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds watchdog support to pnx4008-wdt.c

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

 Applies to v3.4-rc1

 Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt |   13 +++++++++++++
 drivers/watchdog/pnx4008_wdt.c                             |   10 ++++++++++
 2 files changed, 23 insertions(+)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
@@ -0,0 +1,13 @@
+* NXP PNX watchdog timer
+
+Required properties:
+- compatible: must be "nxp,pnx4008-wdt"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+Example:
+
+	watchdog at 4003C000 {
+		compatible = "nxp,pnx4008-wdt";
+		reg = <0x4003C000 0x1000>;
+	};
--- linux-2.6.orig/drivers/watchdog/pnx4008_wdt.c
+++ linux-2.6/drivers/watchdog/pnx4008_wdt.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <mach/hardware.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
@@ -201,10 +202,19 @@ static int __devexit pnx4008_wdt_remove(
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pnx4008_wdt_match[] = {
+	{ .compatible = "nxp,pnx4008-wdt" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pnx4008_wdt_match);
+#endif
+
 static struct platform_driver platform_wdt_driver = {
 	.driver = {
 		.name = "pnx4008-watchdog",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(pnx4008_wdt_match),
 	},
 	.probe = pnx4008_wdt_probe,
 	.remove = __devexit_p(pnx4008_wdt_remove),
