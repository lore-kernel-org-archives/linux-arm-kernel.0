From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:31 +0100
Subject: [PATCH v2 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
Changes in v2:
    - Use xen_apply_to_page
---
 drivers/xen/privcmd.c   |   8 +--
 drivers/xen/xlate_mmu.c | 127 +++++++++++++++++++++++++++++++++---------------
 2 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 5a29616..e8714b4 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -446,7 +446,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 		return -EINVAL;
 	}
 
-	nr_pages = m.num;
+	nr_pages = DIV_ROUND_UP_ULL(m.num, PAGE_SIZE / XEN_PAGE_SIZE);
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
+	int nr_pfn = (vma->vm_end - vma->vm_start) >> XEN_PAGE_SHIFT;
 	int rc;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap) || !numpgs || !pages)
 		return;
 
-	rc = xen_unmap_domain_mfn_range(vma, numpgs, pages);
+	rc = xen_unmap_domain_mfn_range(vma, nr_pfn, pages);
 	if (rc == 0)
 		free_xenballooned_pages(numpgs, pages);
 	else
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 58a5389..1fac17c 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -38,31 +38,9 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
 
-/* map fgmfn of domid to lpfn in the current domain */
-static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
-			    unsigned int domid)
-{
-	int rc;
-	struct xen_add_to_physmap_range xatp = {
-		.domid = DOMID_SELF,
-		.foreign_domid = domid,
-		.size = 1,
-		.space = XENMAPSPACE_gmfn_foreign,
-	};
-	xen_ulong_t idx = fgmfn;
-	xen_pfn_t gpfn = lpfn;
-	int err = 0;
-
-	set_xen_guest_handle(xatp.idxs, &idx);
-	set_xen_guest_handle(xatp.gpfns, &gpfn);
-	set_xen_guest_handle(xatp.errs, &err);
-
-	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
-	return rc < 0 ? rc : err;
-}
-
 struct remap_data {
 	xen_pfn_t *fgmfn; /* foreign domain's gmfn */
+	xen_pfn_t *efgmfn; /* pointer to the end of the fgmfn array */
 	pgprot_t prot;
 	domid_t  domid;
 	struct vm_area_struct *vma;
@@ -71,24 +49,75 @@ struct remap_data {
 	struct xen_remap_mfn_info *info;
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
 
+static int setup_hparams(struct page *page, unsigned long pfn, void *data)
+{
+	struct remap_data *info = data;
+
+	/* We may not have enough domain's gmfn to fill a Linux Page */
+	if (info->fgmfn == info->efgmfn)
+		return 0;
+
+	info->h_idxs[info->h_iter] = *info->fgmfn;
+	info->h_gpfns[info->h_iter] = pfn;
+	info->h_errs[info->h_iter] = 0;
+	info->h_iter++;
+
+	info->fgmfn++;
+
+	return 0;
+}
+
 static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
 			void *data)
 {
 	struct remap_data *info = data;
 	struct page *page = info->pages[info->index++];
-	unsigned long pfn = page_to_pfn(page);
-	pte_t pte = pte_mkspecial(pfn_pte(pfn, info->prot));
+	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), info->prot));
 	int rc;
+	uint32_t i;
+	struct xen_add_to_physmap_range xatp = {
+		.domid = DOMID_SELF,
+		.foreign_domid = info->domid,
+		.space = XENMAPSPACE_gmfn_foreign,
+	};
 
-	rc = map_foreign_page(pfn, *info->fgmfn, info->domid);
-	*info->err_ptr++ = rc;
-	if (!rc) {
-		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
-		info->mapped++;
+	info->h_iter = 0;
+
+	/* setup_hparams guarantees ret == 0 */
+	BUG_ON(xen_apply_to_page(page, setup_hparams, info));
+
+	set_xen_guest_handle(xatp.idxs, info->h_idxs);
+	set_xen_guest_handle(xatp.gpfns, info->h_gpfns);
+	set_xen_guest_handle(xatp.errs, info->h_errs);
+	xatp.size = info->h_iter;
+
+	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
+
+	/* info->err_ptr expect to have one error status per Xen PFN */
+	for (i = 0; i < info->h_iter; i++) {
+		int err = (rc < 0) ? rc : info->h_errs[i];
+
+		*(info->err_ptr++) = err;
+		if (!err)
+			info->mapped++;
 	}
-	info->fgmfn++;
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
@@ -102,13 +131,14 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 {
 	int err;
 	struct remap_data data;
-	unsigned long range = nr << PAGE_SHIFT;
+	unsigned long range = round_up(nr, XEN_PFN_PER_PAGE) << XEN_PAGE_SHIFT;
 
 	/* Kept here for the purpose of making sure code doesn't break
 	   x86 PVOPS */
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
 
 	data.fgmfn = mfn;
+	data.efgmfn = mfn + nr;
 	data.prot  = prot;
 	data.domid = domid;
 	data.vma   = vma;
@@ -123,21 +153,38 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_xlate_remap_gfn_array);
 
+static int unmap_gfn(struct page *page, unsigned long pfn, void *data)
+{
+	int *nr = data;
+	struct xen_remove_from_physmap xrp;
+
+	/* The Linux Page may not have been fully mapped to Xen */
+	if (!*nr)
+		return 0;
+
+	xrp.domid = DOMID_SELF;
+	xrp.gpfn = pfn;
+	(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
+
+	(*nr)--;
+
+	return 0;
+}
+
 int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
 			      int nr, struct page **pages)
 {
 	int i;
+	int nr_page = round_up(nr, XEN_PFN_PER_PAGE);
 
-	for (i = 0; i < nr; i++) {
-		struct xen_remove_from_physmap xrp;
-		unsigned long pfn;
+	for (i = 0; i < nr_page; i++) {
+		/* unmap_gfn guarantees ret == 0 */
+		BUG_ON(xen_apply_to_page(pages[i], unmap_gfn, &nr));
+	}
 
-		pfn = page_to_pfn(pages[i]);
+	/* We should have consume every xen page */
+	BUG_ON(nr != 0);
 
-		xrp.domid = DOMID_SELF;
-		xrp.gpfn = pfn;
-		(void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xen_xlate_unmap_gfn_range);
-- 
2.1.4
