From: peda@axentia.se (Peter Rosin)
Date: Wed,  2 May 2018 09:40:24 +0200
Subject: [PATCH 2/3] drm/rockchip: lvds: avoid duplicating drm_bridge_attach
In-Reply-To: <20180502074025.12421-1-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se>
Message-ID: <20180502074025.12421-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_bridge_attach takes care of these assignments, so there is no need
to open-code them a second time.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index e67f4ea28c0e..4bd94b167d2c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -446,14 +446,12 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 			goto err_free_connector;
 		}
 	} else {
-		lvds->bridge->encoder = encoder;
 		ret = drm_bridge_attach(encoder, lvds->bridge, NULL);
 		if (ret) {
 			DRM_DEV_ERROR(drm_dev->dev,
 				      "failed to attach bridge: %d\n", ret);
 			goto err_free_encoder;
 		}
-		encoder->bridge = lvds->bridge;
 	}
 
 	pm_runtime_enable(dev);
-- 
2.11.0
