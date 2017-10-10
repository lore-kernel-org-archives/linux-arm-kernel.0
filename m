From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Oct 2017 11:19:58 +0800
Subject: [PATCH v4 01/11] drm/sun4i: tcon: Add variant callback for TCON
 output muxing
In-Reply-To: <20171010032008.682-1-wens@csie.org>
References: <20171010032008.682-1-wens@csie.org>
Message-ID: <20171010032008.682-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different SoCs have different muxing options and values for the TCON
outputs. Instead of stuffing every possibility in sun4i_tcon_set_mux(),
add a callback pointer to sun4i_tcon_quirks that each TCON variant
can use to provide muxing support.

The current muxing options in sun4i_tcon_set_mux() for sun5i-a13 are
moved to a new sun5i-specific callback function.

Since the new callback replaces what the .has_unknown_mux field in
tcon quirks did in the past, the field is removed.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 44 +++++++++++++++++++++++---------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  6 +++++-
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e853dfe51389..75124043d655 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -14,9 +14,12 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 
+#include <uapi/drm/drm_mode.h>
+
 #include <linux/component.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
@@ -112,23 +115,13 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			struct drm_encoder *encoder)
 {
-	u32 val;
-
-	if (!tcon->quirks->has_unknown_mux)
-		return;
+	int ret = -ENOTSUPP;
 
-	if (channel != 1)
-		return;
-
-	if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
-		val = 1;
-	else
-		val = 0;
+	if (tcon->quirks->set_mux)
+		ret = tcon->quirks->set_mux(tcon, encoder);
 
-	/*
-	 * FIXME: Undocumented bits
-	 */
-	regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
+	DRM_DEBUG_DRIVER("Muxing encoder %s to CRTC %s: %d\n",
+			 encoder->name, encoder->crtc->name, ret);
 }
 EXPORT_SYMBOL(sun4i_tcon_set_mux);
 
@@ -767,9 +760,26 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* platform specific TCON muxing callbacks */
+static int sun5i_a13_tcon_set_mux(struct sun4i_tcon *tcon,
+				  struct drm_encoder *encoder)
+{
+	u32 val;
+
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
+		val = 1;
+	else
+		val = 0;
+
+	/*
+	 * FIXME: Undocumented bits
+	 */
+	return regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
+}
+
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
-	.has_unknown_mux = true,
-	.has_channel_1	= true,
+	.has_channel_1		= true,
+	.set_mux		= sun5i_a13_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 5a219d1ccc26..d9e1357cc8ae 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -145,10 +145,14 @@
 
 #define SUN4I_TCON_MAX_CHANNELS		2
 
+struct sun4i_tcon;
+
 struct sun4i_tcon_quirks {
-	bool	has_unknown_mux; /* sun5i has undocumented mux */
 	bool	has_channel_1;	/* a33 does not have channel 1 */
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
+
+	/* callback to handle tcon muxing options */
+	int	(*set_mux)(struct sun4i_tcon *, struct drm_encoder *);
 };
 
 struct sun4i_tcon {
-- 
2.14.2
