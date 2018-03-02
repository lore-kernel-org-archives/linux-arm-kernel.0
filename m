From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  2 Mar 2018 18:57:57 +0100
Subject: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge detach
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Message-ID: <20180302175757.28192-6-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

We inited connector in attach(), so need a detach() to cleanup.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9: None

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f9802399cc0d..5626922f95f9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1985,6 +1985,13 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 	return 0;
 }
 
+static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
+{
+	struct dw_hdmi *hdmi = bridge->driver_private;
+
+	drm_connector_cleanup(&hdmi->connector);
+}
+
 static enum drm_mode_status
 dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_mode *mode)
@@ -2041,6 +2048,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.attach = dw_hdmi_bridge_attach,
+	.detach = dw_hdmi_bridge_detach,
 	.enable = dw_hdmi_bridge_enable,
 	.disable = dw_hdmi_bridge_disable,
 	.mode_set = dw_hdmi_bridge_mode_set,
-- 
2.16.1
