From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:26 +0800
Subject: [PATCH 3/7] drm/sun4i: Check return value of drm_vblank_init
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_vblank_init can fail due to insufficient memory. Ignoring the error
and proceeding may cause the kernel to dereference an invalid pointer
when vblank is enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8e777167bca4..63c46643fdd1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -130,7 +130,11 @@ static int sun4i_drv_bind(struct device *dev)
 	}
 	drm->dev_private = drv;
 
-	drm_vblank_init(drm, 1);
+	/* drm_vblank_init calls kcalloc, which can fail */
+	ret = drm_vblank_init(drm, 1);
+	if (ret)
+		goto free_drm;
+
 	drm_mode_config_init(drm);
 
 	ret = component_bind_all(drm->dev, drm);
-- 
2.11.0
