From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:00 +0800
Subject: [PATCH v3 07/13] iommu/arm: Split arm_smmu_tlb_sync to reuse code
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-8-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TLB sync wait is a common operation, should be shared by all SMMUs.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-base.c | 15 +++++++++++++++
 drivers/iommu/arm-smmu.c      | 23 ++++++++++++-----------
 drivers/iommu/arm-smmu.h      |  3 +++
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index 4d1c511..53f7907 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -187,6 +187,21 @@ void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }

+void arm_smmu_tlb_sync_wait(struct arm_smmu_device *smmu)
+{
+	int count = 0;
+
+	while (!smmu->hwdep_ops->tlb_sync_finished(smmu)) {
+		cpu_relax();
+		if (++count == TLB_LOOP_TIMEOUT) {
+			dev_err_ratelimited(smmu->dev,
+			"TLB sync timed out -- SMMU may be deadlocked\n");
+			return;
+		}
+		udelay(1);
+	}
+}
+
 void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 				   size_t size)
 {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d2fc14c..fa65c7c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -223,23 +223,23 @@

 #define FSYNR0_WNR			(1 << 4)

+static int arm_smmu_tlb_sync_finished(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
+
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS);
+
+	return !(reg & sTLBGSTATUS_GSACTIVE);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
-	int count = 0;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);

 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
-	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
-	       & sTLBGSTATUS_GSACTIVE) {
-		cpu_relax();
-		if (++count == TLB_LOOP_TIMEOUT) {
-			dev_err_ratelimited(smmu->dev,
-			"TLB sync timed out -- SMMU may be deadlocked\n");
-			return;
-		}
-		udelay(1);
-	}
+	arm_smmu_tlb_sync_wait(smmu);
 }

 static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
@@ -869,6 +869,7 @@ static int arm_smmu_device_unload(struct arm_smmu_device *smmu)
 }

 static struct smmu_hwdep_ops arm_smmu_hwdep_ops = {
+	.tlb_sync_finished	= arm_smmu_tlb_sync_finished,
 	.tlb_inv_context	= arm_smmu_tlb_inv_context,
 	.context_fault		= arm_smmu_context_fault,
 	.global_fault		= arm_smmu_global_fault,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 190f77c..8332ff0 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -209,6 +209,7 @@ struct arm_smmu_domain {

 /**
  * struct smmu_hwdep_ops - smmu hardware dependent ops
+ * @tlb_sync_finished: check whether tlb sync operation is finished
  * @tlb_inv_context: invalid smmu context bank tlb
  * @context_fault: context fault handler
  * @global_fault: global fault handler
@@ -221,6 +222,7 @@ struct arm_smmu_domain {
  * @device_remove: turn off a smmu and reclaim associated resources
  */
 struct smmu_hwdep_ops {
+	int (*tlb_sync_finished)(struct arm_smmu_device *smmu);
 	void (*tlb_inv_context)(struct arm_smmu_cfg *cfg);
 	irqreturn_t (*context_fault)(int irq, void *dev);
 	irqreturn_t (*global_fault)(int irq, void *dev);
@@ -237,6 +239,7 @@ struct smmu_hwdep_ops {

 extern int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end);
 extern void __arm_smmu_free_bitmap(unsigned long *map, int idx);
+extern void arm_smmu_tlb_sync_wait(struct arm_smmu_device *smmu);
 extern struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu);
 extern void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 				   size_t size);
--
1.8.0
