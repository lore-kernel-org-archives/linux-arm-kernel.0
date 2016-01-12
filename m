From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 16:17:56 +0100
Subject: [PATCHv2 2/2] net: fec: Reset ethernet PHY whenever the enet_out
 clock is being enabled
In-Reply-To: <1452611876-451-2-git-send-email-LW@KARO-electronics.de>
References: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
 <1452611876-451-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452611876-451-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a PHY uses ENET_OUT as reference clock, it may need a RESET to get
functional after the clock had been disabled.

Failure to do this results in the link state constantly toggling
between up and down:
fec 02188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
fec 02188000.ethernet eth0: Link is Down
fec 02188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
fec 02188000.ethernet eth0: Link is Down
[...]

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 99d33e2..33228df 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -519,6 +519,7 @@ struct fec_enet_private {
 	int	pause_flag;
 	int	wol_flag;
 	u32	quirks;
+	int	phy_reset_gpio;
 
 	struct	napi_struct napi;
 	int	csum_flags;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 592a7a4..fb0b0eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -67,6 +67,7 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_init(struct net_device *ndev);
+static void fec_reset_phy(struct platform_device *pdev);
 
 #define DRIVER_NAME	"fec"
 
@@ -1862,6 +1863,8 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 			ret = clk_prepare_enable(fep->clk_enet_out);
 			if (ret)
 				goto failed_clk_enet_out;
+
+			fec_reset_phy(fep->pdev);
 		}
 		if (fep->clk_ptp) {
 			mutex_lock(&fep->ptp_clk_mutex);
@@ -3216,11 +3219,12 @@ static int fec_enet_init(struct net_device *ndev)
 #ifdef CONFIG_OF
 static void fec_reset_phy(struct platform_device *pdev)
 {
-	int err, phy_reset;
-	int msec = 1;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device_node *np = pdev->dev.of_node;
+	int msec = 1;
 
-	if (!np)
+	if (!gpio_is_valid(fep->phy_reset_gpio))
 		return;
 
 	of_property_read_u32(np, "phy-reset-duration", &msec);
@@ -3228,18 +3232,27 @@ static void fec_reset_phy(struct platform_device *pdev)
 	if (msec > 1000)
 		msec = 1;
 
+	gpio_set_value_cansleep(fep->phy_reset_gpio, 0);
+	msleep(msec);
+	gpio_set_value_cansleep(fep->phy_reset_gpio, 1);
+}
+
+static int fec_get_reset_gpio(struct platform_device *pdev)
+{
+	int err, phy_reset;
+	struct device_node *np = pdev->dev.of_node;
+
 	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
 	if (!gpio_is_valid(phy_reset))
-		return;
+		return phy_reset;
 
 	err = devm_gpio_request_one(&pdev->dev, phy_reset,
 				    GPIOF_OUT_INIT_LOW, "phy-reset");
 	if (err) {
 		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
-		return;
+		return err;
 	}
-	msleep(msec);
-	gpio_set_value_cansleep(phy_reset, 1);
+	return phy_reset;
 }
 #else /* CONFIG_OF */
 static void fec_reset_phy(struct platform_device *pdev)
@@ -3249,6 +3262,11 @@ static void fec_reset_phy(struct platform_device *pdev)
 	 * by machine code.
 	 */
 }
+
+static inline int fec_get_reset_gpio(struct platform_device *pdev)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_OF */
 
 static void
@@ -3339,6 +3357,11 @@ fec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ndev);
 
+	ret = fec_get_reset_gpio(pdev);
+	if (ret == -EPROBE_DEFER)
+		goto gpio_defer;
+	fep->phy_reset_gpio = ret;
+
 	if (of_get_property(np, "fsl,magic-packet", NULL))
 		fep->wol_flag |= FEC_WOL_HAS_MAGIC_PACKET;
 
@@ -3493,6 +3516,7 @@ failed_clk_ipg:
 failed_clk:
 failed_phy:
 	of_node_put(phy_node);
+gpio_defer:
 failed_ioremap:
 	free_netdev(ndev);
 
-- 
2.1.4
