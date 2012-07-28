From: zonque@gmail.com (Daniel Mack)
Date: Sat, 28 Jul 2012 12:07:33 +0200
Subject: [PATCH v3 1/9] RTC: add DT bindings to pxa-rtc
In-Reply-To: <1343470061-16879-1-git-send-email-zonque@gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
Message-ID: <1343470061-16879-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds generic device tree bindings to the PXA RTC driver.
Documentation for bindings were also added.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt | 14 ++++++++++++++
 drivers/rtc/rtc-pxa.c                             | 11 +++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/pxa-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
new file mode 100644
index 0000000..8c6672a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
@@ -0,0 +1,14 @@
+* PXA RTC
+
+PXA specific RTC driver.
+
+Required properties:
+- compatible : Should be "marvell,pxa-rtc"
+
+Examples:
+
+rtc at 40900000 {
+	compatible = "marvell,pxa-rtc";
+	reg = <0x40900000 0x3c>;
+	interrupts = <30 31>;
+};
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 0075c8f..f771b2e 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -27,6 +27,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 
@@ -396,6 +398,14 @@ static int __exit pxa_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id pxa_rtc_dt_ids[] = {
+	{ .compatible = "marvell,pxa-rtc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pxa_rtc_dt_ids);
+#endif
+
 #ifdef CONFIG_PM
 static int pxa_rtc_suspend(struct device *dev)
 {
@@ -425,6 +435,7 @@ static struct platform_driver pxa_rtc_driver = {
 	.remove		= __exit_p(pxa_rtc_remove),
 	.driver		= {
 		.name	= "pxa-rtc",
+		.of_match_table = of_match_ptr(pxa_rtc_dt_ids),
 #ifdef CONFIG_PM
 		.pm	= &pxa_rtc_pm_ops,
 #endif
-- 
1.7.11.2
