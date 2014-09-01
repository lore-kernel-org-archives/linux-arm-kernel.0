From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  1 Sep 2014 23:06:00 +0800
Subject: [RFC PATCH for Juno 1/2] net: smsc911x add support for probing from
 ACPI
In-Reply-To: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

This is a standard platform device to resources are converted in the
ACPI core in the same fasion as DT resources. For the other DT
provided information there is _DSD for ACPI.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/net/ethernet/smsc/smsc911x.c |   38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 5e13fa5..69d725a 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -59,6 +59,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_net.h>
+#include <linux/acpi.h>
 #include "smsc911x.h"
 
 #define SMSC_CHIPNAME		"smsc911x"
@@ -2369,9 +2370,36 @@ static inline int smsc911x_probe_config_dt(
 }
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+/* Configure some sensible defaults for ACPI mode */
+static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
+				    acpi_handle *ahandle)
+{
+	if (!ahandle)
+		return -ENOSYS;
+
+	config->phy_interface = PHY_INTERFACE_MODE_MII;
+
+	config->flags |= SMSC911X_USE_32BIT;
+
+	config->irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH;
+
+	config->irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL;
+
+	return 0;
+}
+#else
+static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
+				      acpi_handle *ahandle)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_ACPI */
+
 static int smsc911x_drv_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	acpi_handle *ahandle = ACPI_HANDLE(&pdev->dev);
 	struct net_device *dev;
 	struct smsc911x_data *pdata;
 	struct smsc911x_platform_config *config = dev_get_platdata(&pdev->dev);
@@ -2436,6 +2464,9 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	}
 
 	retval = smsc911x_probe_config_dt(&pdata->config, np);
+	if (retval)
+		retval = smsc911x_probe_config_acpi(&pdata->config, ahandle);
+
 	if (retval && config) {
 		/* copy config parameters across to pdata */
 		memcpy(&pdata->config, config, sizeof(pdata->config));
@@ -2606,6 +2637,12 @@ static const struct of_device_id smsc911x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, smsc911x_dt_ids);
 #endif
 
+static const struct acpi_device_id smsc911x_acpi_ids[] = {
+	{ "LNRO001B", },
+	{ "ARMH9118", },
+	{ }
+};
+
 static struct platform_driver smsc911x_driver = {
 	.probe = smsc911x_drv_probe,
 	.remove = smsc911x_drv_remove,
@@ -2614,6 +2651,7 @@ static struct platform_driver smsc911x_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= SMSC911X_PM_OPS,
 		.of_match_table = of_match_ptr(smsc911x_dt_ids),
+		.acpi_match_table = ACPI_PTR(smsc911x_acpi_ids),
 	},
 };
 
-- 
1.7.9.5
