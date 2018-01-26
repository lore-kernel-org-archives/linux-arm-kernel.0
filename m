From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Jan 2018 14:20:30 +0100
Subject: [PATCH 1/4] drm/pl111: Error handling for CMA framebuffer
Message-ID: <20180126132033.19744-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When attaching the CMA framebuffer we need to check for
returned error pointers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 101a9c7db6ff..31a0c4268cc6 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -141,6 +141,11 @@ static int pl111_modeset_init(struct drm_device *dev)
 
 	priv->fbdev = drm_fbdev_cma_init(dev, 32,
 					 dev->mode_config.num_connector);
+	if (IS_ERR(priv->fbdev)) {
+		dev_err(dev->dev, "Failed to initialize CMA framebuffer\n");
+		ret = PTR_ERR(priv->fbdev);
+		goto out_bridge;
+	}
 
 	drm_kms_helper_poll_init(dev);
 
-- 
2.14.3
