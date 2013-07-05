From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:54 +0300
Subject: [PATCH v2 19/22] iommu/tegra: smmu: Workaround PCIe IOMMU'able
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-20-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make PCIe work as it is. IOMMU support can be implemented later. We
need the same kind of registration framework for PCIe as platform_bus
does currently.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 33fb7eb..ac5d661 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -330,6 +330,9 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 
 	for_each_set_bit(i, (unsigned long *)&map,
 			 sizeof(map) * BITS_PER_BYTE) {
+		if (i == TEGRA_SWGROUP_AFI) /* FIXME: IOMMU'able PCIe */
+			continue;
+
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-- 
1.7.9.5
