From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:49 -0600
Subject: [PATCH 05/16] iommu: arm-smmu: Add support for private PASIDs
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-6-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for allocating and populating pagetables
indexed by private PASIDs. Each new PASID is allocated a pagetable
with the same parameters and format as the parent domain.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu.c   | 154 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/io-pgtable.h |  10 ++-
 2 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d459909877c3..5c7c135bbb44 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -201,7 +201,6 @@ struct arm_smmu_device {
 	unsigned long			va_size;
 	unsigned long			ipa_size;
 	unsigned long			pa_size;
-	unsigned long			ubs_size;
 	unsigned long			pgsize_bitmap;
 
 	u32				num_global_irqs;
@@ -252,6 +251,9 @@ struct arm_smmu_domain {
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	u32 attributes;
 	struct iommu_domain		domain;
+
+	spinlock_t			pasid_lock;
+	struct list_head		pasid_list;
 };
 
 struct arm_smmu_option_prop {
@@ -259,6 +261,144 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
+struct arm_smmu_pasid {
+	struct iommu_domain *domain;
+	struct io_pgtable_ops		*pgtbl_ops;
+	struct list_head node;
+	int pasid;
+};
+
+struct arm_smmu_pasid *arm_smmu_get_pasid(struct arm_smmu_domain *smmu_domain,
+		int pasid)
+{
+	struct arm_smmu_pasid *node, *obj = NULL;
+
+	spin_lock(&smmu_domain->pasid_lock);
+	list_for_each_entry(node, &smmu_domain->pasid_list, node) {
+		if (node->pasid == pasid) {
+			obj = node;
+			break;
+		}
+	}
+	spin_unlock(&smmu_domain->pasid_lock);
+
+	return obj;
+}
+
+static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
+		struct io_mm *io_mm, bool unused)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_pasid *node, *obj = NULL;
+
+	spin_lock(&smmu_domain->pasid_lock);
+	list_for_each_entry(node, &smmu_domain->pasid_list, node) {
+		if (node->pasid == io_mm->pasid) {
+			obj = node;
+			list_del(&obj->node);
+			break;
+		}
+	}
+	spin_unlock(&smmu_domain->pasid_lock);
+
+	if (obj)
+		free_io_pgtable_ops(obj->pgtbl_ops);
+
+	kfree(obj);
+}
+
+static size_t arm_smmu_sva_unmap(struct iommu_domain *domain, int pasid,
+		unsigned long iova, size_t size)
+{
+	struct arm_smmu_pasid *obj =
+		arm_smmu_get_pasid(to_smmu_domain(domain), pasid);
+
+	if (!obj)
+		return -ENODEV;
+
+	return obj->pgtbl_ops->unmap(obj->pgtbl_ops, iova, size);
+}
+
+
+static int arm_smmu_sva_map(struct iommu_domain *domain, int pasid,
+		unsigned long iova, phys_addr_t paddr, size_t size, int prot)
+{
+	struct arm_smmu_pasid *obj =
+		arm_smmu_get_pasid(to_smmu_domain(domain), pasid);
+
+	if (!obj)
+		return -ENODEV;
+
+	return obj->pgtbl_ops->map(obj->pgtbl_ops, iova, paddr, size, prot);
+}
+
+static int arm_smmu_mm_attach(struct iommu_domain *domain, struct device *dev,
+		struct io_mm *io_mm, bool unused)
+{
+	struct arm_smmu_pasid *obj;
+	struct io_pgtable_cfg pgtbl_cfg;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	enum io_pgtable_fmt fmt;
+	unsigned long ias, oas;
+
+	/* Only allow private pasids */
+	if (io_mm->type != IO_TYPE_PRIVATE || io_mm->mm)
+		return -ENODEV;
+
+	/* Only allow pasid backed tables to be created on S1 domains */
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -ENODEV;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	/* Get the same exact format as the parent domain */
+	ias = smmu->va_size;
+	oas = smmu->ipa_size;
+
+	if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64)
+		fmt = ARM_64_LPAE_S1;
+	else if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
+		fmt = ARM_32_LPAE_S1;
+		ias = min(ias, 32UL);
+		oas = min(oas, 40UL);
+	} else {
+		fmt = ARM_V7S;
+		ias = min(ias, 32UL);
+		oas = min(oas, 32UL);
+	}
+
+	pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap = smmu->pgsize_bitmap,
+		.ias = ias,
+		.oas = oas,
+		.tlb = NULL,
+		.iommu_dev = smmu->dev
+	};
+
+	obj->pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
+	if (!obj->pgtbl_ops) {
+		kfree(obj);
+		return -ENOMEM;
+	}
+
+	obj->domain = domain;
+	obj->pasid = io_mm->pasid;
+
+	spin_lock(&smmu_domain->pasid_lock);
+	list_add_tail(&obj->node, &smmu_domain->pasid_list);
+	spin_unlock(&smmu_domain->pasid_lock);
+
+	return 0;
+}
+
 static atomic_t cavium_smmu_context_count = ATOMIC_INIT(0);
 
 static bool using_legacy_binding, using_generic_binding;
@@ -268,11 +408,6 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
-static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct arm_smmu_domain, domain);
-}
-
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1055,6 +1190,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
+	spin_lock_init(&smmu_domain->pasid_lock);
+	INIT_LIST_HEAD(&smmu_domain->pasid_list);
+
 	return &smmu_domain->domain;
 }
 
@@ -1694,6 +1832,10 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.mm_attach		= arm_smmu_mm_attach,
+	.sva_map		= arm_smmu_sva_map,
+	.sva_unmap		= arm_smmu_sva_unmap,
+	.mm_detach		= arm_smmu_mm_detach,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index fd9f0fc4eb60..69fcee763446 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -173,18 +173,22 @@ struct io_pgtable {
 
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_flush_all(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
 static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
 		unsigned long iova, size_t size, size_t granule, bool leaf)
 {
-	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf,
+			iop->cookie);
 }
 
 static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_sync(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_sync(iop->cookie);
 }
 
 /**
-- 
2.17.0
