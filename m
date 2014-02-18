From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 18 Feb 2014 12:36:02 +0100
Subject: [RFC PATCH v3 1/9] staging: imx-drm-core: don't request probe
 deferral in imx_drm_encoder_parse_of
In-Reply-To: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

Since imx_drm_encoder_parse_of is called from the encoder bind callbacks,
it is too late to request probe deferral. Rather the core should make sure
that the crtcs are bound before the encoders, after all needed components
are probed.

This fixes probe failure when using the LDB on i.MX6.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index dcba518..98a97a2 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -457,21 +457,13 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 			return ret;
 
 		id = args.args_count > 0 ? args.args[0] : 0;
-		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
+		crtc_mask |= imx_drm_find_crtc_mask(imxdrm, args.np, id);
 		of_node_put(args.np);
-
-		/*
-		 * If we failed to find the CRTC(s) which this encoder is
-		 * supposed to be connected to, it's because the CRTC has
-		 * not been registered yet.  Defer probing, and hope that
-		 * the required CRTC is added later.
-		 */
-		if (mask == 0)
-			return -EPROBE_DEFER;
-
-		crtc_mask |= mask;
 	}
 
+	if (i == 0 || !crtc_mask)
+		return -ENOENT;
+
 	encoder->possible_crtcs = crtc_mask;
 
 	/* FIXME: this is the mask of outputs which can clone this output. */
-- 
1.8.5.3
