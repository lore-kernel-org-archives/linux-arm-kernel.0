From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  7 Nov 2016 18:25:09 +0000
Subject: [PATCH v2] iommu/arm-smmu: Fix out-of-bounds dereference
Message-ID: <3e31e04e167e2b12fc814c22a0b6902bd4f926f2.1478543109.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we iterate a master's config entries, what we generally care
about is the entry's stream map index, rather than the entry index
itself, so it's nice to have the iterator automatically assign the
former from the latter. Unfortunately, booting with KASAN reveals
the oversight that using a simple comma operator results in the
entry index being dereferenced before being checked for validity,
so we always access one element past the end of the fwspec array.

Flip things around so that the check always happens before the index
may be dereferenced.

Fixes: adfec2e709d2 ("iommu/arm-smmu: Convert to iommu_fwspec")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f86683eec446..786d33900382 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -324,8 +324,10 @@ struct arm_smmu_master_cfg {
 #define INVALID_SMENDX			-1
 #define __fwspec_cfg(fw) ((struct arm_smmu_master_cfg *)fw->iommu_priv)
 #define fwspec_smmu(fw)  (__fwspec_cfg(fw)->smmu)
+#define fwspec_smendx(fw, i) \
+	(i >= fw->num_ids ? INVALID_SMENDX : __fwspec_cfg(fw)->smendx[i])
 #define for_each_cfg_sme(fw, i, idx) \
-	for (i = 0; idx = __fwspec_cfg(fw)->smendx[i], i < fw->num_ids; ++i)
+	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
 
 struct arm_smmu_device {
 	struct device			*dev;
-- 
2.10.2.dirty
