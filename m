From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 10 Oct 2015 17:55:22 +0800
Subject: [PATCH 02/10] drm/rockchip: return a true clock rate to adjusted_mode
In-Reply-To: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
References: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1444470930-17150-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the clock driver can not set a accurate clock_rate for vop,
get the true rate of vop_dclk and set it back to adjusted_mode, since
the mipi dsi driver need to use the clock to make the calculation of
Blanking.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d8ae5e..9986b311ed 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1232,6 +1232,12 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	reset_control_deassert(vop->dclk_rst);
 
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
+
+	/*
+	 * Sometimes the clock driver can not set a accurate clock_rate for vop,
+	 * get the true rate of vop_dclk and set it back to adjusted_mode.
+	 */
+	adjusted_mode->clock = clk_get_rate(vop->dclk) / 1000;
 out:
 	ret_clk = clk_enable(vop->dclk);
 	if (ret_clk < 0) {
-- 
2.6.1
