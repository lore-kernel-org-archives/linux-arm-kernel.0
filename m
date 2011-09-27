From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 27 Sep 2011 11:14:22 +0300
Subject: [PATCH] iommu/core: let drivers know if an iommu fault
Message-ID: <mailman.155.1317113313.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

handler isn't installed

Let report_iommu_fault() return -ENOSYS whenever an iommu fault
handler isn't installed, so IOMMU drivers can then do their own
platform-specific default behavior if they want.

Clarify that -ENOSYS is reserved for this purpose, and that fault
handlers are prohibited from using it.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/iommu.c |    7 +++++++
 include/linux/iommu.h |    3 ++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a07259..c41a6a1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,6 +43,13 @@ EXPORT_SYMBOL_GPL(iommu_found);
  * iommu_set_fault_handler() - set a fault handler for an iommu domain
  * @domain: iommu domain
  * @handler: fault handler
+ *
+ * This function should be used by IOMMU users which want to be notified
+ * whenever an IOMMU fault happens.
+ *
+ * The fault handler itself should return 0 on success, and an appropriate
+ * error code otherwise. It should never return -ENOSYS though, as this is
+ * reserved for the IOMMU core to return when no handler is installed.
  */
 void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d084e87..2987199 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -98,11 +98,12 @@ extern void iommu_set_fault_handler(struct
iommu_domain *domain,
  * Returns 0 on success and an appropriate error code otherwise (if dynamic
  * PTE/TLB loading will one day be supported, implementations will be able
  * to tell whether it succeeded or not according to this return value).
+ * If a fault handler isn't installed, -ENOSYS is returned.
  */
 static inline int report_iommu_fault(struct iommu_domain *domain,
 		struct device *dev, unsigned long iova, int flags)
 {
-	int ret = 0;
+	int ret = -ENOSYS;

 	/*
 	 * if upper layers showed interest and installed a fault handler,
-- 
1.7.4.1
