From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jul 2015 13:16:37 +0100
Subject: [PATCH v4 03/19] device core: Introduce per-device MSI domain pointer
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436962613-17359-4-git-send-email-marc.zyngier@arm.com>
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
index 22227e7..7c49b48 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -714,6 +714,7 @@ struct device_dma_parameters {
  * @pins:	For device pin management.
  *		See Documentation/pinctrl.txt for details.
  * @msi_list:	Hosts MSI descriptors
+ * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
@@ -774,6 +775,9 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*msi_domain; /* MSI domain device uses */
+#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
@@ -864,6 +868,22 @@ static inline void set_dev_node(struct device *dev, int node)
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
