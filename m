From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:34 +0100
Subject: [PATCH v5 19/22] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-20-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hypercall interface (as well as the toolstack) is always using 4KB
page granularity. When the toolstack is asking for mapping a series of
guest PFN in a batch, it expects to have the page map contiguously in
its virtual memory.

When Linux is using 64KB page granularity, the privcmd driver will have
to map multiple Xen PFN in a single Linux page.

Note that this solution works on page granularity which is a multiple of
4KB.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

    I kept the hypercall arguments in remap_data to avoid allocating them on
    the stack every time that remap_pte_fn is called.
    I will keep like that unless someone is strongly disagree.

    Changes in v4:
        - s/xen_page_to_pfn/page_to_xen_pfn/ based on the new naming
        - Add David's reviewed-by

    Changes in v3:
        - The function to split a Linux page in mutiple Xen page has
        been moved internally. It was the only use (not used anymore in
        the balloon) and it's not quite clear what should be the common
        interface. Differ the question until someone need to use it.
        - s/nr_pfn/numgfns/ to make clear that we are dealing with GFN
        - Use DIV_ROUND_UP rather round_up and fix the usage in
        xen_xlate_unmap_gfn_range

    Changes in v2:
        - Use xen_apply_to_page
---
 drivers/xen/privcmd.c   |   8 ++--
 drivers/xen/xlate_mmu.c | 124 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 89 insertions(+), 43 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b199ad3..df2e6f7 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -446,7 +446,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 		return -EINVAL;
 	}
 
-	nr_pages = m.num;
+	nr_pages = DIV_ROUND_UP(m.num, XEN_PFN_PER_PAGE);
 	if ((m.num <= 0) || (nr_pages > (LONG_MAX >> PAGE_SHIFT)))
 		return -EINVAL;
 
@@ -494,7 +494,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 			goto out_unlock;
 		}
 		if (xen_feature(XENFEAT_auto_translated_physmap)) {
-			ret = alloc_empty_pages(vma, m.num);
+			ret = alloc_empty_pages(vma, nr_pages);
 			if (ret < 0)
 				goto out_unlock;
 		} else
@@ -518,6 +518,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 	state.global_error  = 0;
 	state.version       = version;
 
+	BUILD_BUG_ON(((PAGE_SIZE / sizeof(xen_pfn_t)) % XEN_PFN_PER_PAGE) != 0);
 	/* mmap_batch_fn guarantees ret == 0 */
 	BUG_ON(traverse_pages_block(m.num, sizeof(xen_pfn_t),
 				    &pagelist, mmap_batch_fn, &state));
@@ -582,12 +583,13 @@ static void privcmd_close(struct vm_area_struct *vma)
 {
 	struct page **pages = vma->vm_private_data;
 	int numpgs = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	int numgfns = (vma->vm_end - vma->vm_start) >> XEN_PAGE_SHIFT;
 	int rc;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap) || !numpgs || !pages)
 		return;
 
-	rc = xen_unmap_domain_gfn_range(vma, numpgs, pages);
+	rc = xen_unmap_domain_gfn_range(vma, numgfns, pages);
 	if (rc == 0)
 		free_xenballooned_pages(numpgs, pages);
 	else
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index cff2387..5063c5e 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -38,31 +38,28 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
 
