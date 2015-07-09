From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:21 +0100
Subject: [PATCH v2 09/20] xen/biomerge: Don't allow biovec to be merge when
 Linux is not using 4KB page
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-10-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Linux is using 64K page granularity, every page will be slipt in
multiple non-contiguous 4K MFN (page granularity of Xen).

I'm not sure how to handle efficiently the check to know whether we can
merge 2 biovec with a such case. So for now, always says that biovec are
not mergeable.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
    Changes in v2:
        - Remove the workaround and check if the Linux page granularity
        is the same as Xen or not
---
 drivers/xen/biomerge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 0edb91c..571567c 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -6,10 +6,17 @@
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 			       const struct bio_vec *vec2)
 {
+#if XEN_PAGE_SIZE == PAGE_SIZE
 	unsigned long mfn1 = pfn_to_mfn(page_to_pfn(vec1->bv_page));
 	unsigned long mfn2 = pfn_to_mfn(page_to_pfn(vec2->bv_page));
 
 	return __BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
 		((mfn1 == mfn2) || ((mfn1+1) == mfn2));
+#else
+	/* XXX: bio_vec are not mergeable when using different page size in
+	 * Xen and Linux
+	 */
+	return 0;
+#endif
 }
 EXPORT_SYMBOL(xen_biovec_phys_mergeable);
-- 
2.1.4
