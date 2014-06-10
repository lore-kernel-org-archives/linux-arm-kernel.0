From: denis@eukrea.com (Denis Carikli)
Date: Tue, 10 Jun 2014 12:25:45 +0200
Subject: [PATCH v13 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <1402395951-7988-1-git-send-email-denis@eukrea.com>
References: <1402395951-7988-1-git-send-email-denis@eukrea.com>
Message-ID: <1402395951-7988-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog 12->v13:
- No changes
ChangeLog 11->v12:
- Improved the define names to match the hardware:
  ENABLE_POL is not a clock signal but instead an enable signal.

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
index c2c6fab..015e3bf 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -27,6 +27,12 @@ enum ipuv3_type {
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+#define CLK_POL_NEGEDGE		0
+#define CLK_POL_POSEDGE		1
+
+#define ENABLE_POL_LOW		0
+#define ENABLE_POL_HIGH		1
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
index 849b3e1..0ce3f52 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -595,7 +595,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		}
 	}
 
-	if (sig->clk_pol)
+	if (sig->clk_pol == CLK_POL_POSEDGE)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
@@ -606,7 +606,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	reg = ipu_di_read(di, DI_POL);
 	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
 
-	if (sig->enable_pol)
+	if (sig->enable_pol == ENABLE_POL_HIGH)
 		reg |= DI_POL_DRDY_POLARITY_15;
 	if (sig->data_pol)
 		reg |= DI_POL_DRDY_DATA_POLARITY;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 47bec5e..ba9eea3 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -165,8 +165,8 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 0;
+	sig_cfg.enable_pol = ENABLE_POL_HIGH;
+	sig_cfg.clk_pol = CLK_POL_NEGEDGE;
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
-- 
1.7.9.5
