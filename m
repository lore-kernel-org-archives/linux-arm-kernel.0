From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Feb 2014 14:42:34 -0600
Subject: [PATCHv3 03/13] iommu/omap: allow enable/disable even without pdata
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Message-ID: <1393620164-14633-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vaussard <florian.vaussard@epfl.ch>

When booting with a devicetree, no platform data is provided.
Do not prematurely exit iommu_enable() and iommu_disable() in
such a case.

Note: As OMAP do not yet has a proper reset controller driver,
IOMMUs requiring a reset signal should use pdata-quirks as a
transitional solution.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 647e4ba..217952b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -146,13 +146,10 @@ static int iommu_enable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata)
-		return -EINVAL;
-
 	if (!arch_iommu)
 		return -ENODEV;
 
-	if (pdata->deassert_reset) {
+	if (pdata && pdata->deassert_reset) {
 		err = pdata->deassert_reset(pdev, pdata->reset_name);
 		if (err) {
 			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
@@ -172,14 +169,11 @@ static void iommu_disable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata)
-		return;
-
 	arch_iommu->disable(obj);
 
 	pm_runtime_put_sync(obj->dev);
 
-	if (pdata->assert_reset)
+	if (pdata && pdata->assert_reset)
 		pdata->assert_reset(pdev, pdata->reset_name);
 }
 
-- 
1.9.0
