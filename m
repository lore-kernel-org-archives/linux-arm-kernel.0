From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 26 Aug 2013 08:20:45 +0800
Subject: [PATCH] pinctrl: spear: Convert to devm_ioremap_resource
Message-ID: <1377476445.9328.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/spear/pinctrl-spear.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 116da04..58bf686 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -367,21 +367,16 @@ int spear_pinctrl_probe(struct platform_device *pdev,
 	if (!machdata)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
 	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
 	if (!pmx) {
 		dev_err(&pdev->dev, "Can't alloc spear_pmx\n");
 		return -ENOMEM;
 	}
 
-	pmx->vbase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!pmx->vbase) {
-		dev_err(&pdev->dev, "Couldn't ioremap at index 0\n");
-		return -ENODEV;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmx->vbase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmx->vbase))
+		return PTR_ERR(pmx->vbase);
 
 	pmx->dev = &pdev->dev;
 	pmx->machdata = machdata;
-- 
1.8.1.2
