From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue,  2 Oct 2018 22:49:00 +0200
Subject: [PATCH 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if null
In-Reply-To: <20181002204900.82118-1-giulio.benetti@micronovasrl.com>
References: <20181001093612.GA13672@mwanda>
 <20181002204900.82118-1-giulio.benetti@micronovasrl.com>
Message-ID: <20181002204900.82118-2-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If using tcon with VGA, tcon->panel will be null(0), this will cause
segmentation fault when trying to dereference tcon->panel->connector.

Add tcon->panel null check before calling
sun4i_tcon0_mode_set_dithering().

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
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
