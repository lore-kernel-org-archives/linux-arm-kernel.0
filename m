From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 16 Jun 2014 15:35:12 +0200
Subject: [RFC PATCH 3/4] drm/tegra: Request memory bandwidth for the display
 controller
In-Reply-To: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request it based solely on the current mode's refresh rate. More
accurate requirements can be requested in future patches.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/tegra/dc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index ef40381..6739d69 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/reset.h>
+#include <linux/platform_data/tegra_emc.h>
 
 #include "dc.h"
 #include "drm.h"
@@ -683,6 +684,8 @@ static void tegra_crtc_disable(struct drm_crtc *crtc)
 	}
 
 	drm_vblank_off(drm, dc->pipe);
+
+	tegra124_emc_reserve_bandwidth(TEGRA_EMC_CONSUMER_DISP1, 0);
 }
 
 static bool tegra_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -769,6 +772,7 @@ static int tegra_crtc_mode_set(struct drm_crtc *crtc,
 	struct tegra_dc *dc = to_tegra_dc(crtc);
 	struct tegra_dc_window window;
 	u32 value;
+	unsigned long bandwidth;
 	int err;
 
 	drm_vblank_pre_modeset(crtc->dev, dc->pipe);
@@ -809,6 +813,11 @@ static int tegra_crtc_mode_set(struct drm_crtc *crtc,
 	if (err < 0)
 		dev_err(dc->dev, "failed to enable root plane\n");
 
+	bandwidth = mode->clock * window.bits_per_pixel / 8;
+	err = tegra124_emc_reserve_bandwidth(TEGRA_EMC_CONSUMER_DISP1, bandwidth);
+	if (err)
+		dev_err(dc->dev, "failed to reserve EMC bandwidth: %d\n", err);
+
 	return 0;
 }
 
-- 
1.9.3
