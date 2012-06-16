From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Fri, 15 Jun 2012 20:55:59 -0500
Subject: [PATCH 1/6] ARM: OMAP: iommu: fix including iommu.h without IOMMU_API
 selected
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1339811764-5337-2-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If included without IOMMU_API being selected it will break
compilation:

arch/arm/plat-omap/include/plat/iommu.h:
	In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:148:
	error: 'struct dev_archdata' has no member named 'iommu'

This will be seen, when hwmod includes iommu.h to get the
structure for attributes.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 88be3e6..e58d571 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -126,6 +126,7 @@ struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
 };
 
+#ifdef CONFIG_IOMMU_API
 /**
  * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
  * @dev: iommu client device
@@ -136,6 +137,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 
 	return arch_data->iommu_dev;
 }
+#endif
 
 /* IOMMU errors */
 #define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
-- 
1.7.4.1
