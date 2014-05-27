From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 27 May 2014 15:27:40 +0900
Subject: [PATCH] bus: brcmstb_gisb: Use devm_ioremap_resource()
Message-ID: <000901cf7974$c27ddf30$47799d90$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_ioremap_resource() because devm_request_and_ioremap() is
obsoleted by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/bus/brcmstb_gisb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 6159b77..f2cd6a2d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -212,9 +212,9 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	mutex_init(&gdev->lock);
 	INIT_LIST_HEAD(&gdev->next);
 
-	gdev->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!gdev->base)
-		return -ENOMEM;
+	gdev->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(gdev->base))
+		return PTR_ERR(gdev->base);
 
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
-- 
1.7.10.4
