From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 9 Aug 2016 15:06:01 +0800
Subject: [RFC PATCH 05/10] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
References: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1470726366-40809-6-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

With the platform msi domain created, we can set up the msi domain
for a platform device when it's probed.

This patch introduces acpi_configure_msi_domain(), which retrieves
the domain from iort and set it to platform device.

As some platform devices such as an irqchip needs the msi irqdomain
to be the interrupt parent domain, we need to get irqdomain before
platform device is probed.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/iort.c         |  5 ++++-
 drivers/base/platform-msi.c | 14 ++++++++++++++
 drivers/base/platform.c     |  2 ++
 include/linux/msi.h         |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index cbace4d6..764d25a 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -387,6 +387,7 @@ iort_get_device_domain(struct device *dev, u32 req_id)
 {
 	static struct fwnode_handle *handle;
 	int its_id;
+	enum irq_domain_bus_token bus_token;
 
 	if (!iort_table)
 		return NULL;
@@ -398,7 +399,9 @@ iort_get_device_domain(struct device *dev, u32 req_id)
 	if (!handle)
 		return NULL;
 
-	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
+	bus_token = dev_is_pci(dev) ?
+		    DOMAIN_BUS_PCI_MSI : DOMAIN_BUS_PLATFORM_MSI;
+	return irq_find_matching_fwnode(handle, bus_token);
 }
 
 void __init iort_table_detect(void)
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 279e539..d8b28d3 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/iort.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -416,3 +417,16 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	return err;
 }
+
+int acpi_configure_msi_domain(struct device *dev)
+{
+	struct irq_domain *d = NULL;
+
+	d = iort_get_device_domain(dev, 0);
+	if (d) {
+		dev_set_msi_domain(dev, d);
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6482d47..ea01a37 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -24,6 +24,7 @@
 #include <linux/pm_domain.h>
 #include <linux/idr.h>
 #include <linux/acpi.h>
+#include <linux/msi.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/limits.h>
 #include <linux/property.h>
@@ -500,6 +501,7 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
 
+	acpi_configure_msi_domain(&pdev->dev);
 	if (pdevinfo->dma_mask) {
 		/*
 		 * This memory isn't freed when the device is put,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4f0bfe5..2850ae9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -306,6 +306,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+int acpi_configure_msi_domain(struct device *dev);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-- 
1.7.12.4