-/* map fgfn of domid to lpfn in the current domain */
-static int map_foreign_page(unsigned long lpfn, unsigned long fgfn,
-			    unsigned int domid)
-{
-	int rc;
-	struct xen_add_to_physmap_range xatp = {
-		.domid = DOMID_SELF,
-		.foreign_domid = domid,
-		.size = 1,
-		.space = XENMAPSPACE_gmfn_foreign,
-	};
-	xen_ulong_t idx = fgfn;
-	xen_pfn_t gpfn = lpfn;
-	int err = 0;
+typedef void (*xen_gfn_fn_t)(unsigned long gfn, void *data);
 
-	set_xen_guest_handle(xatp.idxs, &idx);
-	set_xen_guest_handle(xatp.gpfns, &gpfn);
-	set_xen_guest_handle(xatp.errs, &err);
+/* Break down the pages in 4KB chunk and call fn for each gfn */
+static void xen_for_each_gfn(struct page **pages, unsigned nr_gfn,
+			     xen_gfn_fn_t fn, void *data)
+{
+	unsigned long xen_pfn = 0;
+	struct page *page;
+	int i;
 
-	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
-	return rc < 0 ? rc : err;
+	for (i = 0; i < nr_gfn; i++) {
+		if ((i % XEN_PFN_PER_PAGE) == 0) {
+			page = pages[i / XEN_PFN_PER_PAGE];
+			xen_pfn = page_to_xen_pfn(page);
+		}
+		fn(pfn_to_gfn(xen_pfn++), data);
+	}
 }
 
 struct remap_data {
 	xen_pfn_t *fgfn; /* foreign domain's gfn */
+	int nr_fgfn; /* Number of foreign gfn left to map */
 	pgprot_t prot;
 	domid_t  domid;
 	struct vm_area_struct *vma;
@@ -71,24 +68,71 @@ struct remap_data {
 	struct xen_remap_gfn_info *info;
 	int *err_ptr;
 	int mapped;
+
+	/* Hypercall parameters */
+	int h_errs[XEN_PFN_PER_PAGE];
+	xen_ulong_t h_idxs[XEN_PFN_PER_PAGE];
+	xen_pfn_t h_gpfns[XEN_PFN_PER_PAGE];
+
+	int h_iter;	/* Iterator */
 };
 
+static void setup_hparams(unsigned long gfn, void *data)
+{
+	struct remap_data *info = data;
+
+	info->h_idxs[info->h_iter] = *info->fgfn;
+	info->h_gpfns[info->h_iter] = gfn;
+	info->h_errs[info->h_iter] = 0;
+
+	info->h_iter++;
+	info->fgfn++;
+}
+
 static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
 			void *data)
 {
 	struct remap_data *info = data;
 	struct page *page = info->pages[info->index++];
-	unsigned long pfn = page_to_pfn(page);
-	pte_t pte = pte_mkspecial(pfn_pte(pfn, info->prot));
-	int rc;
+	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), info->prot));
+	int rc, nr_gfn;
+	uint32_t i;
+	struct xen_add_to_physmap_range xatp = {
+		.domid = DOMID_SELF,
+		.foreign_domid = info->domid,
+		.space = XENMAPSPACE_gmfn_foreign,
+	};
 
-	rc = map_foreign_page(pfn, *info->fgfn, info->domid);
-	*info->err_ptr++ = rc;
-	if (!rc) {
-		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
-		info->mapped++;
+	nr_gfn = min_t(typeof(info->nr_fgfn), XEN_PFN_PER_PAGE, info->nr_fgfn);
+	info->nr_fgfn -= nr_gfn;
+
+	info->h_iter = 0;
+	xen_for_each_gfn(&page, nr_gfn, setup_hparams, info);
+	BUG_ON(info->h_iter != nr_gfn);
+
+	set_xen_guest_handle(xatp.idxs, info->h_idxs);
+	set_xen_guest_handle(xatp.gpfns, info->h_gpfns);
+	set_xen_guest_handle(xatp.errs, info->h_errs);
+	xatp.size = nr_gfn;
+
+	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
+
+	/* info->err_ptr expect to have one error status per Xen PFN */
+	for (i = 0; i < nr_gfn; i++) {
+		int err = (rc < 0) ? rc : info->h_errs[i];
+
+		*(info->err_ptr++) = err;
+		if (!err)
+			info->mapped++;
 	}
-	info->fgfn++;
+
+	/*
+	 * Note: The hypercall will return 0 in most of the case if even if
+	 * all the fgmfn are not mapped. We still have to update the pte
+	 * as the userspace may decide to continue.
+	 */
+	if (!rc)
+		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
 
 	return 0;
 }
@@ -102,13 +146,14 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 {
 	int err;
 	struct remap_data data;
-	unsigned long range = nr << PAGE_SHIFT;
+	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
 
 	/* Kept here for the purpose of making sure code doesn't break
 	   x86 PVOPS */
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
 
 	data.fgfn = gfn;
+	data.nr_fgfn = nr;
 	data.prot  = prot;
 	data.domid = domid;
 	data.vma   = vma;
@@ -123,21 +168,20 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_xlate_remap_gfn_array);
 
-int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
-			      int nr, struct page **pages)
+static void unmap_gfn(unsigned long gfn, void *data)
 {
-	int i;
+	struct xen_remove_from_physmap xrp;
 
-	for (i = 0; i < nr; i++) {
-		struct xen_remove_from_physmap xrp;
-		unsigned long pfn;
+	xrp.domid = DOMID_SELF;
+	xrp.gpfn = gfn;
+	(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
+}
 
-		pfn = page_to_pfn(pages[i]);
+int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
+			      int nr, struct page **pages)
+{
+	xen_for_each_gfn(pages, nr, unmap_gfn, NULL);
 
-		xrp.domid = DOMID_SELF;
-		xrp.gpfn = pfn;
-		(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xen_xlate_unmap_gfn_range);
-- 
2.1.4
