From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:48 -0600
Subject: [PATCH 04/16] iommu: sva: Add support for private PASIDs
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-5-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some older SMMU implementations that do not have a fully featured
hardware PASID features have alternate workarounds for using multiple
pagetables. For example, MSM GPUs have logic to automatically switch the
user pagetable from hardware by writing the context bank directly.

Support private PASIDs by creating a new io-pgtable instance map it
to a PASID and provide the APIs for drivers to populate it manually.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/iommu-sva.c | 139 ++++++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu.c     |  66 +++++++++++++-----
 include/linux/iommu.h     |  74 ++++++++++++++++++--
 3 files changed, 250 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index e98b994c15f1..26f0da9692d4 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -156,6 +156,7 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	mmgrab(mm);
 
 	io_mm->flags		= flags;
+	io_mm->type		= IO_TYPE_SHARED;
 	io_mm->mm		= mm;
 	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
@@ -544,13 +545,10 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
 			  unsigned int max_pasid,
 			  iommu_mm_exit_handler_t mm_exit)
 {
-	int ret;
+	int ret = 0;
 	struct iommu_sva_param *param;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (!domain || !domain->ops->sva_device_init)
-		return -ENODEV;
-
 	if (features & ~IOMMU_SVA_FEAT_IOPF)
 		return -EINVAL;
 
@@ -576,9 +574,12 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
 	 * IOMMU driver updates the limits depending on the IOMMU and device
 	 * capabilities.
 	 */
-	ret = domain->ops->sva_device_init(dev, param);
-	if (ret)
-		goto err_free_param;
+
+	if (domain && domain->ops->sva_device_init) {
+		ret = domain->ops->sva_device_init(dev, param);
+		if (ret)
+			goto err_free_param;
+	}
 
 	mutex_lock(&dev->iommu_param->lock);
 	if (dev->iommu_param->sva_param)
@@ -790,3 +791,127 @@ struct mm_struct *iommu_sva_find(int pasid)
 	return mm;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+int iommu_sva_alloc_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	int ret, pasid;
+	struct io_mm *io_mm;
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
+		return -ENODEV;
+
+	if (domain->ops->mm_alloc)
+		io_mm = domain->ops->mm_alloc(domain, NULL, 0);
+	else
+		io_mm = kzalloc(sizeof(*io_mm), GFP_KERNEL);
+
+	if (IS_ERR(io_mm))
+		return PTR_ERR(io_mm);
+	if (!io_mm)
+		return -ENOMEM;
+
+	io_mm->domain = domain;
+	io_mm->type = IO_TYPE_PRIVATE;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_sva_lock);
+	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, param->min_pasid,
+		param->max_pasid + 1, GFP_ATOMIC);
+	io_mm->pasid = pasid;
+	spin_unlock(&iommu_sva_lock);
+	idr_preload_end();
+
+	if (pasid < 0) {
+		kfree(io_mm);
+		return pasid;
+	}
+
+	ret = domain->ops->mm_attach(domain, dev, io_mm, false);
+	if (!ret)
+		return pasid;
+
+	spin_lock(&iommu_sva_lock);
+	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	spin_unlock(&iommu_sva_lock);
+
+	if (domain->ops->mm_free)
+		domain->ops->mm_free(io_mm);
+	else
+		kfree(io_mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+static struct io_mm *get_io_mm(int pasid)
+{
+	struct io_mm *io_mm;
+
+	spin_lock(&iommu_sva_lock);
+	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	spin_unlock(&iommu_sva_lock);
+
+	return io_mm;
+}
+
+int iommu_sva_map(int pasid, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	struct io_mm *io_mm = get_io_mm(pasid);
+
+	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
+		return -ENODEV;
+
+	return __iommu_map(io_mm->domain, &pasid, iova, paddr, size, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map);
+
+size_t iommu_sva_map_sg(int pasid, unsigned long iova, struct scatterlist *sg,
+		unsigned int nents, int prot)
+{
+	struct io_mm *io_mm = get_io_mm(pasid);
+	struct iommu_domain *domain;
+
+	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
+		return -ENODEV;
+
+	domain = io_mm->domain;
+
+	return domain->ops->map_sg(domain, &pasid, iova, sg, nents, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map_sg);
+
+size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size)
+{
+	struct io_mm *io_mm = get_io_mm(pasid);
+
+	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
+		return -ENODEV;
+
+	return __iommu_unmap(io_mm->domain, &pasid, iova, size, false);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap);
+
+void iommu_sva_free_pasid(int pasid, struct device *dev)
+{
+	struct io_mm *io_mm = get_io_mm(pasid);
+	struct iommu_domain *domain;
+
+	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
+		return;
+
+	domain = io_mm->domain;
+
+	domain->ops->mm_detach(domain, dev, io_mm, false);
+
+	spin_lock(&iommu_sva_lock);
+	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	spin_unlock(&iommu_sva_lock);
+
+	if (domain->ops->mm_free)
+		domain->ops->mm_free(io_mm);
+	else
+		kfree(io_mm);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13f705df0725..0ba3d27f2300 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1792,7 +1792,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
+int __iommu_map(struct iommu_domain *domain, int *pasid, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
 	unsigned long orig_iova = iova;
@@ -1801,10 +1801,17 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL ||
-		     domain->pgsize_bitmap == 0UL))
+	if (unlikely(domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
+	if (pasid) {
+		if (unlikely(domain->ops->sva_map == NULL))
+			return -ENODEV;
+	} else {
+		if (unlikely(domain->ops->map == NULL))
+			return -ENODEV;
+	}
+
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
@@ -1830,7 +1837,13 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		if (pasid)
+			ret = domain->ops->sva_map(domain, *pasid, iova, paddr,
+				pgsize, prot);
+		else
+			ret = domain->ops->map(domain, iova, paddr, pgsize,
+				prot);
+
 		if (ret)
 			break;
 
@@ -1841,16 +1854,23 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	/* unroll mapping in case something went wrong */
 	if (ret)
-		iommu_unmap(domain, orig_iova, orig_size - size);
+		__iommu_unmap(domain, pasid, orig_iova, orig_size - size,
+			pasid ? false : true);
 	else
 		trace_map(orig_iova, orig_paddr, orig_size);
 
 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, NULL, iova, paddr, size, prot);
+}
 EXPORT_SYMBOL_GPL(iommu_map);
 
-static size_t __iommu_unmap(struct iommu_domain *domain,
-			    unsigned long iova, size_t size,
+size_t __iommu_unmap(struct iommu_domain *domain,
+			    int *pasid, unsigned long iova, size_t size,
 			    bool sync)
 {
 	const struct iommu_ops *ops = domain->ops;
@@ -1858,9 +1878,16 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(ops->unmap == NULL ||
-		     domain->pgsize_bitmap == 0UL))
-		return 0;
+	if (unlikely(domain->pgsize_bitmap == 0UL))
+		return -0;
+
+	if (pasid) {
+		if (unlikely(domain->ops->sva_unmap == NULL))
+			return 0;
+	} else {
+		if (unlikely(domain->ops->unmap == NULL))
+			return 0;
+	}
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return 0;
@@ -1888,7 +1915,12 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	while (unmapped < size) {
 		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
 
-		unmapped_page = ops->unmap(domain, iova, pgsize);
+		if (pasid)
+			unmapped_page = ops->sva_unmap(domain, *pasid, iova,
+				pgsize);
+		else
+			unmapped_page = ops->unmap(domain, iova, pgsize);
+
 		if (!unmapped_page)
 			break;
 
@@ -1912,19 +1944,20 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 size_t iommu_unmap(struct iommu_domain *domain,
 		   unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, true);
+	return __iommu_unmap(domain, NULL, iova, size, true);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
 size_t iommu_unmap_fast(struct iommu_domain *domain,
 			unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, false);
+	return __iommu_unmap(domain, NULL, iova, size, false);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot)
+size_t default_iommu_map_sg(struct iommu_domain *domain, int *pasid,
+			 unsigned long iova, struct scatterlist *sg,
+			 unsigned int nents, int prot)
 {
 	struct scatterlist *s;
 	size_t mapped = 0;
@@ -1948,7 +1981,8 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		if (!IS_ALIGNED(s->offset, min_pagesz))
 			goto out_err;
 
-		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		ret = __iommu_map(domain, pasid, iova + mapped, phys, s->length,
+			prot);
 		if (ret)
 			goto out_err;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 366254e4b07f..3d72d636c13d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -108,7 +108,13 @@ struct iommu_domain {
 	struct list_head mm_list;
 };
 
+enum iommu_io_type {
+	IO_TYPE_SHARED,
+	IO_TYPE_PRIVATE,
+};
+
 struct io_mm {
+	enum iommu_io_type	type;
 	int			pasid;
 	/* IOMMU_SVA_FEAT_* */
 	unsigned long		flags;
@@ -123,6 +129,9 @@ struct io_mm {
 	void (*release)(struct io_mm *io_mm);
 	/* For postponed release */
 	struct rcu_head		rcu;
+
+	/* This is used by private entries */
+	struct iommu_domain *domain;
 };
 
 enum iommu_cap {
@@ -315,8 +324,9 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
-	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot);
+	size_t (*map_sg)(struct iommu_domain *domain, int *pasid,
+			 unsigned long iova, struct scatterlist *sg,
+			 unsigned int nents, int prot);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
@@ -358,6 +368,12 @@ struct iommu_ops {
 		struct device *dev, struct tlb_invalidate_info *inv_info);
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 
+	int (*sva_map)(struct iommu_domain *domain, int pasid,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
+	size_t (*sva_unmap)(struct iommu_domain *domain, int pasid,
+			    unsigned long iova, size_t size);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -548,9 +564,9 @@ extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
-extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-				struct scatterlist *sg,unsigned int nents,
-				int prot);
+extern size_t default_iommu_map_sg(struct iommu_domain *domain, int *pasid,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -636,7 +652,7 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return domain->ops->map_sg(domain, iova, sg, nents, prot);
+	return domain->ops->map_sg(domain, NULL, iova, sg, nents, prot);
 }
 
 /* PCI device grouping function */
@@ -676,6 +692,14 @@ extern int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 				int *pasid, unsigned long flags, void *drvdata);
 extern int iommu_sva_unbind_device(struct device *dev, int pasid);
 
+/* Common map and unmap functions */
+extern int __iommu_map(struct iommu_domain *domain, int *pasid,
+		unsigned long iova, phys_addr_t paddr, size_t size, int prot);
+
+extern size_t __iommu_unmap(struct iommu_domain *domain,
+			    int *pasid, unsigned long iova, size_t size,
+			    bool sync);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1027,6 +1051,16 @@ extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void __iommu_sva_unbind_dev_all(struct device *dev);
 
 extern struct mm_struct *iommu_sva_find(int pasid);
+
+extern int iommu_sva_alloc_pasid(struct iommu_domain *domain,
+		struct device *dev);
+extern int iommu_sva_map(int pasid, unsigned long iova, phys_addr_t physaddr,
+		size_t size, int prot);
+extern size_t iommu_sva_map_sg(int pasid, unsigned long iova,
+		struct scatterlist *sg, unsigned int nents, int prot);
+extern size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size);
+extern void iommu_sva_free_pasid(int pasid, struct device *dev);
+
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -1061,6 +1095,34 @@ static inline struct mm_struct *iommu_sva_find(int pasid)
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
+static inline size_t iommu_sva_map_sg(int pasid, unsigned long iova,
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
+static inline void iommu_sva_free_pasid(int pasid, struct device *dev) { }
+
+
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_PAGE_FAULT
-- 
2.17.0
