From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 21:12:59 +0800
Subject: [PATCH 08/13] [NOT FOR REVIEW NOW] drm: bridge: Enable polling hpd
 event in dw_hdmi
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <20170801131304.7741-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Some custom phys don't support hpd interrupts. Add support for polling
such events.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 60faf2d2bc6b..6c6466c6297c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1942,7 +1942,11 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 	struct drm_connector *connector = &hdmi->connector;
 
 	connector->interlace_allowed = 1;
-	connector->polled = DRM_CONNECTOR_POLL_HPD;
+	if (hdmi->phy.ops->setup_hpd)
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	else
+		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+				    DRM_CONNECTOR_POLL_DISCONNECT;
 
 	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
 
-- 
2.13.0
