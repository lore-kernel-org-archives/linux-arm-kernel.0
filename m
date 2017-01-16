From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:31 +0800
Subject: [PATCH v2 11/11] drm/rockchip/dsi: fix insufficient bandwidth of some
 panel
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-12-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the lanes bps to 1 / 0.9 times of pclk, the margin is not enough
for some panel, it will cause the screen display is not normal, so
increases the badnwidth to 1 / 0.8.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 9dfa73d..5a973fe 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -501,8 +501,8 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
 
 	mpclk = DIV_ROUND_UP(dsi->mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / dsi->lanes) * 10 / 9;
+		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
+		tmp = mpclk * (bpp / dsi->lanes) * 10 / 8;
 		if (tmp < max_mbps)
 			target_mbps = tmp;
 		else
-- 
2.6.3
