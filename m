From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  7 Jun 2016 16:01:24 +0000
Subject: [PATCH v10 5/9] genirq/msi-doorbell: msi_doorbell_safe
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1465315288-5931-6-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msi_doorbell_safe returns whether all the registered doorbells
implement irq_remapping.

When assigning a PCIe device whose host controller is upstream to
an IOMMU, we currently do not know whether the MSI controller is
upstream or downstream to the IOMMU.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/linux/msi-doorbell.h | 12 ++++++++++++
 kernel/irq/msi-doorbell.c    | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index abdaaa0..648f239 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -65,6 +65,13 @@ msi_doorbell_lookup(void *chip_data);
  */
 int msi_doorbell_pages(unsigned int order);
 
+/**
+ * msi_doorbell_safe: return whether all registered doorbells
+ * do implement irq_remapping and are safe to assign (coarse safety
+ * assessment)
+ */
+bool msi_doorbell_safe(void);
+
 #else
 
 static inline int
@@ -88,6 +95,11 @@ msi_doorbell_pages(unsigned int order)
 	return 0;
 }
 
+static inline bool
+msi_doorbell_safe(void)
+{
+	return true;
+}
 #endif /* CONFIG_MSI_DOORBELL */
 
 #endif
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
index 65ca9292..69121c8 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -132,3 +132,17 @@ int msi_doorbell_pages(unsigned int order)
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_pages);
 
+bool msi_doorbell_safe(void)
+{
+	struct irqchip_doorbell *db;
+	bool irq_remapping = true;
+
+	mutex_lock(&irqchip_doorbell_mutex);
+	list_for_each_entry(db, &irqchip_doorbell_list, next) {
+		irq_remapping &= db->info.irq_remapping;
+	}
+	mutex_unlock(&irqchip_doorbell_mutex);
+
+	return irq_remapping;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_safe);
-- 
1.9.1
