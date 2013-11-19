From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 19 Nov 2013 11:33:11 +0200
Subject: [PATCHv5 7/9] iommu/tegra: smmu: allow duplicate ASID wirte
In-Reply-To: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1384853593-32202-8-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device, which belongs to the same ASID, can try to enable the same
ASID as the other swgroup devices. This should be allowed but just
skip the actual register write. If the write value is different, it
will return -EINVAL.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
v4:
This was the part of v3, which isn't used any more.
  [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
---
 drivers/iommu/tegra-smmu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e915201a..c2ed075 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -418,9 +418,13 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
-			val |= mask;
+			if (val) {
+				if (WARN_ON(val != mask))
+					return -EINVAL;
+				goto skip;
+			}
+
+			val = mask;
 			memcpy(c->hwgrp, map, sizeof(u64));
 		} else {
 			WARN_ON((val & mask) == mask);
@@ -430,16 +434,8 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	}
 
 	FLUSH_SMMU_REGS(smmu);
+skip:
 	return 0;
-
-err_hw_busy:
-	for_each_set_bit(i, map, TEGRA_SWGROUP_MAX) {
-		offs = HWGRP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		val &= ~mask;
-		smmu_write(smmu, val, offs);
-	}
-	return -EBUSY;
 }
 
 static int smmu_client_set_hwgrp(struct smmu_client *c,
-- 
1.8.1.5
