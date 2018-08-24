From: peda@axentia.se (Peter Rosin)
Date: Fri, 24 Aug 2018 10:55:00 +0200
Subject: [PATCH 1/2] drm/atmel-hlcdc: prefer a higher rate clock as
 pixel-clock base
In-Reply-To: <20180824085501.9740-1-peda@axentia.se>
References: <20180824085501.9740-1-peda@axentia.se>
Message-ID: <20180824085501.9740-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the divider used to get the pixel-clock is small, the granularity
of the frequencies possible for the pixel-clock is quite coarse. E.g.
requesting a pixel-clock of 65MHz with a sys_clk of 132MHz results
in the divider being set to 3 ending up with 44MHz.

By preferring the doubled sys_clk as base, the divider instead ends
up as 5 yielding a pixel-clock of 52.8Mhz, which is a definite
improvement.

While at it, clamp the divider so that it does not overflow in case
it gets big.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index c38a479ada98..71c9cd90d2ae 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -101,18 +101,22 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
-	cfg = 0;
+	cfg = ATMEL_HLCDC_CLKSEL;
 
-	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate = adj->crtc_clock * 1000;
-	if ((prate / 2) < mode_rate) {
-		prate *= 2;
-		cfg |= ATMEL_HLCDC_CLKSEL;
-	}
 
 	div = DIV_ROUND_UP(prate, mode_rate);
 	if (div < 2)
 		div = 2;
+	else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
+		/* the divider ended up too big, try a lower base rate */
+		cfg &= ~ATMEL_HLCDC_CLKSEL;
+		prate /= 2;
+		div = DIV_ROUND_UP(prate, mode_rate);
+		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
+			div = ATMEL_HLCDC_CLKDIV_MASK;
+	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
 
-- 
2.11.0
