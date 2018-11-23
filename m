From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:14 +0100
Subject: [PATCH v2 42/43] drm/sun4i: frontend: Move the FIR filter phases to
 our quirks
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-43-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The FIR filters phase depend on the SoC, so let's move it to our quirks
structure instead of removing them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 28 ++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f50507ee6d75..427c51029a9c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -438,12 +438,18 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	 * I have no idea what this does exactly, but it seems to be
 	 * related to the scaler FIR filter phase parameters.
 	 */
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG,
+		     frontend->data->ch_phase[0].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG,
+		     frontend->data->ch_phase[1].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG,
+		     frontend->data->ch_phase[0].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG,
+		     frontend->data->ch_phase[1].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG,
+		     frontend->data->ch_phase[0].vertphase[1]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG,
+		     frontend->data->ch_phase[1].vertphase[1]);
 
 	if (fb->format->is_yuv && !drm_format_is_yuv(out_fmt)) {
 		/* Setup the CSC engine for YUV to RGB conversion. */
@@ -671,6 +677,16 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 };
 
 static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.ch_phase		= {
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+	},
 	.has_coef_access_ctrl	= true,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 3618993f8e49..45f5f4f3d06f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -103,6 +103,11 @@ struct reset_control;
 struct sun4i_frontend_data {
 	bool	has_coef_access_ctrl;
 	bool	has_coef_rdy;
+
+	struct {
+		u32	horzphase;
+		u32	vertphase[2];
+	} ch_phase[2];
 };
 
 struct sun4i_frontend {
-- 
2.19.1
