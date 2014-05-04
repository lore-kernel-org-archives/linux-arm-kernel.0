From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun,  4 May 2014 23:26:18 +0800
Subject: [PATCH 1/4] drm/exynos/mixer: move format definitions to regs-mixer
In-Reply-To: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
References: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1399217181-26442-2-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These constants directly define register values, so move them to the
register definition header.

Also, the logic used for setting fmt from bpp is either/or, so just use
if/else.

** No functional change

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 19 ++++---------------
 drivers/gpu/drm/exynos/regs-mixer.h   |  4 ++++
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index ce28881..475eb49 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -518,21 +518,10 @@ static void mixer_graph_buffer(struct mixer_context *ctx, int win)
 
 	win_data = &ctx->win_data[win];
 
-	#define RGB565 4
-	#define ARGB1555 5
-	#define ARGB4444 6
-	#define ARGB8888 7
-
-	switch (win_data->bpp) {
-	case 16:
-		fmt = ARGB4444;
-		break;
-	case 32:
-		fmt = ARGB8888;
-		break;
-	default:
-		fmt = ARGB8888;
-	}
+	if (win_data->bpp == 16)
+		fmt = MXR_GRP_CFG_FORMAT_ARGB4444;
+	else
+		fmt = MXR_GRP_CFG_FORMAT_ARGB8888;
 
 	/* 2x scaling feature */
 	x_ratio = 0;
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index 4537026..785a97a 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -114,6 +114,10 @@
 #define MXR_GRP_CFG_PIXEL_BLEND_EN	(1 << 16)
 #define MXR_GRP_CFG_FORMAT_VAL(x)	MXR_MASK_VAL(x, 11, 8)
 #define MXR_GRP_CFG_FORMAT_MASK		MXR_GRP_CFG_FORMAT_VAL(~0)
+#define MXR_GRP_CFG_FORMAT_RGB565	4
+#define MXR_GRP_CFG_FORMAT_ARGB1555	5
+#define MXR_GRP_CFG_FORMAT_ARGB4444	6
+#define MXR_GRP_CFG_FORMAT_ARGB8888	7
 #define MXR_GRP_CFG_ALPHA_VAL(x)	MXR_MASK_VAL(x, 7, 0)
 
 /* bits for MXR_GRAPHICn_WH */
-- 
1.9.1.423.g4596e3a
