From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun,  4 May 2014 23:26:21 +0800
Subject: [PATCH 4/4] drm/exynos/mixer: add support for NV21
In-Reply-To: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
References: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1399217181-26442-5-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AFAICT, the only difference between NV12 and NV21 is Cr:Cb vs Cb:Cr.
Since the video processor can handle either order, it should be able to
handle both formats.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c |  1 +
 drivers/gpu/drm/exynos/exynos_mixer.c     | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 8371cbd..bf2be7a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -31,6 +31,7 @@ static const uint32_t formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV12MT,
+	DRM_FORMAT_NV21,
 };
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index b252ec7..52a94d9 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -383,8 +383,8 @@ static void vp_video_buffer(struct mixer_context *ctx, int win)
 	struct hdmi_win_data *win_data;
 	unsigned int x_ratio, y_ratio;
 	dma_addr_t luma_addr[2], chroma_addr[2];
-	bool tiled_mode = false;
-	bool crcb_mode = false;
+	bool tiled_mode;
+	bool crcb_mode;
 	u32 val;
 
 	win_data = &ctx->win_data[win];
@@ -392,10 +392,16 @@ static void vp_video_buffer(struct mixer_context *ctx, int win)
 	switch (win_data->pixel_format) {
 	case DRM_FORMAT_NV12MT:
 		tiled_mode = true;
-		/* fall through */
+		crcb_mode = false;
+		break;
 	case DRM_FORMAT_NV12:
+		tiled_mode = false;
 		crcb_mode = false;
 		break;
+	case DRM_FORMAT_NV21:
+		tiled_mode = false;
+		crcb_mode = true;
+		break;
 	/* TODO: single buffer format NV12, NV21 */
 	default:
 		DRM_ERROR("pixel format for vp is wrong [%d].\n",
-- 
1.9.1.423.g4596e3a
