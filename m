From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed, 28 Nov 2018 16:32:11 +0100
Subject: [PATCH 1/2] drm/exynos: mixer: Fix color format setting
In-Reply-To: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
References: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181128153233eucas1p2e5224bacb69616fdd794751593dc1629@eucas1p2.samsung.com>
Message-ID: <1543419132-16099-2-git-send-email-c.manszewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix color format decision based on height(pixels).

According to CEA-861-E:
"High Definition (HD) - A CE video format that, inclusively, has between
720 to 1080 active vertical lines (Vactive) lines per video frame."

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20181128
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index e3a4ecbc503b..bcc26c10095a 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -385,14 +385,9 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 {
 	u32 val;
 
-	switch (height) {
-	case 480:
-	case 576:
+	if (height < 720) {
 		val = MXR_CFG_RGB601_0_255;
-		break;
-	case 720:
-	case 1080:
-	default:
+	} else {
 		val = MXR_CFG_RGB709_16_235;
 		/* Configure the BT.709 CSC matrix for full range RGB. */
 		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
@@ -402,7 +397,6 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 			MXR_CSC_CT(-0.102, -0.338,  0.440));
 		mixer_reg_write(ctx, MXR_CM_COEFF_CR,
 			MXR_CSC_CT( 0.440, -0.399, -0.040));
-		break;
 	}
 
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_RGB_FMT_MASK);
-- 
2.7.4
