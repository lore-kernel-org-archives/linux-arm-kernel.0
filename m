From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Jan 2015 17:06:05 +0000
Subject: [PATCH v2 1/8] device core: Introduce per-device MSI domain pointer
In-Reply-To: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1420736772-11088-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As MSI-type features are creeping into non-PCI devices, it is
starting to make sense to give our struct device some form of
support for this, by allowing a pointer to an MSI irq domain to
be set/retrieved.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/device.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index fb50673..ec4cee5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -690,6 +690,7 @@ struct acpi_dev_node {
  * 		along with subsystem-level and driver-level callbacks.
  * @pins:	For device pin management.
  *		See Documentation/pinctrl.txt for details.
+ * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
@@ -750,6 +751,9 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*msi_domain; /* MSI domain device uses */
+#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
@@ -837,6 +841,22 @@ static inline void set_dev_node(struct device *dev, int node)
 }
 #endif
 
+static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	return dev->msi_domain;
+#else
+	return NULL;
+#endif
+}
+
+static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	dev->msi_domain = d;
+#endif
+}
+
 static inline void *dev_get_drvdata(const struct device *dev)
 {
 	return dev->driver_data;
-- 
2.1.4
