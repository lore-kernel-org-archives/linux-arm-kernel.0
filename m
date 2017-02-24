From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:57 +0000
Subject: [PATCH v4 14/23] drm/rockchip: dw-mipi-dsi: ensure PHY is reset
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-15-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also don't power up the DSI host at this point since this is not
necessary in order to configure the PHY and we do so later when
selecting video or command mode.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 0f9be41f0361..78d676b7e516 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -397,7 +397,10 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 		return testdin;
 	}
 
-	dsi_write(dsi, DSI_PWR_UP, POWERUP);
+	/* Start by clearing PHY state */
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
 
 	dw_mipi_dsi_phy_write(dsi, 0x10, BYPASS_VCO_RANGE |
 					 VCO_RANGE_CON_SEL(vco) |
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
