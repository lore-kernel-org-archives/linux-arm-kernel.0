From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 31 Jul 2018 10:26:50 +0100
Subject: [PATCH 3/4] drm/i2c: tda998x: correct PLL divider calculation
In-Reply-To: <20180731092343.GH17271@n2100.armlinux.org.uk>
References: <20180731092343.GH17271@n2100.armlinux.org.uk>
Message-ID: <E1fkQva-0003nO-3u@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The serializer PLL divider is a power-of-two divider, so our calculation
which assumes that it's a numerical divider is incorrect.  Replace it
with one that results in a power-of-two divider value instead.

Tested with all supported modes with a Samsung S24C750.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 98ec91a55a6a..a31809ce30e2 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1334,6 +1334,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 				    struct drm_display_mode *adjusted_mode)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	unsigned long tmds_clock;
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1404,12 +1405,19 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 			       (mode->vsync_end - mode->vsync_start)/2;
 	}
 
-	div = 148500 / mode->clock;
-	if (div != 0) {
-		div--;
-		if (div > 3)
-			div = 3;
-	}
+	tmds_clock = mode->clock;
+
+	/*
+	 * The divisor is power-of-2. The TDA9983B datasheet gives
+	 * this as ranges of Msample/s, which is 10x the TMDS clock:
+	 *   0 - 800 to 1500 Msample/s
+	 *   1 - 400 to 800 Msample/s
+	 *   2 - 200 to 400 Msample/s
+	 *   3 - as 2 above
+	 */
+	for (div = 0; div < 3; div++)
+		if (80000 >> div <= tmds_clock)
+			break;
 
 	mutex_lock(&priv->audio_mutex);
 
-- 
2.7.4
