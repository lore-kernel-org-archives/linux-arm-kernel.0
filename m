From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 14 Nov 2012 14:52:53 -0800
Subject: [PATCH resend] rtc: i.MX dryice: Add devicetree support
In-Reply-To: <1352709770-5919-1-git-send-email-s.hauer@pengutronix.de>
References: <1352709770-5919-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20121114145253.aa79fb48.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2012 09:42:50 +0100
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Add devicetree probing, fixing some whitespace damage along the way.
> 

I've already merged the below.  It has better code but a little less
documentation:

From: Roland Stigge <stigge@antcom.de>
Subject: drivers/rtc/rtc-imxdi.c: add devicetree support

Add device tree support to the rtc-imxdi driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt |   17 ++++++++++
 drivers/rtc/rtc-imxdi.c                             |   11 ++++++
 2 files changed, 28 insertions(+)

diff -puN /dev/null Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
--- /dev/null
+++ a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
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
diff -puN drivers/rtc/rtc-imxdi.c~rtc-imxdi-add-devicetree-support drivers/rtc/rtc-imxdi.c
--- a/drivers/rtc/rtc-imxdi.c~rtc-imxdi-add-devicetree-support
+++ a/drivers/rtc/rtc-imxdi.c
@@ -37,6 +37,7 @@
 #include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
+#include <linux/of.h>
 
 /* DryIce Register Definitions */
 
@@ -495,10 +496,20 @@ static int __devexit dryice_rtc_remove(s
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
_
