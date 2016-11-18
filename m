From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 18 Nov 2016 11:06:10 +0100
Subject: [Resend PATCH] drm/mediatek: fix null pointer dereference
Message-ID: <13893536-4b1f-4ff9-c265-971f08623ea5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe function requests the interrupt before initializing
the ddp component. Which leads to a null pointer dereference at boot.
Fix this by requesting the interrput after all components got
initialized properly.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC
MT8173.")
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c 
b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 019b7ca..1e78159 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -250,13 +250,6 @@ static int mtk_disp_ovl_probe(struct 
platform_device *pdev)
  	if (irq < 0)
  		return irq;

-	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
-			       IRQF_TRIGGER_NONE, dev_name(dev), priv);
-	if (ret < 0) {
-		dev_err(dev, "Failed to request irq %d: %d\n", irq, ret);
-		return ret;
-	}
-
  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_OVL);
  	if (comp_id < 0) {
  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
@@ -272,6 +265,13 @@ static int mtk_disp_ovl_probe(struct 
platform_device *pdev)

  	platform_set_drvdata(pdev, priv);

+	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
+			       IRQF_TRIGGER_NONE, dev_name(dev), priv);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request irq %d: %d\n", irq, ret);
+		return ret;
+	}
+
  	ret = component_add(dev, &mtk_disp_ovl_component_ops);
  	if (ret)
  		dev_err(dev, "Failed to add component: %d\n", ret);
-- 
2.10.1
