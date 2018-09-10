From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 11:22:19 +0200
Subject: [PATCH v4 2/6] drm/rockchip: dw_hdmi: Allow outputs that don't need
 output switching
In-Reply-To: <20180910092223.1106-1-heiko@sntech.de>
References: <20180910092223.1106-1-heiko@sntech.de>
Message-ID: <20180910092223.1106-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far we always encountered socs with 2 output crtcs needing the driver
to tell the hdmi block which output to connect to. But there also exist
socs with only one crtc like the rk3228, rk3328 and rk3368.

So adapt the register field to simply carry a negative value to signal
that no output-switching is necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>

changes in v3:
- fixed wording issue found by Robin Murphy
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 11309a2a4e43..b09c3531305b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -36,7 +36,7 @@
  * @lcdsel_lit: reg value of selecting vop little for HDMI
  */
 struct rockchip_hdmi_chip_data {
-	u32	lcdsel_grf_reg;
+	int	lcdsel_grf_reg;
 	u32	lcdsel_big;
 	u32	lcdsel_lit;
 };
@@ -245,6 +245,9 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	u32 val;
 	int ret;
 
+	if (hdmi->chip_data->lcdsel_grf_reg < 0)
+		return;
+
 	ret = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
 	if (ret)
 		val = hdmi->chip_data->lcdsel_lit;
-- 
2.17.0
