From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Feb 2016 15:14:44 +0100
Subject: [PATCH] ARM64: dma-mapping: fix handling of devices registered before
 arch_initcall
Message-ID: <1455632084-14666-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures that devices, which got registered before arch_initcall
will be handled correctly by IOMMU-based DMA-mapping code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/mm/dma-mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 573b1e6..ce6019f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -928,6 +928,10 @@ static int __init __iommu_dma_init(void)
 		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
 	if (!ret)
 		ret = register_iommu_dma_ops_notifier(&amba_bustype);
+
+	/* handle devices queued before this arch_initcall */
+	if (!ret)
+		__iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);
 	return ret;
 }
 arch_initcall(__iommu_dma_init);
-- 
1.9.2
