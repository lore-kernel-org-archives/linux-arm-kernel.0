From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Mon, 31 Aug 2015 11:39:57 +0800
Subject: [PATCH] drm/fsl-dcu: Fix no fb check bug
Message-ID: <1440992397-40533-1-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For state->fb may be NULL in fsl_dcu_drm_plane_atomic_check function,
if so, return -EINVAL. No need check in fsl_dcu_drm_plane_atomic_update
anymore.

Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 82be6b8..8787920 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -41,6 +41,9 @@ static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_framebuffer *fb = state->fb;
 
+	if (!fb)
+		return -EINVAL;
+
 	switch (fb->pixel_format) {
 	case DRM_FORMAT_RGB565:
 	case DRM_FORMAT_RGB888:
@@ -84,9 +87,6 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 	unsigned int alpha, bpp;
 	int index, ret;
 
-	if (!fb)
-		return;
-
 	index = fsl_dcu_drm_plane_index(plane);
 	if (index < 0)
 		return;
-- 
2.1.0.27.g96db324
