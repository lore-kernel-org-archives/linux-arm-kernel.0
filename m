From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:24 +0100
Subject: [PATCH v5 09/22] xen/biomerge: Don't allow biovec's to be merged when
 Linux is not using 4KB pages
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-10-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM all dma-capable devices on a same platform may not be protected
by an IOMMU. The DMA requests have to use the BFN (i.e MFN on ARM) in
order to use correctly the device.

While the DOM0 memory is allocated in a 1:1 fashion (PFN == MFN), grant
mapping will screw this contiguous mapping.

When Linux is using 64KB page granularitary, the page may be split
accross multiple non-contiguous MFN (Xen is using 4KB page
granularity). Therefore a DMA request will likely fail.

Checking that a 64KB page is using contiguous MFN is tedious. For
now, always says that biovec are not mergeable.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

    There is some ideas to check whether two biovec could be merged
    (see [1]) but it's not critical and can be consider as a performance
    improvement.

    Changes in v4:
        - Fix typoes in the subject
        - Add Stefano's reviewed-by

    Changes in v3:
        - Update commit message
        - s/mfn/bfn/ base on the new renaming
        - Update TODO

    Changes in v2:
        - Remove the workaround and check if the Linux page granularity
        is the same as Xen or not

    [1] https://lkml.org/lkml/2015/7/17/418
---
 drivers/xen/biomerge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 8ae2fc90..4da69db 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -6,10 +6,18 @@
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 			       const struct bio_vec *vec2)
 {
+#if XEN_PAGE_SIZE == PAGE_SIZE
 	unsigned long bfn1 = pfn_to_bfn(page_to_pfn(vec1->bv_page));
 	unsigned long bfn2 = pfn_to_bfn(page_to_pfn(vec2->bv_page));
 
 	return __BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
 		((bfn1 == bfn2) || ((bfn1+1) == bfn2));
+#else
+	/*
+	 * XXX: Add support for merging bio_vec when using different page
+	 * size in Xen and Linux.
+	 */
+	return 0;
+#endif
 }
 EXPORT_SYMBOL(xen_biovec_phys_mergeable);
-- 
2.1.4
