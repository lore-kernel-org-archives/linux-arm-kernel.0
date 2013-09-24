From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 24 Sep 2013 17:06:56 +0200
Subject: [PATCH 2/7] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu register
 values
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380035221-11576-3-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is derived from smmu resource size. If the resource size
is wrongly specified (e.g. too large) this leads to a miscalculation
and can cause undefined behaviour when context bank registers are
modified.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 97b764b..f5a856e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -207,7 +207,7 @@
 #define CBA2R_RW64_64BIT		(1 << 0)
 
 /* Translation context bank */
-#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
+#define ARM_SMMU_CB_BASE(smmu)		((smmu)->cb_base)
 #define ARM_SMMU_CB(smmu, n)		((n) * (smmu)->pagesize)
 
 #define ARM_SMMU_CB_SCTLR		0x0
@@ -339,6 +339,7 @@ struct arm_smmu_device {
 	struct device_node		*parent_of_node;
 
 	void __iomem			*base;
+	void __iomem			*cb_base;
 	unsigned long			size;
 	unsigned long			pagesize;
 
@@ -1701,7 +1702,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* Check that we ioremapped enough */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
-	size *= (smmu->pagesize << 1);
+	size *= smmu->pagesize;
+	smmu->cb_base = smmu->base + size;
+	size *= 2;
 	if (smmu->size < size)
 		dev_warn(smmu->dev,
 			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
-- 
1.7.9.5
