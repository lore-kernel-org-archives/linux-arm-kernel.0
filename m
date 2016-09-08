From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  7 Sep 2016 22:57:33 -0700
Subject: [RESEND PATCH v3 1/2] phy: rockchip-typec: add pm runtime support
In-Reply-To: <57D0F612.10702@ti.com>
References: <57D0F612.10702@ti.com>
Message-ID: <1473314253-2646-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pm_runtime support for rockchip Type-C, so that power domain is
enabled only when there is a transaction going on to help save power.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v3:
- use phy_core pm_runtime

Changes in v2:
- add pm_runtime_put_sync in err case

 drivers/phy/phy-rockchip-typec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
index fb58a27..7cfb0f8 100644
--- a/drivers/phy/phy-rockchip-typec.c
+++ b/drivers/phy/phy-rockchip-typec.c
@@ -960,6 +960,8 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(tcphy->extcon);
 	}
 
+	pm_runtime_enable(dev);
+
 	for_each_available_child_of_node(np, child_np) {
 		struct phy *phy;
 
@@ -990,6 +992,13 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int rockchip_typec_phy_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
 static const struct of_device_id rockchip_typec_phy_dt_ids[] = {
 	{ .compatible = "rockchip,rk3399-typec-phy" },
 	{}
@@ -999,6 +1008,7 @@ MODULE_DEVICE_TABLE(of, rockchip_typec_phy_dt_ids);
 
 static struct platform_driver rockchip_typec_phy_driver = {
 	.probe		= rockchip_typec_phy_probe,
+	.remove		= rockchip_typec_phy_remove,
 	.driver		= {
 		.name	= "rockchip-typec-phy",
 		.of_match_table = rockchip_typec_phy_dt_ids,
-- 
1.9.1
