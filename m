From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Mar 2017 11:31:44 +0800
Subject: [PATCH v2 1/4] drm/rockchip/dsi: check phy_cfg_clk only for RK3399
In-Reply-To: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
References: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1489635107-21327-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RK3399, the phy_cfg_clk is a required clock, if phy_cfg_clk is
disabled, MIPI phy can not work. Let's return a error if there is no
phy_cfg_clk in dts property, when the pdata match RK3399.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index f84f9ae..11c4166 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1227,15 +1227,13 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		clk_disable_unprepare(dsi->pclk);
 	}
 
-	dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
-	if (IS_ERR(dsi->phy_cfg_clk)) {
-		ret = PTR_ERR(dsi->phy_cfg_clk);
-		if (ret != -ENOENT) {
+	if (pdata == &rk3399_mipi_dsi_drv_data) {
+		dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
+		if (IS_ERR(dsi->phy_cfg_clk)) {
+			ret = PTR_ERR(dsi->phy_cfg_clk);
 			dev_err(dev, "Unable to get phy_cfg_clk: %d\n", ret);
 			return ret;
 		}
-		dsi->phy_cfg_clk = NULL;
-		dev_dbg(dev, "have not phy_cfg_clk\n");
 	}
 
 	ret = clk_prepare_enable(dsi->pllref_clk);
-- 
2.6.3
