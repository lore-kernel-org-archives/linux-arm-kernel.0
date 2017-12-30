From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 30 Dec 2017 22:01:57 +0100
Subject: [PATCH 05/11] drm/bridge/synopsys: dw-hdmi: Add deinit callback
In-Reply-To: <20171230210203.24115-1-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
Message-ID: <20171230210203.24115-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs, like Allwinner A83T, have to do additional cleanup when
HDMI driver unloads. When using DW HDMI through DRM bridge API, there is
no place to store driver's private data so it can be accessed in unbind
function. Because of that, add deinit function which is called at the
very end, so drivers can do a proper cleanup.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 67467d0b683a..a6fe7a323c83 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2592,6 +2592,9 @@ static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 		i2c_del_adapter(&hdmi->i2c->adap);
 	else
 		i2c_put_adapter(hdmi->ddc);
+
+	if (hdmi->plat_data->deinit)
+		hdmi->plat_data->deinit(hdmi->plat_data);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index f5cca4362154..a3218d3da61b 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -124,6 +124,7 @@ struct dw_hdmi_phy_ops {
 
 struct dw_hdmi_plat_data {
 	struct regmap *regm;
+	void (*deinit)(const struct dw_hdmi_plat_data *pdata);
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
-- 
2.15.1
