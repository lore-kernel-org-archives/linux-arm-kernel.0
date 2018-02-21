From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 10:20:27 +0100
Subject: [PATCH v2 03/10] drm/sun4i: Protect the TCON pixel clocks
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Both TCON clocks are very sensitive to clock changes, since any change
might lead to improper timings.

Make sure our rate is never changed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index b73acab74867..cbe87cee13d1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -261,7 +261,7 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 					const struct drm_display_mode *mode)
 {
 	/* Configure the dot clock */
-	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+	clk_set_rate_exclusive(tcon->dclk, mode->crtc_clock * 1000);
 
 	/* Set the resolution */
 	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
@@ -419,7 +419,7 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	WARN_ON(!tcon->quirks->has_channel_1);
 
 	/* Configure the dot clock */
-	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
+	clk_set_rate_exclusive(tcon->sclk1, mode->crtc_clock * 1000);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
-- 
git-series 0.9.1
