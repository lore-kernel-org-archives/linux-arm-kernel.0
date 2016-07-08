From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:05:00 +0800
Subject: [PATCH 6/7] drm/rockchip: dw-mipi: fix phy clk lane stop state timeout
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before phy init, the detection of phy state should be controlled
manually. After that, we can switch the detection to hardward,
it is automatic. Hence move PHY_TXREQUESTCLKHS setting to the end
of phy init.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 72d7f48..8401185 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -477,6 +477,8 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 		dev_err(dsi->dev,
 			"failed to wait for phy clk lane stop state\n");
 
+	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
+
 phy_init_end:
 	if (!IS_ERR(dsi->phy_cfg_clk))
 		clk_disable_unprepare(dsi->phy_cfg_clk);
@@ -714,7 +716,6 @@ static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 		  | PHY_RSTZ | PHY_SHUTDOWNZ);
 	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
 		  TX_ESC_CLK_DIVIDSION(7));
-	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 }
 
 static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
-- 
2.6.3
