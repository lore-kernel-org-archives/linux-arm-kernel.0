From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:53 +0100
Subject: [PATCH 146/222] imx-drm: match ipu_di_signal_cfg's clk_pol with its
 description.
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXp-0007N1-8g@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Denis Carikli <denis@eukrea.com>
To: linux-arm-kernel at lists.infradead.org

According to the datasheet, setting the di0_polarity_disp_clk
field in the GENERAL di register sets the output clock polarity
to active high.

Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-di.c | 2 +-
 drivers/staging/imx-drm/ipuv3-crtc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 82a9ebad697c..849b3e120ef0 100644
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
index c48f640db006..f2c9cd040043 100644
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
1.8.3.1
