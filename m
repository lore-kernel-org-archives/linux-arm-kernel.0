From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed,  3 Oct 2018 16:24:58 +0200
Subject: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if
 null
In-Reply-To: <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
Message-ID: <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If using tcon with VGA, tcon->panel will be null(0), this will cause
segmentation fault when trying to dereference tcon->panel->connector.

Add tcon->panel null check before calling
sun4i_tcon0_mode_set_dithering().

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
                      RGB565/RGB666 LCD panels")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes V1->V2:
* none

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e4b3bd0307ef..f949287d926c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -491,7 +491,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Set dithering if needed */
-	sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+	if (tcon->panel)
+		sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
-- 
2.17.1
