From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:21 +0300
Subject: [PATCH 18/23] iommu/tegra: smmu: Workaround PCIe IOMMU'able
Message-ID: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make PCIe work as it is. IOMMU support can be implemented later.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 64da08a..6e82df3 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -402,6 +402,9 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 
 	for_each_set_bit(i, (unsigned long *)&map,
 			 sizeof(map) * BITS_PER_BYTE) {
+		if (i == SWGID_AFI) /* FIXME: IOMMU'able PCIe */
+			continue;
+
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-- 
1.8.1.5
