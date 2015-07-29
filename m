From: tipbot@zytor.com (tip-bot for Marc Zyngier)
Date: Wed, 29 Jul 2015 15:25:32 -0700
Subject: [tip:irq/core] device core: Introduce per-device MSI domain pointer
In-Reply-To: <1438091186-10244-4-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <tip-f1421db8ca4c110144be97a5997ed83d34685db5@git.kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit-ID:  f1421db8ca4c110144be97a5997ed83d34685db5
Gitweb:     http://git.kernel.org/tip/f1421db8ca4c110144be97a5997ed83d34685db5
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 28 Jul 2015 14:46:10 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Jul 2015 00:14:37 +0200

device core: Introduce per-device MSI domain pointer

As MSI-type features are creeping into non-PCI devices, it is
starting to make sense to give our struct device some form of
support for this, by allowing a pointer to an MSI irq domain to
be set/retrieved.

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Yijing Wang <wangyijing@huawei.com>
Cc: Ma Jun <majun258@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Link: http://lkml.kernel.org/r/1438091186-10244-4-git-send-email-marc.zyngier at arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/device.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 3d3139a..50e0005 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -715,6 +715,7 @@ struct device_dma_parameters {
  * @pins:	For device pin management.
  *		See Documentation/pinctrl.txt for details.
  * @msi_list:	Hosts MSI descriptors
+ * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
@@ -775,6 +776,9 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*msi_domain;
+#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
@@ -865,6 +869,22 @@ static inline void set_dev_node(struct device *dev, int node)
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
