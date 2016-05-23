From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 May 2016 11:30:07 +0200
Subject: [PATCH 1/3] iommu/exynos: Return proper errors from getting clocks
In-Reply-To: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1463995809-26862-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks driver probe code to propagate error codes from
clk_get() operation. This will allow to properly handle deferred probe
in the future.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 56 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e27e3b7df4e7..989365682d14 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -602,37 +602,31 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->clk = devm_clk_get(dev, "sysmmu");
-	if (!IS_ERR(data->clk)) {
-		ret = clk_prepare(data->clk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare clk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->clk) == -ENOENT)
 		data->clk = NULL;
-	}
+	else if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+	ret = clk_prepare(data->clk);
+	if (ret)
+		return ret;
 
 	data->aclk = devm_clk_get(dev, "aclk");
-	if (!IS_ERR(data->aclk)) {
-		ret = clk_prepare(data->aclk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare aclk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->aclk) == -ENOENT)
 		data->aclk = NULL;
-	}
+	else if (IS_ERR(data->aclk))
+		return PTR_ERR(data->aclk);
+	ret = clk_prepare(data->aclk);
+	if (ret)
+		return ret;
 
 	data->pclk = devm_clk_get(dev, "pclk");
-	if (!IS_ERR(data->pclk)) {
-		ret = clk_prepare(data->pclk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare pclk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->pclk) == -ENOENT)
 		data->pclk = NULL;
-	}
+	else if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
+	ret = clk_prepare(data->pclk);
+	if (ret)
+		return ret;
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
@@ -640,15 +634,13 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
-	if (!IS_ERR(data->clk_master)) {
-		ret = clk_prepare(data->clk_master);
-		if (ret) {
-			dev_err(dev, "Failed to prepare master's clk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->clk_master) == -ENOENT)
 		data->clk_master = NULL;
-	}
+	else if (IS_ERR(data->clk_master))
+		return PTR_ERR(data->clk_master);
+	ret = clk_prepare(data->clk_master);
+	if (ret)
+		return ret;
 
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
-- 
1.9.2
