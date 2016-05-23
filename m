From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 May 2016 13:01:27 +0200
Subject: [PATCH 4/3] iommu/exynos: Prepare for deferred probe support
In-Reply-To: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1464001287-12748-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register iommu_ops at the end of successful probe instead of doing that
unconditionally. This makes Exynos IOMMU driver ready for deferred probe
caused by not-yet-available clocks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
I'm sorry for the confussing patch number. This patch got lost while
rebasing, but it should belong to the "Exynos IOMMU: improve clock
management" patchset.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/iommu/exynos-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e0b834375f17..633e6d023c0d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -581,6 +581,8 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
+static struct iommu_ops exynos_iommu_ops;
+
 static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -654,6 +656,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
+
 	return 0;
 }
 
@@ -1347,7 +1351,6 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
-	of_iommu_set_ops(np, &exynos_iommu_ops);
 	return 0;
 }
 
-- 
1.9.2
