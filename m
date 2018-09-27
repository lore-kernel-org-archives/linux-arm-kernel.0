From: robdclark@gmail.com (Rob Clark)
Date: Thu, 27 Sep 2018 18:46:07 -0400
Subject: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
Message-ID: <20180927224609.19515-1-robdclark@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We seem to need to set either this or CFCFG (stall), otherwise gpu
faults trigger problems with other in-flight transactions from the
GPU causing CP errors, etc.

In the ARM SMMU spec, the 'Hit under previous context fault' bit is
described as:

 '0' - Stall or terminate subsequent transactions in the presence
       of an outstanding context fault
 '1' - Process all subsequent transactions independently of any
       outstanding context fault.

Since we don't enable CFCFG (stall) the behavior of terminating
other transactions makes sense.  And is probably not what we want
(and definately not what we want for GPU).

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
So I hit this issue a long time back on 820 (msm8996) and at the
time I solved it with a patch that enabled CFCFG.  And it resurfaced
more recently on sdm845.  But at the time CFCFG was rejected, iirc
because of concern that it would cause problems on other non-qcom
arm smmu implementations.  And I think I forgot to send this version
of the solution.

If enabling HUPCF is anticipated to cause problems on other ARM
SMMU implementations, I think I can come up with a variant of this
patch which conditionally enables it for snapdragon.

Either way, I'd really like to get some variant of this fix merged
(and probably it would be a good idea for stable kernel branches
too), since current behaviour with the GPU means faults turn into
a fantastic cascade of fail.

 drivers/iommu/arm-smmu-regs.h | 1 +
 drivers/iommu/arm-smmu.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..2291925eb800 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -178,6 +178,7 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_SMMU_CB_ATSR		0x8f0
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
+#define SCTLR_HUPCF			(1 << 8)
 #define SCTLR_CFCFG			(1 << 7)
 #define SCTLR_CFIE			(1 << 6)
 #define SCTLR_CFRE			(1 << 5)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..47ffc9aade72 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -713,9 +713,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
 	if (stage1)
 		reg |= SCTLR_S1_ASIDPNE;
+	reg |= SCTLR_HUPCF;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= SCTLR_E;
-
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }
 
-- 
2.17.1
