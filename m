From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:48 +0100
Subject: [PATCH v2 16/43] drm/sun4i: frontend: Move CSC bypass setup to format
 update routine
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-17-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support YUV to RGB conversion with the frontend (which is
generally used for connecting with the backend), the CSC block must not
be bypassed.

As a result, the bit to enable CSC bypass is moved from the runtime
resume routine to the format update routine, so that it can disabled
when introducing support for YUV formats later.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 0f7f8c7b3402..f54b1c4a9264 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -177,6 +177,10 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
 
+	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
+			   SUN4I_FRONTEND_BYPASS_CSC_EN,
+			   SUN4I_FRONTEND_BYPASS_CSC_EN);
+
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
 		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(1) |
 		     SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
@@ -354,10 +358,6 @@ static int sun4i_frontend_runtime_resume(struct device *dev)
 			   SUN4I_FRONTEND_EN_EN,
 			   SUN4I_FRONTEND_EN_EN);
 
-	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN);
-
 	sun4i_frontend_scaler_init(frontend);
 
 	return 0;
-- 
2.19.1
