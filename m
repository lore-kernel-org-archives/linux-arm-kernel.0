From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 23 Feb 2018 15:05:26 +0100
Subject: [v2,03/10] drm/sun4i: Protect the TCON pixel clocks
In-Reply-To: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
References: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <287984f8-bcac-3789-d573-2f0c54fb537d@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Both TCON clocks are very sensitive to clock changes, since any change
might lead to improper timings.

Make sure our rate is never changed.

Tested-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
  drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c 
b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index b73acab74867..cbe87cee13d1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -261,7 +261,7 @@ static void sun4i_tcon0_mode_set_common(struct 
sun4i_tcon *tcon,
  					const struct drm_display_mode *mode)
  {
  	/* Configure the dot clock */
-	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+	clk_set_rate_exclusive(tcon->dclk, mode->crtc_clock * 1000);

  	/* Set the resolution */
  	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
@@ -419,7 +419,7 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon 
*tcon,
  	WARN_ON(!tcon->quirks->has_channel_1);

  	/* Configure the dot clock */
-	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
+	clk_set_rate_exclusive(tcon->sclk1, mode->crtc_clock * 1000);

  	/* Adjust clock delay */
  	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
