From: denis@eukrea.com (Denis Carikli)
Date: Fri, 27 Jun 2014 16:17:28 +0200
Subject: [PATCH v14 updated] imx-drm: use defines for clock polarity settings
In-Reply-To: <20140626205631.GB32514@n2100.arm.linux.org.uk>
References: <20140626205631.GB32514@n2100.arm.linux.org.uk>
Message-ID: <1403878648-9526-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/gpu/ipu-v3/ipu-di.c          |    4 ++--
 drivers/staging/imx-drm/ipuv3-crtc.c |    4 ++--
 include/video/imx-ipu-v3.h           |    8 +++++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index c490ba4..5f7f799 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -595,7 +595,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		}
 	}
 
-	if (sig->clk_pol)
+	if (sig->clk_pol == IPU_CLK_POL_POSEDGE)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
@@ -606,7 +606,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	reg = ipu_di_read(di, DI_POL);
 	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
 
-	if (sig->enable_pol)
+	if (sig->enable_pol == IPU_ENABLE_POL_HIGH)
 		reg |= DI_POL_DRDY_POLARITY_15;
 	if (sig->data_pol)
 		reg |= DI_POL_DRDY_DATA_POLARITY;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 720868b..4e54f7a 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -165,8 +165,8 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 0;
+	sig_cfg.enable_pol = IPU_ENABLE_POL_HIGH;
+	sig_cfg.clk_pol = IPU_CLK_POL_NEGEDGE;
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 3e43e22..d52edb4 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -27,6 +27,12 @@ enum ipuv3_type {
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+#define IPU_CLK_POL_NEGEDGE	0
+#define IPU_CLK_POL_POSEDGE	1
+
+#define IPU_ENABLE_POL_LOW	0
+#define IPU_ENABLE_POL_HIGH	1
+
 /*
  * Bitfield of Display Interface signal polarities.
  */
@@ -37,7 +43,7 @@ struct ipu_di_signal_cfg {
 	unsigned clksel_en:1;
 	unsigned clkidle_en:1;
 	unsigned data_pol:1;	/* true = inverted */
-	unsigned clk_pol:1;	/* true = rising edge */
+	unsigned clk_pol:1;
 	unsigned enable_pol:1;
 	unsigned Hsync_pol:1;	/* true = active high */
 	unsigned Vsync_pol:1;
-- 
1.7.9.5
