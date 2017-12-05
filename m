From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  5 Dec 2017 16:01:45 -0500
Subject: [PATCH] ACPI / GED: unregister interrupts during shutdown
Message-ID: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GED interrupts could be pending by the time we are doing a reboot.

Even though GED driver uses devm_request_irq() to register the interrupt
handler, the handler is not being freed on time during a shutdown since
the driver is missing a shutdown callback.

If the ACPI handler is no longer available, this causes an interrupt
storm and delays shutdown.

Register a shutdown callback and manually free the interrupts.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/evged.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 46f0603..dde50ea 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -1,7 +1,7 @@
 /*
  * Generic Event Device for ACPI.
  *
- * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2016-2017, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -49,6 +49,11 @@
 
 #define MODULE_NAME	"acpi-ged"
 
+struct acpi_ged_device {
+	struct device *dev;
+	struct list_head event_list;
+};
+
 struct acpi_ged_event {
 	struct list_head node;
 	struct device *dev;
@@ -76,7 +81,8 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	unsigned int irq;
 	unsigned int gsi;
 	unsigned int irqflags = IRQF_ONESHOT;
-	struct device *dev = context;
+	struct acpi_ged_device *geddev = context;
+	struct device *dev = geddev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
 	acpi_handle evt_handle;
 	struct resource r;
@@ -122,29 +128,53 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		return AE_ERROR;
 	}
 
+	dev_info(dev, "GED listening GSI %u @ IRQ %u\n", gsi, irq);
+	list_add_tail(&event->node, &geddev->event_list);
 	return AE_OK;
 }
 
 static int ged_probe(struct platform_device *pdev)
 {
+	struct acpi_ged_device *geddev;
 	acpi_status acpi_ret;
 
+	geddev = devm_kzalloc(&pdev->dev, sizeof(*geddev), GFP_KERNEL);
+	if (!geddev)
+		return -ENOMEM;
+
+	geddev->dev = &pdev->dev;
+	INIT_LIST_HEAD(&geddev->event_list);
 	acpi_ret = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), "_CRS",
-				       acpi_ged_request_interrupt, &pdev->dev);
+				       acpi_ged_request_interrupt, geddev);
 	if (ACPI_FAILURE(acpi_ret)) {
 		dev_err(&pdev->dev, "unable to parse the _CRS record\n");
 		return -EINVAL;
 	}
+	platform_set_drvdata(pdev, geddev);
 
 	return 0;
 }
 
+static void ged_remove(struct platform_device *pdev)
+{
+	struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
+	struct acpi_ged_event *event, *next;
+
+	list_for_each_entry_safe(event, next, &geddev->event_list, node) {
+		devm_free_irq(geddev->dev, event->irq, event);
+		list_del(&event->node);
+		dev_info(geddev->dev, "GED releasing GSI %u @ IRQ %u\n",
+			 event->gsi, event->irq);
+	}
+}
+
 static const struct acpi_device_id ged_acpi_ids[] = {
 	{"ACPI0013"},
 	{},
 };
 
 static struct platform_driver ged_driver = {
+	.shutdown = ged_remove,
 	.probe = ged_probe,
 	.driver = {
 		.name = MODULE_NAME,
-- 
1.9.1
