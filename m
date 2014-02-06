From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 18:09:33 +0000
Subject: [PATCH 5/5] iommu/arm-smmu: fix compilation issue when
 !CONFIG_ARM_AMBA
In-Reply-To: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391710173-4343-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If !CONFIG_ARM_AMBA, we shouldn't try to register ourselves with the
amba_bustype.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0ae4dd39197f..6fe7922ecc1d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2004,8 +2004,10 @@ static int __init arm_smmu_init(void)
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
 
+#ifdef CONFIG_ARM_AMBA
 	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
 
 	return 0;
 }
-- 
1.8.2.2
