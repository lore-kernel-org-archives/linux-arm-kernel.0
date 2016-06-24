From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 24 Jun 2016 10:13:28 +0800
Subject: [PATCH v5 3/8] iommu/rockchip: Fix allocation of bases array in
 driver probe
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1466734413-7453-4-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In .probe(), devm_kzalloc() is called with size == 0 and works only
by luck, due to internal behavior of the allocator and the fact
that the proper allocation size is small. Let's use proper value for
calculating the size.

Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 53fa0d9..8a5bac7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1034,6 +1034,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rk_iommu *iommu;
 	struct resource *res;
+	int num_res = pdev->num_resources;
 	int i;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
@@ -1043,12 +1044,13 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
-	iommu->bases = devm_kzalloc(dev, sizeof(*iommu->bases) * iommu->num_mmu,
+
+	iommu->bases = devm_kzalloc(dev, sizeof(*iommu->bases) * num_res,
 				    GFP_KERNEL);
 	if (!iommu->bases)
 		return -ENOMEM;
 
-	for (i = 0; i < pdev->num_resources; i++) {
+	for (i = 0; i < num_res; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res)
 			continue;
-- 
1.9.1
