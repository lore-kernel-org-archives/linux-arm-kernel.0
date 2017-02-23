From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 16:05:40 +0800
Subject: [PATCH 08/11] drm/sun4i: tv: Switch to drm_of_find_possible_crtcs
In-Reply-To: <20170223080543.6659-1-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
Message-ID: <20170223080543.6659-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the crtcs have their .port field set properly, we can use
drm_of_find_possible_crtcs to find the connected crtcs, instead of
hardcoding the first crtc as usable. The new code also defers binding
when the upstream crtc hasn't been registered yet.

This makes it easier to support multiple tcons/crtcs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index c6f47222e8fc..32ed5fdf0c4d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -19,6 +19,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include "sun4i_backend.h"
@@ -623,7 +624,12 @@ static int sun4i_tv_bind(struct device *dev, struct device *master,
 		goto err_disable_clk;
 	}
 
-	tv->encoder.possible_crtcs = BIT(0);
+	tv->encoder.possible_crtcs = drm_of_find_possible_crtcs(drm,
+								dev->of_node);
+	if (!tv->encoder.possible_crtcs) {
+		ret = -EPROBE_DEFER;
+		goto err_disable_clk;
+	}
 
 	drm_connector_helper_add(&tv->connector,
 				 &sun4i_tv_comp_connector_helper_funcs);
-- 
2.11.0
