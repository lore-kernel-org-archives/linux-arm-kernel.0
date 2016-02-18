From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Feb 2016 15:12:54 +0100
Subject: [PATCH v2 07/13] iommu: exynos: refactor init config code
In-Reply-To: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1455804780-9616-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rewrites sysmmu_init_config function to make it easier to read
and understand.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 3a577a473f3c..15787a177a16 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -383,24 +383,17 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 
 static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 {
-	unsigned int cfg = CFG_LRU | CFG_QOS(15);
-	unsigned int ver;
-
-	ver = MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
-	if (MMU_MAJ_VER(ver) == 3) {
-		if (MMU_MIN_VER(ver) >= 2) {
-			cfg |= CFG_FLPDCACHE;
-			if (MMU_MIN_VER(ver) == 3) {
-				cfg |= CFG_ACGEN;
-				cfg &= ~CFG_LRU;
-			} else {
-				cfg |= CFG_SYSSEL;
-			}
-		}
-	}
+	unsigned int cfg;
+
+	data->version = MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
+	if (data->version <= MAKE_MMU_VER(3, 1))
+		cfg = CFG_LRU | CFG_QOS(15);
+	else if (data->version <= MAKE_MMU_VER(3, 2))
+		cfg = CFG_LRU | CFG_QOS(15) | CFG_FLPDCACHE | CFG_SYSSEL;
+	else
+		cfg = CFG_QOS(15) | CFG_FLPDCACHE | CFG_ACGEN;
 
 	__raw_writel(cfg, data->sfrbase + REG_MMU_CFG);
-	data->version = ver;
 }
 
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
-- 
1.9.2
