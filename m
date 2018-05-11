From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 11 May 2018 20:06:07 +0100
Subject: [PATCH v2 06/40] iommu/sva: Search mm by PASID
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Message-ID: <20180511190641.23008-7-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 26 ++++++++++++++++++++++++++
 include/linux/iommu.h     |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index e9afae2537a2..5abe0f0b445c 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -736,3 +736,29 @@ void __iommu_sva_unbind_dev_all(struct device *dev)
 	}
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
+
+/**
+ * iommu_sva_find() - Find mm associated to the given PASID
+ * @pasid: Process Address Space ID assigned to the mm
+ *
+ * Returns the mm corresponding to this PASID, or NULL if not found. A reference
+ * to the mm is taken, and must be released with mmput().
+ */
+struct mm_struct *iommu_sva_find(int pasid)
+{
+	struct io_mm *io_mm;
+	struct mm_struct *mm = NULL;
+
+	spin_lock(&iommu_sva_lock);
+	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	if (io_mm && io_mm_get_locked(io_mm)) {
+		if (mmget_not_zero(io_mm->mm))
+			mm = io_mm->mm;
+
+		io_mm_put_locked(io_mm);
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	return mm;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index caa6f79785b9..faf3390ce89d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1001,6 +1001,7 @@ extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void __iommu_sva_unbind_dev_all(struct device *dev);
 
+extern struct mm_struct *iommu_sva_find(int pasid);
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -1030,6 +1031,11 @@ static inline int __iommu_sva_unbind_device(struct device *dev, int pasid)
 static inline void __iommu_sva_unbind_dev_all(struct device *dev)
 {
 }
+
+static inline struct mm_struct *iommu_sva_find(int pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.17.0
