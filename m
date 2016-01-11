From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 11 Jan 2016 19:26:27 +0600
Subject: [PATCH v5 2/2] ACPI: amba bus probing support
In-Reply-To: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

On ARM64 some devices use the AMBA device and not the platform bus for
probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
does not have a suitable clock representation and to keep the core
AMBA bus code unchanged between probing methods.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/acpi_amba.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h  |   5 ++
 drivers/acpi/scan.c      |   1 +
 4 files changed, 129 insertions(+)
 create mode 100644 drivers/acpi/acpi_amba.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 675eaf3..3cf732f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -43,6 +43,7 @@ acpi-y				+= pci_root.o pci_link.o pci_irq.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
+acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
 acpi-y				+= int340x_thermal.o
 acpi-y				+= power.o
 acpi-y				+= event.o
diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
new file mode 100644
index 0000000..2a61b54
--- /dev/null
+++ b/drivers/acpi/acpi_amba.c
@@ -0,0 +1,122 @@
+
+/*
+ * ACPI support for platform bus type.
+ *
+ * Copyright (C) 2015, Linaro Ltd
+ * Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/amba/bus.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+static const struct acpi_device_id amba_id_list[] = {
+	{"ARMH0061", 0}, /* PL061 GPIO Device */
+	{"", 0},
+};
+
+static void amba_register_dummy_clk(void)
+{
+	static struct clk *amba_dummy_clk;
+
+	/* If clock already registered */
+	if (amba_dummy_clk)
+		return;
+
+	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
+						CLK_IS_ROOT, 0);
+	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
+}
+
+static int amba_handler_attach(struct acpi_device *adev,
+				const struct acpi_device_id *id)
+{
+	struct amba_device *dev;
+	struct resource_entry *rentry;
+	struct list_head resource_list;
+	bool address_found = false;
+	int irq_no = 0;
+	int ret;
+
+	/* If the ACPI node already has a physical device attached, skip it. */
+	if (adev->physical_node_count)
+		return 0;
+
+	dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
+	if (!dev) {
+		dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (ret < 0)
+		goto err_free;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		switch (resource_type(rentry->res)) {
+		case IORESOURCE_MEM:
+			if (!address_found) {
+				dev->res = *rentry->res;
+				address_found = true;
+			}
+			break;
+		case IORESOURCE_IRQ:
+			if (irq_no < AMBA_NR_IRQS)
+				dev->irq[irq_no++] = rentry->res->start;
+			break;
+		default:
+			dev_warn(&adev->dev, "Invalid resource\n");
+			break;
+		}
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	/*
+	 * If the ACPI node has a parent and that parent has a physical device
+	 * attached to it, that physical device should be the parent of
+	 * the amba device we are about to create.
+	 */
+	if (adev->parent)
+		dev->dev.parent = acpi_get_first_physical_node(adev->parent);
+
+	ACPI_COMPANION_SET(&dev->dev, adev);
+
+	ret = amba_device_add(dev, &iomem_resource);
+	if (ret) {
+		dev_err(&adev->dev, "%s(): amba_device_add() failed (%d)\n",
+		       __func__, ret);
+		goto err_free;
+	}
+
+	return 1;
+
+err_free:
+	amba_device_put(dev);
+	return ret;
+}
+
+static struct acpi_scan_handler amba_handler = {
+	.ids = amba_id_list,
+	.attach = amba_handler_attach,
+};
+
+void __init acpi_amba_init(void)
+{
+	amba_register_dummy_clk();
+	acpi_scan_add_handler(&amba_handler);
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ee9312ba..6086f66 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -29,6 +29,11 @@ void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
 void acpi_int340x_thermal_init(void);
+#ifdef CONFIG_ARM_AMBA
+void acpi_amba_init(void);
+#else
+static inline void acpi_amba_init(void) {}
+#endif
 int acpi_sysfs_init(void);
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78d5f02..20c8cba 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1922,6 +1922,7 @@ int __init acpi_scan_init(void)
 	acpi_memory_hotplug_init();
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
+	acpi_amba_init();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
-- 
2.7.0
