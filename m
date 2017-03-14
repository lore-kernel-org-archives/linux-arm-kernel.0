From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 15:18:38 +0100
Subject: [PATCH v2 02/20] net-next: stmmac: add optional setup function
In-Reply-To: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
Message-ID: <20170314141856.24560-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of ading more ifthen logic for adding a new mac_device_info
setup function, it is easier to add a function pointer to the function
needed.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 include/linux/stmmac.h                            | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4498a38..856ac57 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3101,7 +3101,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
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
index fc273e9..8f09f18 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -109,6 +109,8 @@ struct stmmac_axi {
 	bool axi_rb;
 };
 
+struct stmmac_priv;
+
 struct plat_stmmacenet_data {
 	int bus_id;
 	int phy_addr;
@@ -136,6 +138,7 @@ struct plat_stmmacenet_data {
 	void (*fix_mac_speed)(void *priv, unsigned int speed);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
+	struct mac_device_info *(*setup)(struct stmmac_priv *priv);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.10.2
