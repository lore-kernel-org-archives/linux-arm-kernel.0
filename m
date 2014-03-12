From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:31:02 +0100
Subject: [PATCH v10][ 05/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- New patch which was splitted out from:
  "staging: imx-drm: Use de-active and pixelclk-active display-timings.".
- Fixes many issues in "staging: imx-drm: Use de-active and pixelclk-active
  display-timings.":
  - More clear meaning of the polarity settings.
  - The SET_CLK_POL and SET_DE_POL masks are not
    needed anymore.
---
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |    8 +++++++-
 drivers/staging/imx-drm/ipu-v3/ipu-di.c     |    4 ++--
 drivers/staging/imx-drm/ipuv3-crtc.c        |    4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index c4d14ea..b95cba1 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -27,6 +27,12 @@ enum ipuv3_type {
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+#define CLK_POL_ACTIVE_LOW	0
+#define CLK_POL_ACTIVE_HIGH	1
+
+#define ENABLE_POL_NEGEDGE	0
+#define ENABLE_POL_POSEDGE	1
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
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 849b3e1..53646aa 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -595,7 +595,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		}
 	}
 
-	if (sig->clk_pol)
+	if (sig->clk_pol == CLK_POL_ACTIVE_HIGH)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
@@ -606,7 +606,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	reg = ipu_di_read(di, DI_POL);
 	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
 
-	if (sig->enable_pol)
+	if (sig->enable_pol == ENABLE_POL_POSEDGE)
 		reg |= DI_POL_DRDY_POLARITY_15;
 	if (sig->data_pol)
 		reg |= DI_POL_DRDY_DATA_POLARITY;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index db6bd64..8cfeb47 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -157,8 +157,8 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 0;
+	sig_cfg.enable_pol = ENABLE_POL_POSEDGE;
+	sig_cfg.clk_pol = CLK_POL_ACTIVE_LOW;
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
-- 
1.7.9.5
