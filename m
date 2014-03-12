From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:31:01 +0100
Subject: [PATCH v10][ 04/10] imx-drm: Match ipu_di_signal_cfg's clk_pol with
 its description.
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, setting the di0_polarity_disp_clk
field in the GENERAL di register sets the output clock polarity
to active high.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- New patch that is now needed by the
  "staging: imx-drm: Use de-active and pixelclk-active" patch.
---
 drivers/staging/imx-drm/ipu-v3/ipu-di.c |    2 +-
 drivers/staging/imx-drm/ipuv3-crtc.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 82a9eba..849b3e1 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -595,7 +595,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		}
 	}
 
-	if (!sig->clk_pol)
+	if (sig->clk_pol)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index a8d0178..db6bd64 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -158,7 +158,7 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 		sig_cfg.Vsync_pol = 1;
 
 	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 1;
+	sig_cfg.clk_pol = 0;
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
-- 
1.7.9.5
