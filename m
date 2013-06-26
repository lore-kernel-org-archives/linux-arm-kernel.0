From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:20 +0300
Subject: [PATCH 17/23] iommu/tegra: smmu: Use swgroups instead of pdata
Message-ID: <1372238906-9346-18-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using platfrom data, DT passes "nvidia,swgroups".

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c67131e..64da08a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -265,7 +265,7 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			hwgrp;
+	u64			hwgrp;
 };
 
 /*
@@ -384,10 +384,10 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
+#define smmu_client_hwgrp(c)	(c->as->smmu->swgroups)
 
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
-				   unsigned long map, int on)
+				   u64 map, int on)
 {
 	int i;
 	struct smmu_as *as = c->as;
@@ -400,12 +400,11 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	if (!on)
 		map = smmu_client_hwgrp(c);
 
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
+	for_each_set_bit(i, (unsigned long *)&map,
+			 sizeof(map) * BITS_PER_BYTE) {
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
 			val |= mask;
 		} else {
 			WARN_ON((val & mask) == mask);
@@ -416,15 +415,6 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	FLUSH_SMMU_REGS(smmu);
 	c->hwgrp = map;
 	return 0;
-
-err_hw_busy:
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		val &= ~mask;
-		smmu_write(smmu, val, offs);
-	}
-	return -EBUSY;
 }
 
 static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
@@ -796,7 +786,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	struct smmu_as *as = domain->priv;
 	struct smmu_device *smmu = as->smmu;
 	struct smmu_client *client, *c;
-	u32 map;
+	u64 map;
 	int err;
 
 	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
@@ -804,7 +794,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = (unsigned long)dev->platform_data;
+	map = smmu->swgroups;
 	if (!map)
 		return -EINVAL;
 
-- 
1.8.1.5
