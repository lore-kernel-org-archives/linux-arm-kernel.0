From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 24 Aug 2017 15:42:12 +0800
Subject: [PATCH v2 2/2] iommu/mediatek: Fix a build warning of BIT(32) in ARM
In-Reply-To: <1503560532-24416-1-git-send-email-yong.wu@mediatek.com>
References: <1503560532-24416-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1503560532-24416-2-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit ("iommu/mediatek: Enlarge the validate PA range
for 4GB mode") introduce the following build warning while ARCH=arm:

   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_iova_to_phys':
   include/linux/bitops.h:6:24: warning: left shift count >= width
of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
>> drivers/iommu/mtk_iommu.c:407:9: note: in expansion of macro 'BIT'
      pa |= BIT(32);

  drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_probe':
   include/linux/bitops.h:6:24: warning: left shift count >= width
of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers/iommu/mtk_iommu.c:589:35: note: in expansion of macro 'BIT'
     data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));

Use BIT_ULL instead of BIT.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bc00e40..bd515be 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -404,7 +404,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	if (data->enable_4GB)
-		pa |= BIT(32);
+		pa |= BIT_ULL(32);
 
 	return pa;
 }
@@ -586,7 +586,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
 	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));
+	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
-- 
1.9.1
