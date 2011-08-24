From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 24 Aug 2011 20:08:11 +0300
Subject: [PATCH v2 4/7] omap: iommu: PREFETCH_IOTLB cleanup
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Message-ID: <1314205694-28935-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PREFETCH_IOTLB to control the content of the called function,
instead of inlining it in the code.

This improves readability of the code, and also prevents an "unused
function" warning to show up when PREFETCH_IOTLB isn't set.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/iommu/omap-iommu.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3aad2e3..966093a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -253,6 +253,7 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
+#ifdef PREFETCH_IOTLB
 static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
@@ -310,6 +311,20 @@ out:
 	return err;
 }
 
+#else /* !PREFETCH_IOTLB */
+
+static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return 0;
+}
+
+#endif /* !PREFETCH_IOTLB */
+
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return load_iotlb_entry(obj, e);
+}
+
 /**
  * flush_iotlb_page - Clear an iommu tlb entry
  * @obj:	target iommu
@@ -663,10 +678,8 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 
 	flush_iotlb_page(obj, e->da);
 	err = iopgtable_store_entry_core(obj, e);
-#ifdef PREFETCH_IOTLB
 	if (!err)
-		load_iotlb_entry(obj, e);
-#endif
+		prefetch_iotlb_entry(obj, e);
 	return err;
 }
 EXPORT_SYMBOL_GPL(iopgtable_store_entry);
-- 
1.7.4.1
