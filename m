From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:23:32 +0000
Subject: [PATCH v12 06/11] genirq/msi: msi_doorbell_safe
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470158617-7022-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msi_doorbell_safe returns whether all the registered doorbells
implement irq_remapping.

IRQ remapping is the x86 terminology (IRQ translation used on ARM).
The MSI controller topology is safe if all the registered doorbells
implement IRQ remapping.

This safety notion is used on ARM when assigning PCIe devices. If
any of the MSI doorbell is unsafe, the MSI assignment gets considered
unsafe.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- reword the commit message
---
 include/linux/msi-doorbell.h | 13 +++++++++++++
 kernel/irq/msi-doorbell.c    |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
index bbedb3b..696e0bd 100644
--- a/include/linux/msi-doorbell.h
+++ b/include/linux/msi-doorbell.h
@@ -47,6 +47,14 @@ void msi_doorbell_unregister_global(struct msi_doorbell_info *db);
  */
 int msi_doorbell_calc_pages(unsigned int order);
 
+/**
+ * msi_doorbell_safe - return whether all registered doorbells are safe
+ *
+ * Safe doorbells are those which implement irq remapping
+ * Return: true if all doorbells are safe, false otherwise
+ */
+bool msi_doorbell_safe(void);
+
 #else
 
 static inline struct msi_doorbell_info *
@@ -64,6 +72,11 @@ static inline int msi_doorbell_calc_pages(unsigned int order)
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
index 5c6c2aa..f8f0d24 100644
--- a/kernel/irq/msi-doorbell.c
+++ b/kernel/irq/msi-doorbell.c
@@ -130,3 +130,9 @@ int msi_doorbell_calc_pages(unsigned int order)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(msi_doorbell_calc_pages);
+
+bool msi_doorbell_safe(void)
+{
+	return !nb_unsafe_doorbells;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_safe);
-- 
1.9.1
