From: stigge@antcom.de (Roland Stigge)
Date: Thu, 18 Oct 2012 18:06:09 +0200
Subject: [PATCH 2/2] rtc-imxdi: Add devicetree support
In-Reply-To: <1350576370-29098-1-git-send-email-stigge@antcom.de>
References: <1350576370-29098-1-git-send-email-stigge@antcom.de>
Message-ID: <1350576370-29098-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support to the rtc-imxdi driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt |   17 +++++++++++++++++
 drivers/rtc/rtc-imxdi.c                             |   11 +++++++++++
 2 files changed, 28 insertions(+)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
@@ -0,0 +1,17 @@
+* i.MX25 Real Time Clock controller
+
+This binding supports the following chips: i.MX25, i.MX53
+
+Required properties:
+- compatible: should be: "fsl,imx25-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: rtc alarm interrupt
+
+Example:
+
+rtc at 80056000 {
+	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
+	reg = <0x80056000 2000>;
+	interrupts = <29>;
+};
--- linux-2.6.orig/drivers/rtc/rtc-imxdi.c
+++ linux-2.6/drivers/rtc/rtc-imxdi.c
@@ -37,6 +37,7 @@
 #include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
+#include <linux/of.h>
 
 /* DryIce Register Definitions */
 
@@ -493,10 +494,20 @@ static int __devexit dryice_rtc_remove(s
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id dryice_dt_ids[] = {
+	{ .compatible = "fsl,imx25-rtc" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, dryice_dt_ids);
+#endif
+
 static struct platform_driver dryice_rtc_driver = {
 	.driver = {
 		   .name = "imxdi_rtc",
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(dryice_dt_ids),
 		   },
 	.remove = __devexit_p(dryice_rtc_remove),
 };
