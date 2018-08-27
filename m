From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Aug 2018 12:56:24 +0200
Subject: [PATCH] iommu/rockchip: Free irqs in shutdown handler
Message-ID: <20180827105624.5593-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the iommu's shutdown handler we disable runtime-pm which could
result in the irq-handler running unclocked and since commit
    3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
we warn about that fact.

This can cause warnings on shutdown on some Rockchip machines, so
free the irqs in the shutdown handler before we disable runtime-pm.

Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Fixes: 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 258115b10fa9..ad3e2b97469e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1241,6 +1241,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+	int i = 0, irq;
+
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
+		devm_free_irq(iommu->dev, irq, iommu);
+
 	pm_runtime_force_suspend(&pdev->dev);
 }
 
-- 
2.17.0
