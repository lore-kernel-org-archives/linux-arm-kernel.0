From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 25 Jun 2018 14:02:56 +0200
Subject: [PATCH v3 16/24] drm/sun4i: Enable DW HDMI PHY clock
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Message-ID: <20180625120304.7543-17-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DW HDMI PHY code never prepares and enables PHY clock after it is
created. It's just used as it is. This may work in some cases, but it's
clearly wrong. Fix it by adding proper calls to enable/disable PHY
clock.

Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 5a52fc489a9d..966688f04741 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -477,13 +477,15 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			dev_err(dev, "Couldn't create the PHY clock\n");
 			goto err_put_clk_pll0;
 		}
+
+		clk_prepare_enable(phy->clk_phy);
 	}
 
 	phy->rst_phy = of_reset_control_get_shared(node, "phy");
 	if (IS_ERR(phy->rst_phy)) {
 		dev_err(dev, "Could not get phy reset control\n");
 		ret = PTR_ERR(phy->rst_phy);
-		goto err_put_clk_pll0;
+		goto err_disable_clk_phy;
 	}
 
 	ret = reset_control_deassert(phy->rst_phy);
@@ -514,6 +516,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	reset_control_assert(phy->rst_phy);
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
+err_disable_clk_phy:
+	clk_disable_unprepare(phy->clk_phy);
 err_put_clk_pll0:
 	if (phy->variant->has_phy_clk)
 		clk_put(phy->clk_pll0);
@@ -531,6 +535,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
+	clk_disable_unprepare(phy->clk_phy);
 
 	reset_control_assert(phy->rst_phy);
 
-- 
2.18.0
