From: eric.auger@redhat.com (Eric Auger)
Date: Tue, 19 Jul 2016 13:02:43 +0000
Subject: [PATCH v11 06/10] genirq/msi-doorbell: msi_doorbell_safe
In-Reply-To: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1468933367-23159-7-git-send-email-eric.auger@redhat.com>
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
 kernel/irq/msi-doorbell.c    | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index 146bfbc..9c30141 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -43,6 +43,13 @@ void msi_doorbell_unregister_global(struct irq_chip_msi_doorbell_info *db);
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
 
 static inline struct irq_chip_msi_doorbell_info *
@@ -61,6 +68,11 @@ msi_doorbell_pages(unsigned int order)
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
index a5bde37..fa5b429 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -112,3 +112,18 @@ int msi_doorbell_pages(unsigned int order)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_pages);
+
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
\ No newline at end of file
-- 
1.9.1
