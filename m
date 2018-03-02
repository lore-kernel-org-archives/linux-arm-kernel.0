From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  2 Mar 2018 18:57:55 +0100
Subject: [PATCH v9 3/5] drm/rockchip: inno_hdmi: reorder clk_disable_unprepare
 call in unbind
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Message-ID: <20180302175757.28192-4-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

In bind the clk_prepare_enable of the HDMI pclk is called before adding the
i2c_adapter. So it should be the other way around in unbind, first remove
the i2c_adapter and then call the clk_disable_unprepare.

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Added new patch to reorder clk_disable_unprepare call in inno_hdmi
  unbind()

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index a5c661930250..88d0774c97bd 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -906,8 +906,8 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 
-	clk_disable_unprepare(hdmi->pclk);
 	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->pclk);
 }
 
 static const struct component_ops inno_hdmi_ops = {
-- 
2.16.1
