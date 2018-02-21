From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:14 -0700
Subject: [PATCH 04/14] iommu: sva: Add support for pasid allocation
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-5-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some older SMMU implementations that do not have a fully featured
PASID model have alternate workarounds for using multiple pagetables.
For example, MSM GPUs have logic to automatically switch the user
pagetable from hardware by writing the context bank directly.

Instead of binding and sharing CPU pagetables these implementations
need to a new pagetable structure and populate it manually. Add a
new set of API functions to create and populate a pagetable structure
identified by a pasid.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/iommu-sva.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |   3 +-
 include/linux/iommu.h     |  56 +++++++++++
 3 files changed, 297 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 5fc689b1ef72..c48fde5b0bbd 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -809,3 +809,242 @@ struct mm_struct *iommu_sva_find(int pasid)
 	return mm;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+int iommu_sva_alloc_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	int ret, pasid;
+	struct io_pasid *io_pasid;
+
+	if (!domain->ops->pasid_alloc || !domain->ops->pasid_free)
+		return -ENODEV;
+
+	io_pasid = kzalloc(sizeof(*io_pasid), GFP_KERNEL);
+	if (!io_pasid)
+		return -ENOMEM;
+
+	io_pasid->domain = domain;
+	io_pasid->base.type = IO_TYPE_PASID;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_sva_lock);
+	pasid = idr_alloc_cyclic(&iommu_pasid_idr, &io_pasid->base,
+		1, (1 << 31), GFP_ATOMIC);
+	io_pasid->base.pasid = pasid;
+	spin_unlock(&iommu_sva_lock);
+	idr_preload_end();
+
+	if (pasid < 0) {
+		kfree(io_pasid);
+		return pasid;
+	}
+
+	ret = domain->ops->pasid_alloc(domain, dev, pasid);
+	if (!ret)
+		return pasid;
+
+	spin_lock(&iommu_sva_lock);
+	idr_remove(&iommu_pasid_idr, io_pasid->base.pasid);
+	spin_unlock(&iommu_sva_lock);
+
+	kfree(io_pasid);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+static struct io_pasid *get_io_pasid(int pasid)
+{
+	struct io_base *io_base;
+	struct io_pasid *io_pasid = NULL;
+
+	spin_lock(&iommu_sva_lock);
+	io_base = idr_find(&iommu_pasid_idr, pasid);
+	if (io_base && io_base->type == IO_TYPE_PASID)
+		io_pasid = container_of(io_base, struct io_pasid, base);
+	spin_unlock(&iommu_sva_lock);
+
+	return io_pasid;
+}
+
+int iommu_sva_map(int pasid, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	unsigned long orig_iova = iova;
+	unsigned int min_pagesz;
+	size_t orig_size = size;
+	struct io_pasid *io_pasid;
+	struct iommu_domain *domain;
+	int ret = 0;
+
+	io_pasid = get_io_pasid(pasid);
+	if (!io_pasid)
+		return -ENODEV;
+
+	domain = io_pasid->domain;
+
+	if (unlikely(domain->ops->sva_map == NULL ||
+		     domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
+	/* find out the minimum page size supported */
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	/*
+	 * both the virtual address and the physical one, as well as
+	 * the size of the mapping, must be aligned (at least) to the
+	 * size of the smallest page supported by the hardware
+	 */
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+		       iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		ret = domain->ops->sva_map(domain, pasid, iova, paddr, pgsize,
+			prot);
+		if (ret)
+			break;
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	/* unroll mapping in case something went wrong */
+	if (ret)
+		iommu_sva_unmap(pasid, orig_iova, orig_size - size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map);
+
+size_t iommu_sva_map_sg(int pasid, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot)
+{
+	struct io_pasid *io_pasid;
+	struct iommu_domain *domain;
+	struct scatterlist *s;
+	size_t mapped = 0;
+	unsigned int i, min_pagesz;
+	int ret;
+
+	io_pasid = get_io_pasid(pasid);
+	if (!io_pasid)
+		return -ENODEV;
+
+	domain = io_pasid->domain;
+
+	if (unlikely(domain->pgsize_bitmap == 0UL))
+		return 0;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	for_each_sg(sg, s, nents, i) {
+		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
+
+		/*
+		 * We are mapping on IOMMU page boundaries, so offset within
+		 * the page must be 0. However, the IOMMU may support pages
+		 * smaller than PAGE_SIZE, so s->offset may still represent
+		 * an offset of that boundary within the CPU page.
+		 */
+		if (!IS_ALIGNED(s->offset, min_pagesz))
+			goto out_err;
+
+		ret = iommu_sva_map(pasid, iova + mapped, phys, s->length,
+			prot);
+		if (ret)
+			goto out_err;
+
+		mapped += s->length;
+	}
+
+	return mapped;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, mapped);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map_sg);
+
+size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size)
+{
+	const struct iommu_ops *ops;
+	struct io_pasid *io_pasid;
+	struct iommu_domain *domain;
+	size_t unmapped_page, unmapped = 0;
+	unsigned int min_pagesz;
+
+	io_pasid = get_io_pasid(pasid);
+	if (!io_pasid)
+		return -ENODEV;
+
+	domain = io_pasid->domain;
+	ops = domain->ops;
+
+	if (unlikely(ops->sva_unmap == NULL ||
+		     domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
+	/* find out the minimum page size supported */
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	/*
+	 * The virtual address, as well as the size of the mapping, must be
+	 * aligned (at least) to the size of the smallest page supported
+	 * by the hardware
+	 */
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	/*
+	 * Keep iterating until we either unmap 'size' bytes (or more)
+	 * or we hit an area that isn't mapped.
+	 */
+	while (unmapped < size) {
+		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
+
+		unmapped_page = ops->sva_unmap(domain, pasid, iova, pgsize);
+		if (!unmapped_page)
+			break;
+
+		iova += unmapped_page;
+		unmapped += unmapped_page;
+	}
+
+	return unmapped;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap);
+
+void iommu_sva_free_pasid(int pasid)
+{
+	struct io_pasid *io_pasid;
+	struct iommu_domain *domain;
+
+	io_pasid = get_io_pasid(pasid);
+	if (!io_pasid)
+		return;
+
+	domain = io_pasid->domain;
+
+	domain->ops->pasid_free(domain, pasid);
+
+	spin_lock(&iommu_sva_lock);
+	idr_remove(&iommu_pasid_idr, io_pasid->base.pasid);
+	spin_unlock(&iommu_sva_lock);
+
+	kfree(io_pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7f8395b620b1..da3728388069 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1627,7 +1627,7 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
-static size_t iommu_pgsize(struct iommu_domain *domain,
+size_t iommu_pgsize(struct iommu_domain *domain,
 			   unsigned long addr_merge, size_t size)
 {
 	unsigned int pgsize_idx;
@@ -1658,6 +1658,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 
 	return pgsize;
 }
+EXPORT_SYMBOL_GPL(iommu_pgsize);
 
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e998389cf195..6e34b87655a7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -112,6 +112,7 @@ struct iommu_domain {
 
 enum iommu_io_type {
 	IO_TYPE_MM,
+	IO_TYPE_PASID,
 };
 
 struct io_base {
@@ -134,6 +135,11 @@ struct io_mm {
 	struct rcu_head		rcu;
 };
 
+struct io_pasid {
+	struct io_base		base;
+	struct iommu_domain	*domain;
+};
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
@@ -347,6 +353,15 @@ struct iommu_ops {
 	int (*page_response)(struct iommu_domain *domain, struct device *dev,
 			     struct page_response_msg *msg);
 
+	int (*pasid_alloc)(struct iommu_domain *domain, struct device *dev,
+		int pasid);
+	int (*sva_map)(struct iommu_domain *domain, int pasid,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
+	size_t (*sva_unmap)(struct iommu_domain *domain, int pasid,
+			    unsigned long iova, size_t size);
+	void (*pasid_free)(struct iommu_domain *domain, int pasid);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -577,6 +592,9 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 
+size_t iommu_pgsize(struct iommu_domain *domain,
+			   unsigned long addr_merge, size_t size);
+
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
@@ -1002,6 +1020,16 @@ extern int iommu_register_mm_exit_handler(struct device *dev,
 extern int iommu_unregister_mm_exit_handler(struct device *dev);
 
 extern struct mm_struct *iommu_sva_find(int pasid);
+
+extern int iommu_sva_alloc_pasid(struct iommu_domain *domain,
+		struct device *dev);
+extern int iommu_sva_map(int pasid, unsigned long iova, phys_addr_t physaddr,
+		size_t size, int prot);
+extern size_t iommu_sva_map_sg(int pasid, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot);
+extern size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size);
+extern void iommu_sva_free_pasid(int pasid);
+
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -1046,6 +1074,34 @@ static inline struct mm_struct *iommu_sva_find(int pasid)
 {
 	return NULL;
 }
+
+static inline int iommu_sva_alloc_pasid(struct iommu_domain *domain,
+		struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int iommu_sva_map(int pasid, unsigned long iova,
+		phys_addr_t physaddr, size_t size, int prot)
+{
+	return -ENODEV;
+}
+
+
+size_t iommu_sva_map_sg(int pasid, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot)
+{
+	return 0;
+}
+
+static inline size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size)
+{
+	return size;
+}
+
+extern void iommu_sva_free_pasid(int pasid) { }
+
+
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_FAULT
-- 
2.16.1
