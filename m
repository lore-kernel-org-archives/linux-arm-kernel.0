From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:27 +0800
Subject: [PATCH 4/7] drm/sun4i: Fix kcalloc element size in sun4i_layers_init
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In sun4i_layers_init we are allocating an array of pointers to struct
sun4i_layer:

	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
	                      sizeof(**layers), GFP_KERNEL);

The element size should be the size of an individual element of the
array. Change it to sizeof(*layers) to avoid wasting a lot of memory.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 5d53c977bca5..62552a356d66 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -140,7 +140,7 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
 	int i;
 
 	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
-			      sizeof(**layers), GFP_KERNEL);
+			      sizeof(*layers), GFP_KERNEL);
 	if (!layers)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.11.0
