From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:03:29 +0100
Subject: [PATCH 02/12] drm: bridge/dw_hdmi: don't support any pixel doubled
 modes
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6an-0002qT-Ue@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mentioned in the previous commit, the dw-hdmi driver does not support
pixel doubled modes at present; it does not configure the PLL correctly
for these modes.  Therefore, filter out the double-clocked modes as we
presently are unable to support them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 1c0ee3476138..8edf4c31f55c 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1448,6 +1448,10 @@ dw_hdmi_connector_mode_valid(struct drm_connector *connector,
 					   struct dw_hdmi, connector);
 	enum drm_mode_status mode_status = MODE_OK;
 
+	/* We don't support double-clocked modes */
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		return MODE_BAD;
+
 	if (hdmi->plat_data->mode_valid)
 		mode_status = hdmi->plat_data->mode_valid(connector, mode);
 
-- 
2.1.0
