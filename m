From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:01 +0800
Subject: [PATCH v3 08/13] iommu/arm: Add hook alloc_context
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-9-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some SMMUs(like hisi-smmu and SMMUv3), a given StreamID is bound to a fixed
context bank.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 8 +++++---
 drivers/iommu/arm-smmu.c      | 8 ++++++++
 drivers/iommu/arm-smmu.h      | 3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 53f7907..be73eba 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -231,6 +231,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	struct arm_smmu_device *smmu, *parent;
+	struct arm_smmu_master *master;

 	/*
 	 * Walk the SMMU chain to find the root device for this chain.
@@ -245,7 +246,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
 	} while ((parent = find_parent_smmu(smmu)));

-	if (!find_smmu_master(smmu, dev->of_node)) {
+	master = find_smmu_master(smmu, dev->of_node);
+	if (!master) {
 		dev_err(dev, "unable to find root SMMU for device\n");
 		return -ENODEV;
 	}
@@ -265,8 +267,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		start = smmu->num_s2_context_banks;
 	}

-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
+	ret = smmu->hwdep_ops->alloc_context(smmu, start,
+					smmu->num_context_banks, master);
 	if (IS_ERR_VALUE(ret))
 		return ret;

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fa65c7c..dbd9c60 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -223,6 +223,13 @@

 #define FSYNR0_WNR			(1 << 4)

+
+static int arm_smmu_alloc_context(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master)
+{
+	return __arm_smmu_alloc_bitmap(smmu->context_map, start, end);
+}
+
 static int arm_smmu_tlb_sync_finished(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -869,6 +876,7 @@ static int arm_smmu_device_unload(struct arm_smmu_device *smmu)
 }

 static struct smmu_hwdep_ops arm_smmu_hwdep_ops = {
+	.alloc_context		= arm_smmu_alloc_context,
 	.tlb_sync_finished	= arm_smmu_tlb_sync_finished,
 	.tlb_inv_context	= arm_smmu_tlb_inv_context,
 	.context_fault		= arm_smmu_context_fault,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 8332ff0..f7346d89 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -209,6 +209,7 @@ struct arm_smmu_domain {

 /**
  * struct smmu_hwdep_ops - smmu hardware dependent ops
+ * @alloc_context: alloc a free context bank
  * @tlb_sync_finished: check whether tlb sync operation is finished
  * @tlb_inv_context: invalid smmu context bank tlb
  * @context_fault: context fault handler
@@ -222,6 +223,8 @@ struct arm_smmu_domain {
  * @device_remove: turn off a smmu and reclaim associated resources
  */
 struct smmu_hwdep_ops {
+	int (*alloc_context)(struct arm_smmu_device *smmu,
+			int start, int end, struct arm_smmu_master *master);
 	int (*tlb_sync_finished)(struct arm_smmu_device *smmu);
 	void (*tlb_inv_context)(struct arm_smmu_cfg *cfg);
 	irqreturn_t (*context_fault)(int irq, void *dev);
--
1.8.0
