From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:51 +0100
Subject: [PATCH v2 19/43] drm/sun4i: frontend: Determine input mode based on
 the number of planes
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-20-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the number of planes associated with the DRM format to determine the
input mode configuration instead of the format iteself. This way, the
helper can be used for all packed formats without future changes.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index a305b731b042..a16697b0eac5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -118,14 +118,12 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 
 static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 {
-	switch (fmt) {
-	case DRM_FORMAT_XRGB8888:
+	if (drm_format_num_planes(fmt) == 1)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
-		return 0;
-
-	default:
+	else
 		return -EINVAL;
-	}
+
+	return 0;
 }
 
 static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
-- 
2.19.1
