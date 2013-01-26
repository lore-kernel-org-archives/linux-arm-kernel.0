From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 20:50:18 +0000
Subject: [PATCH V4 09/11] NET: mv643xx: Get clk from device tree.
In-Reply-To: <cover.1359232975.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
Message-ID: <684d670633e771b738725b082d88fdb773002f4a.1359232975.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

If we are passed a device tree node pointer, get the clock from it.
This avoids problems with con_id when using clk_get().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 7048d7c..296beec 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2955,7 +2955,10 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	 */
 	mp->t_clk = 133000000;
 #if defined(CONFIG_HAVE_CLK)
-	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
+	if (pdev->dev.of_node)
+		mp->clk = of_clk_get(pdev->dev.of_node, 0);
+	else
+		mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
 	if (!IS_ERR(mp->clk)) {
 		clk_prepare_enable(mp->clk);
 		mp->t_clk = clk_get_rate(mp->clk);
-- 
1.8.1.1
