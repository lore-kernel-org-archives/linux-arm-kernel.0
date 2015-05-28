From: yvo@apm.com (Y Vo)
Date: Thu, 28 May 2015 13:46:28 +0700
Subject: [PATCH v0] gpio: xgene: add ACPI support for APM X-Gene GPIO standby
 driver
Message-ID: <1432795588-17476-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI support for APM X-Gene GPIO standby driver.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/gpio-xgene-sb.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index b6a15c3..50aaae5 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -25,8 +25,11 @@
 #include <linux/of_gpio.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
+#include <linux/acpi.h>
 #include <linux/basic_mmio_gpio.h>
 
+#include "gpiolib.h"
+
 #define XGENE_MAX_GPIO_DS		22
 #define XGENE_MAX_GPIO_DS_IRQ		6
 
@@ -129,6 +132,13 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	else
 		dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
 
+#ifdef CONFIG_ACPI
+	if (priv->nirq > 0) {
+		/* Register interrupt handlers for gpio signaled acpi events */
+		acpi_gpiochip_request_interrupts(&priv->bgc.gc);
+	}
+#endif
+
 	return ret;
 }
 
@@ -145,10 +155,19 @@ static const struct of_device_id xgene_gpio_sb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
+	{"APMC0D15", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
+#endif
+
 static struct platform_driver xgene_gpio_sb_driver = {
 	.driver = {
 		   .name = "xgene-gpio-sb",
 		   .of_match_table = xgene_gpio_sb_of_match,
+		   .acpi_match_table = ACPI_PTR(xgene_gpio_sb_acpi_match),
 		   },
 	.probe = xgene_gpio_sb_probe,
 	.remove = xgene_gpio_sb_remove,
-- 
1.7.1
