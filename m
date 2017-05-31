From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 31 May 2017 09:18:33 +0200
Subject: [PATCH v6 02/21] net-next: stmmac: add optional setup function
In-Reply-To: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
Message-ID: <20170531071852.12422-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of adding more ifthen logic for adding a new mac_device_info
setup function, it is easier to add a function pointer to the function
needed.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 include/linux/stmmac.h                            | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f158273eab9b..c80c9c3b67db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3933,7 +3933,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	struct mac_device_info *mac;
 
 	/* Identify the MAC HW device */
-	if (priv->plat->has_gmac) {
+	if (priv->plat->setup) {
+		mac = priv->plat->setup(priv);
+	} else if (priv->plat->has_gmac) {
 		priv->dev->priv_flags |= IFF_UNICAST_FLT;
 		mac = dwmac1000_setup(priv->ioaddr,
 				      priv->plat->multicast_filter_bins,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 3921cb9dfadb..8bb550bca96d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -177,6 +177,7 @@ struct plat_stmmacenet_data {
 	void (*fix_mac_speed)(void *priv, unsigned int speed);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
+	struct mac_device_info *(*setup)(void *priv);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.13.0
