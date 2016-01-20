From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 19:27:24 +0800
Subject: [PATCH v3 3/4] net: mvneta: get optional bus clk
In-Reply-To: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
References: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
Message-ID: <1453289245-2061-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may provide more than one clk for the mvneta IP, for
example Marvell BG4CT provides one clk for the mac core, and one
clk for the AXI bus logic. Obviously this bus clk also need to
be enabled. This patch adds this optional "bus" clk support.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 736a9ec..8b306d2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -373,6 +373,8 @@ struct mvneta_port {
 
 	/* Core clock */
 	struct clk *clk;
+	/* AXI clock */
+	struct clk *clk_bus;
 	u8 mcast_count[256];
 	u16 tx_ring_size;
 	u16 rx_ring_size;
@@ -3615,6 +3617,10 @@ static int mvneta_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(pp->clk);
 
+	pp->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(pp->clk_bus))
+		clk_prepare_enable(pp->clk_bus);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pp->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pp->base)) {
@@ -3726,6 +3732,7 @@ err_free_stats:
 err_free_ports:
 	free_percpu(pp->ports);
 err_clk:
+	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
 err_put_phy_node:
 	of_node_put(phy_node);
@@ -3743,6 +3750,7 @@ static int mvneta_remove(struct platform_device *pdev)
 	struct mvneta_port *pp = netdev_priv(dev);
 
 	unregister_netdev(dev);
+	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
 	free_percpu(pp->ports);
 	free_percpu(pp->stats);
-- 
2.7.0.rc3
