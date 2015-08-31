From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Mon, 31 Aug 2015 13:14:33 +0800
Subject: [PATCH] drm/fsl-dcu: Cleanup vblank interrupt mask and status setting
 code
Message-ID: <1440998073-31851-1-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch update interrupt mask bit with regmap_update_bits, and clear
interrupt status by writing 1 to relevant bit before setting mask in
fsl_dcu_drm_irq_init function.

Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 9a8e2da..bf36971 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -38,21 +38,17 @@ static const struct regmap_config fsl_dcu_regmap_config = {
 static int fsl_dcu_drm_irq_init(struct drm_device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
-	unsigned int value;
 	int ret;
 
 	ret = drm_irq_install(dev, fsl_dev->irq);
 	if (ret < 0)
 		dev_err(dev->dev, "failed to install IRQ handler\n");
 
-	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0);
+	ret = regmap_write(fsl_dev->regmap, DCU_INT_STATUS, 0xffffffff);
 	if (ret)
 		dev_err(dev->dev, "set DCU_INT_STATUS failed\n");
-	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
-	if (ret)
-		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
-	value &= DCU_INT_MASK_VBLANK;
-	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_INT_MASK,
+				 DCU_INT_MASK_VBLANK, ~DCU_INT_MASK_VBLANK);
 	if (ret)
 		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
 	ret = regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
@@ -143,14 +139,10 @@ static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
 static int fsl_dcu_drm_enable_vblank(struct drm_device *dev, int crtc)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
-	unsigned int value;
 	int ret;
 
-	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
-	if (ret)
-		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
-	value &= ~DCU_INT_MASK_VBLANK;
-	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_INT_MASK,
+				 DCU_INT_MASK_VBLANK, ~DCU_INT_MASK_VBLANK);
 	if (ret)
 		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
 	return 0;
@@ -159,14 +151,10 @@ static int fsl_dcu_drm_enable_vblank(struct drm_device *dev, int crtc)
 static void fsl_dcu_drm_disable_vblank(struct drm_device *dev, int crtc)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
-	unsigned int value;
 	int ret;
 
-	ret = regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
-	if (ret)
-		dev_err(dev->dev, "read DCU_INT_MASK failed\n");
-	value |= DCU_INT_MASK_VBLANK;
-	ret = regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+	ret = regmap_update_bits(fsl_dev->regmap, DCU_INT_MASK,
+				 DCU_INT_MASK_VBLANK, DCU_INT_MASK_VBLANK);
 	if (ret)
 		dev_err(dev->dev, "set DCU_INT_MASK failed\n");
 }
-- 
2.1.0.27.g96db324
