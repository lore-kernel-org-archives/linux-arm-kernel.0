From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 24 Feb 2018 22:45:38 +0100
Subject: [PATCH 08/15] drm/sun4i: Fix polarity configuration for DW HDMI PHY
In-Reply-To: <20180224214545.3740-1-jernej.skrabec@siol.net>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
Message-ID: <20180224214545.3740-9-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current polarity configuration code is cleary wrong since it compares
same flag two times. However, even if flag name is fixed, it won't work
well for resolutions which have one polarity positive and another
negative.

Fix that by properly set each bit according to each polarity. Since
those two bits are not described in any documentation, relationships
were obtained by experimentation.

Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index e5bfcdd43ec9..f48e8b70fabe 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -35,10 +35,11 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
 	u32 val = 0;
 
-	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
-	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
-		val = 0x03;
-	}
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		val |= 0x01;
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		val |= 0x02;
 
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
 			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK,
-- 
2.16.2
