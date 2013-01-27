From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 27 Jan 2013 15:27:30 +0100
Subject: [PATCH] NET: mv643xx: get smi clock from device tree
In-Reply-To: <684d670633e771b738725b082d88fdb773002f4a.1359232975.git.jason@lakedaemon.net>
References: <684d670633e771b738725b082d88fdb773002f4a.1359232975.git.jason@lakedaemon.net>
Message-ID: <1359296850-25348-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv643xx_eth is split up into core (ethernet) and smi (mdio) driver
parts. If clock gates are introduced as for Kirkwood and Dove SoCs,
smi registers are accessed with clock gated and cause the SoC to
hang.

This patch also gets and enables a clock passed from DT for the
shared smi part of the driver. It has been tested on Dove and also
allows the driver compiled and used as a module.

DT conversion patches for mv643xx_eth on Dove will be sent on another
patch set.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 67e5d86..c0f0671 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -296,6 +296,9 @@ struct mv643xx_eth_shared_private {
 	int extended_rx_coal_limit;
 	int tx_bw_control;
 	int tx_csum_limit;
+#if defined(CONFIG_HAVE_CLK)
+	struct clk *clk;
+#endif
 
 };
 
@@ -2626,6 +2629,12 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node,
 			"tx_csum_limit", &pd->tx_csum_limit);
 
+#if defined(CONFIG_HAVE_CLK)
+		msp->clk = of_clk_get(pdev->dev.of_node, 0);
+		if (!IS_ERR(msp->clk))
+			clk_prepare_enable(msp->clk);
+#endif
+
 		np = of_parse_phandle(pdev->dev.of_node, "shared_smi", 0);
 		if (np)
 			pd->shared_smi = of_find_device_by_node(np);
@@ -2695,6 +2704,12 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 out_free_mii_bus:
 	mdiobus_free(msp->smi_bus);
 out_unmap:
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(msp->clk)) {
+		clk_disable_unprepare(msp->clk);
+		clk_put(msp->clk);
+	}
+#endif
 	iounmap(msp->base);
 out_free:
 	kfree(msp);
@@ -2713,6 +2728,12 @@ static int mv643xx_eth_shared_remove(struct platform_device *pdev)
 	}
 	if (msp->err_interrupt != NO_IRQ)
 		free_irq(msp->err_interrupt, msp);
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(msp->clk)) {
+		clk_disable_unprepare(msp->clk);
+		clk_put(msp->clk);
+	}
+#endif
 	iounmap(msp->base);
 	kfree(msp);
 
-- 
1.7.10.4
