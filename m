From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 26 Nov 2015 15:50:17 +0800
Subject: [PATCH v5 03/11] drm/rockchip: return a true clock rate to
 adjusted_mode
In-Reply-To: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
References: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1448524225-5489-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mipi dsi driver need to use the clock of vop to make the
calculation of Blanking. But sometimes the clock driver can not set a
accurate clock_rate for vop, get it by clk_round_rate before mode_set,
so we can get the true value.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Mark Yao <mark.yao@rock-chips.com>

---

Changes in v5: None
Changes in v4:
- use clk_round_rate to check the clock rate in vop_crtc_mode_fixup

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d8ae5e..eff545b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1136,9 +1136,14 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 				const struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
 {
+	struct vop *vop = to_vop(crtc);
+
 	if (adjusted_mode->htotal == 0 || adjusted_mode->vtotal == 0)
 		return false;
 
+	adjusted_mode->clock =
+		clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
+
 	return true;
 }
 
-- 
2.6.3
