From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 12 Dec 2017 19:37:27 -0500
Subject: [PATCH V4] ACPI / GED: unregister interrupts during shutdown
Message-ID: <1513125448-6509-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GED interrupts could be pending by the time we are doing a reboot.

Even though GED driver uses devm_request_irq() to register the interrupt
handler, the handler is not being freed on time during a shutdown since
the driver is missing a shutdown callback.

If the ACPI handler is no longer available, this causes an interrupt
storm and delays shutdown.

1. Don't use devm family of functions for IRQ registration/free
2. Keep track of the events since free_irq() requires the dev_id parameter
passed into the request_irq() function.
3. Call free_irq() on both remove and shutdown explicitly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/evged.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 46f0603..f13ba2c 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
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
@@ -102,8 +108,6 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		return AE_ERROR;
 	}
 
-	dev_info(dev, "GED listening GSI %u @ IRQ %u\n", gsi, irq);
-
 	event = devm_kzalloc(dev, sizeof(*event), GFP_KERNEL);
 	if (!event)
 		return AE_ERROR;
@@ -116,29 +120,58 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	if (r.flags & IORESOURCE_IRQ_SHAREABLE)
 		irqflags |= IRQF_SHARED;
 
-	if (devm_request_threaded_irq(dev, irq, NULL, acpi_ged_irq_handler,
-				      irqflags, "ACPI:Ged", event)) {
+	if (request_threaded_irq(irq, NULL, acpi_ged_irq_handler,
+				 irqflags, "ACPI:Ged", event)) {
 		dev_err(dev, "failed to setup event handler for irq %u\n", irq);
 		return AE_ERROR;
 	}
 
+	dev_dbg(dev, "GED listening GSI %u @ IRQ %u\n", gsi, irq);
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
 
+static void ged_shutdown(struct platform_device *pdev)
+{
+	struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
+	struct acpi_ged_event *event, *next;
+
+	list_for_each_entry_safe(event, next, &geddev->event_list, node) {
+		free_irq(event->irq, event);
+		list_del(&event->node);
+		dev_dbg(geddev->dev, "GED releasing GSI %u @ IRQ %u\n",
+			 event->gsi, event->irq);
+	}
+}
+
+static int ged_remove(struct platform_device *pdev)
+{
+	ged_shutdown(pdev);
+	return 0;
+}
+
 static const struct acpi_device_id ged_acpi_ids[] = {
 	{"ACPI0013"},
 	{},
@@ -146,6 +179,8 @@ static int ged_probe(struct platform_device *pdev)
 
 static struct platform_driver ged_driver = {
 	.probe = ged_probe,
+	.remove = ged_remove,
+	.shutdown = ged_shutdown,
 	.driver = {
 		.name = MODULE_NAME,
 		.acpi_match_table = ACPI_PTR(ged_acpi_ids),
-- 
1.9.1
