From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:15 -0700
Subject: [PATCH 05/14] iommu: arm-smmu: Add pasid implementation
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-6-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for allocating and populating pagetables
indexed by pasid. Each new pasid is allocated a pagetable
with the same parameters and format as the parent domain.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 148 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ebfa59b59622..42f5bfa3e26e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -250,6 +250,9 @@ struct arm_smmu_domain {
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	u32 attributes;
 	struct iommu_domain		domain;
+
+	spinlock_t			pasid_lock;
+	struct list_head		pasid_list;
 };
 
 struct arm_smmu_option_prop {
@@ -257,6 +260,139 @@ struct arm_smmu_option_prop {
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
+static void arm_smmu_pasid_free(struct iommu_domain *domain, int pasid)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_pasid *node, *obj = NULL;
+
+	spin_lock(&smmu_domain->pasid_lock);
+	list_for_each_entry(node, &smmu_domain->pasid_list, node) {
+		if (node->pasid == pasid) {
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
+static int arm_smmu_pasid_alloc(struct iommu_domain *domain, struct device *dev,
+		int pasid)
+{
+	struct arm_smmu_pasid *obj;
+	struct io_pgtable_cfg pgtbl_cfg;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	enum io_pgtable_fmt fmt;
+	unsigned long ias, oas;
+
+	/* Only allow pasid backed tables to be created on S1 domains */
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
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
+	obj->pasid = pasid;
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
@@ -266,11 +402,6 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
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
@@ -961,6 +1092,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
+	spin_lock_init(&smmu_domain->pasid_lock);
+	INIT_LIST_HEAD(&smmu_domain->pasid_list);
+
 	return &smmu_domain->domain;
 }
 
@@ -1588,6 +1722,10 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.pasid_alloc		= arm_smmu_pasid_alloc,
+	.sva_map		= arm_smmu_sva_map,
+	.sva_unmap		= arm_smmu_sva_unmap,
+	.pasid_free		= arm_smmu_pasid_free,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.16.1
