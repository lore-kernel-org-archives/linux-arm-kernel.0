From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  7 Sep 2016 11:17:25 -0700
Subject: [PATCH] phy: rockchip-typec: add pm runtime support
Message-ID: <1473272245-28841-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pm_runtime support for rockchip Type-C, so that power domain is
enabled only when there is a transaction going on to help save power.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/phy/phy-rockchip-typec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
index fb58a27..e1a07aa 100644
--- a/drivers/phy/phy-rockchip-typec.c
+++ b/drivers/phy/phy-rockchip-typec.c
@@ -552,6 +552,12 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 		goto err_clk_core;
 	}
 
+	ret = pm_runtime_get_sync(tcphy->dev);
+	if (ret < 0) {
+		dev_err(tcphy->dev, "cannot get pm runtime %d\n", ret);
+		goto err_clk_ref;
+	}
+
 	reset_control_deassert(tcphy->tcphy_rst);
 
 	property_enable(tcphy, &cfg->typec_conn_dir, tcphy->flip);
@@ -602,6 +608,7 @@ static int tcphy_phy_init(struct rockchip_typec_phy *tcphy, u8 mode)
 err_wait_pma:
 	reset_control_assert(tcphy->uphy_rst);
 	reset_control_assert(tcphy->tcphy_rst);
+err_clk_ref:
 	clk_disable_unprepare(tcphy->clk_ref);
 err_clk_core:
 	clk_disable_unprepare(tcphy->clk_core);
@@ -610,6 +617,7 @@ err_clk_core:
 
 static void tcphy_phy_deinit(struct rockchip_typec_phy *tcphy)
 {
+	pm_runtime_put_sync(tcphy->dev);
 	reset_control_assert(tcphy->tcphy_rst);
 	reset_control_assert(tcphy->uphy_rst);
 	reset_control_assert(tcphy->pipe_rst);
@@ -987,6 +995,15 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy_provider);
 	}
 
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int rockchip_typec_phy_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
@@ -999,6 +1016,7 @@ MODULE_DEVICE_TABLE(of, rockchip_typec_phy_dt_ids);
 
 static struct platform_driver rockchip_typec_phy_driver = {
 	.probe		= rockchip_typec_phy_probe,
+	.remove		= rockchip_typec_phy_remove,
 	.driver		= {
 		.name	= "rockchip-typec-phy",
 		.of_match_table = rockchip_typec_phy_dt_ids,
-- 
1.9.1
