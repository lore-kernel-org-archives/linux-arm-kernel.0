From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 May 2016 11:30:08 +0200
Subject: [PATCH 2/3] iommu/exynos: Fix master clock management for inactive
 SYSMMU
In-Reply-To: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1463995809-26862-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If SYSMMU controller is not active, there is no point in enabling master's
clock just for doing the the of internal state. This patch moves enabling
that clock to the block which actually does the register access.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 989365682d14..018bcd5d5edc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -524,16 +524,15 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 {
 	unsigned long flags;
 
-	clk_enable(data->clk_master);
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data)) {
-		if (data->version >= MAKE_MMU_VER(3, 3))
-			__sysmmu_tlb_invalidate_entry(data, iova, 1);
+	if (is_sysmmu_active(data) && data->version >= MAKE_MMU_VER(3, 3)) {
+		clk_enable(data->clk_master);
+		__sysmmu_tlb_invalidate_entry(data, iova, 1);
+		clk_disable(data->clk_master);
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	clk_disable(data->clk_master);
 }
 
 static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
-- 
1.9.2
