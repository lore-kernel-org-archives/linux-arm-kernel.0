From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 18 Aug 2011 02:10:05 +0300
Subject: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
In-Reply-To: <1313622608-30397-1-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Message-ID: <1313622608-30397-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PREFETCH_IOTLB to control the content of the called function,
instead of inlining it in the code.

This improves readability of the code, and also prevents an "unused
function" warning to show up when PREFETCH_IOTLB isn't set.

While we're at it, rename load_iotlb_entry to prefetch_iotlb_entry
to better reflect the purpose of that function.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ed81977..7280e5b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -248,11 +248,12 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
 }
 
 /**
- * load_iotlb_entry - Set an iommu tlb entry
+ * prefetch_iotlb_entry - Set an iommu tlb entry
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+#ifdef PREFETCH_IOTLB
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
 	struct iotlb_lock l;
@@ -309,6 +310,15 @@ out:
 	return err;
 }
 
+#else /* !PREFETCH_IOTLB */
+
+static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+{
+	return 0;
+}
+
+#endif /* !PREFETCH_IOTLB */
+
 /**
  * flush_iotlb_page - Clear an iommu tlb entry
  * @obj:	target iommu
@@ -662,10 +672,8 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 
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
