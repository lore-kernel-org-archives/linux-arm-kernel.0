From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 15 Nov 2014 15:25:02 +0530
Subject: [PATCH V8 07/14] drm/bridge: ptn3460: probe connector at the end of
 bridge attach
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1416045309-13359-8-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Force bridge connector detection at the end of the bridge attach.
This is needed to detect the bridge connector early.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/gpu/drm/bridge/ptn3460.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index e6d5ae7..9f800a1 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -281,6 +281,7 @@ int ptn3460_bridge_attach(struct drm_bridge *bridge)
 		return -ENODEV;
 	}
 
+	ptn_bridge->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 	if (ret) {
@@ -296,6 +297,8 @@ int ptn3460_bridge_attach(struct drm_bridge *bridge)
 	if (ptn_bridge->panel)
 		drm_panel_attach(ptn_bridge->panel, &ptn_bridge->connector);
 
+	drm_helper_hpd_irq_event(ptn_bridge->connector.dev);
+
 	return ret;
 }
 
-- 
1.7.9.5
