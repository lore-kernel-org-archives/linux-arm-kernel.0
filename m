From: peda@axentia.se (Peter Rosin)
Date: Fri, 24 Aug 2018 11:24:58 +0200
Subject: [PATCH v2 2/2] drm/atmel-hlcdc: allow selecting a higher pixel-clock
 than requested
In-Reply-To: <20180824092458.13165-1-peda@axentia.se>
References: <20180824092458.13165-1-peda@axentia.se>
Message-ID: <20180824092458.13165-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

But only if the highest pixel-clock frequency lower than requested
is significantly less accurate than the lowest frequency higher than
requested.

I pulled "10 times" as the discriminator out of the hat, and went with
that.

This is useful, if e.g. the target pixel-clock is 65MHz and the sys_clk
is 132MHz. In this case the highest possible pixel-clock lower than the
requested 65MHz is 52.8MHz, which is almost 20% off (and outside the
spec for the panel). The lowest possible pixel-clock higher than 65MHz
is 66MHz, which is a *much* better match, and only 1.5% off.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0d9d1042752a..9e34bce089d0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -116,6 +116,18 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		div = DIV_ROUND_UP(prate, mode_rate);
 		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
 			div = ATMEL_HLCDC_CLKDIV_MASK;
+	} else {
+		int div_low = prate / mode_rate;
+
+		if (div_low >= 2 &&
+		    ((prate / div_low - mode_rate) <
+		     10 * (mode_rate - prate / div)))
+			/*
+			 * At least 10 times better when using a higher
+			 * frequency than requested, instead of a lower.
+			 * So, go with that.
+			 */
+			div = div_low;
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
-- 
2.11.0
