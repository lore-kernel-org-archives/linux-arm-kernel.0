From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 23 Aug 2016 12:57:01 +0000
Subject: [PATCH 3/3] drm/tilcdc: Advertise the DRM_FORMATs according to the IP
 revision
In-Reply-To: <20160823125701.25700-1-kbeldan@baylibre.com>
References: <20160823125701.25700-1-kbeldan@baylibre.com>
Message-ID: <20160823125701.25700-4-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ATM the driver unconditionally advertises support for some 24bpp and
32bpp formats while version 1 of the IP only supports up to 16bpp.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
index 41911e3..11285f6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
@@ -114,12 +114,17 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 int tilcdc_plane_init(struct drm_device *dev,
 		      struct drm_plane *plane)
 {
+	struct tilcdc_drm_private *priv = dev->dev_private;
+	unsigned int num_formats = ARRAY_SIZE(tilcdc_formats);
 	int ret;
 
+	if (priv->rev == 1)
+		num_formats = 1;
+
 	ret = drm_plane_init(dev, plane, 1,
 			     &tilcdc_plane_funcs,
 			     tilcdc_formats,
-			     ARRAY_SIZE(tilcdc_formats),
+			     num_formats,
 			     true);
 	if (ret) {
 		dev_err(dev->dev, "Failed to initialize plane: %d\n", ret);
-- 
2.9.2
