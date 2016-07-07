From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  7 Jul 2016 11:24:32 +0200
Subject: [PATCH] drm: atmel-hlcdc: Fix vertical scaling
Message-ID: <1467883472-28168-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Leupold <leupold@rsi-elektrotechnik.de>

The code is applying the same scaling for the X and Y components,
thus making the scaling feature only functional when both components
have the same scaling factor.

Do the s/_w/_h/ replacement where appropriate to fix vertical scaling.

Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
Fixes: 1a396789f65a2 ("drm: add Atmel HLCDC Display Controller support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 016c191221f3..52c527f6642a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -320,19 +320,19 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
 			u32 *coeff_tab = heo_upscaling_ycoef;
 			u32 max_memsize;
 
-			if (state->crtc_w < state->src_w)
+			if (state->crtc_h < state->src_h)
 				coeff_tab = heo_downscaling_ycoef;
 			for (i = 0; i < ARRAY_SIZE(heo_upscaling_ycoef); i++)
 				atmel_hlcdc_layer_update_cfg(&plane->layer,
 							     33 + i,
 							     0xffffffff,
 							     coeff_tab[i]);
-			factor = ((8 * 256 * state->src_w) - (256 * 4)) /
-				 state->crtc_w;
+			factor = ((8 * 256 * state->src_h) - (256 * 4)) /
+				 state->crtc_h;
 			factor++;
-			max_memsize = ((factor * state->crtc_w) + (256 * 4)) /
+			max_memsize = ((factor * state->crtc_h) + (256 * 4)) /
 				      2048;
-			if (max_memsize > state->src_w)
+			if (max_memsize > state->src_h)
 				factor--;
 			factor_reg |= (factor << 16) | 0x80000000;
 		}
-- 
2.7.4
