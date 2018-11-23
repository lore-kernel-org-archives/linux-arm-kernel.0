From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:52 +0100
Subject: [PATCH v2 20/43] drm/sun4i: frontend: Determine input format based on
 colorspace
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-21-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since all the RGB input formats have the same value for the DATA_FMT
field of the INPUT_FMT register, we can group them when the format is
known to be RGB. Here, we assume that a non-YUV format is RGB, because
the hardware does not support any other colorspace than RGB and YUV.
Thus, we can use the associated common DRM helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index a16697b0eac5..7a8efbd516ac 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -106,14 +106,12 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
-	switch (fmt) {
-	case DRM_FORMAT_XRGB8888:
+	if (!drm_format_is_yuv(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
-		return 0;
-
-	default:
+	else
 		return -EINVAL;
-	}
+
+	return 0;
 }
 
 static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
-- 
2.19.1
