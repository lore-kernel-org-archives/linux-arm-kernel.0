From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:01:02 +0100
Subject: [RFC 22/23] xen/privcmd: Add support for Linux 64KB page granularity
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-23-git-send-email-julien.grall@citrix.com>
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
 drivers/xen/privcmd.c   |  8 +++++---
 drivers/xen/xlate_mmu.c | 31 ++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 14 deletions(-)

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
index 58a5389..b9dfe1b 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -63,6 +63,7 @@ static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
 
 struct remap_data {
 	xen_pfn_t *fgmfn; /* foreign domain's gmfn */
+	xen_pfn_t *egmfn; /* end foreign domain's gmfn */
 	pgprot_t prot;
 	domid_t  domid;
 	struct vm_area_struct *vma;
@@ -78,17 +79,23 @@ static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
 {
 	struct remap_data *info = data;
 	struct page *page = info->pages[info->index++];
-	unsigned long pfn = page_to_pfn(page);
-	pte_t pte = pte_mkspecial(pfn_pte(pfn, info->prot));
+	unsigned long pfn = xen_page_to_pfn(page);
+	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), info->prot));
 	int rc;
-
-	rc = map_foreign_page(pfn, *info->fgmfn, info->domid);
-	*info->err_ptr++ = rc;
-	if (!rc) {
-		set_pte_at(info->vma->vm_mm, addr, ptep, pte);
-		info->mapped++;
+	uint32_t i;
+
+	for (i = 0; i < XEN_PFN_PER_PAGE; i++) {
+		if (info->fgmfn == info->egmfn)
+			break;
+
+		rc = map_foreign_page(pfn++, *info->fgmfn, info->domid);
+		*info->err_ptr++ = rc;
+		if (!rc) {
+			set_pte_at(info->vma->vm_mm, addr, ptep, pte);
+			info->mapped++;
+		}
+		info->fgmfn++;
 	}
-	info->fgmfn++;
 
 	return 0;
 }
@@ -102,13 +109,14 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 {
 	int err;
 	struct remap_data data;
-	unsigned long range = nr << PAGE_SHIFT;
+	unsigned long range = round_up(nr, XEN_PFN_PER_PAGE) << XEN_PAGE_SHIFT;
 
 	/* Kept here for the purpose of making sure code doesn't break
 	   x86 PVOPS */
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
 
 	data.fgmfn = mfn;
+	data.egmfn = mfn + nr;
 	data.prot  = prot;
 	data.domid = domid;
 	data.vma   = vma;
@@ -132,7 +140,8 @@ int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
 		struct xen_remove_from_physmap xrp;
 		unsigned long pfn;
 
-		pfn = page_to_pfn(pages[i]);
+		pfn = xen_page_to_pfn(pages[i / XEN_PFN_PER_PAGE]) +
+			(i % XEN_PFN_PER_PAGE);
 
 		xrp.domid = DOMID_SELF;
 		xrp.gpfn = pfn;
-- 
2.1.4
