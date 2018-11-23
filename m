From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:37 +0100
Subject: [PATCH v2 05/43] drm/sun4i: frontend: Add a helper and a list for
 supported formats
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-6-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to check whether the frontend supports a specific format, an
explicit list and a related helper are introduced.

Just like in the backend, the prototype of the helper is added to the
frontend header so that it can be used later on. The helper is also
exported because it will be used outside of the frontend module.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 16 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 3ea925584891..0f7f8c7b3402 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -128,6 +128,22 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
+static const uint32_t sun4i_frontend_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+bool sun4i_frontend_format_is_supported(uint32_t fmt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++)
+		if (sun4i_frontend_formats[i] == fmt)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(sun4i_frontend_format_is_supported);
+
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 02661ce81f3e..a9cb908ced16 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -95,5 +95,6 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane);
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
+bool sun4i_frontend_format_is_supported(uint32_t fmt);
 
 #endif /* _SUN4I_FRONTEND_H_ */
-- 
2.19.1
