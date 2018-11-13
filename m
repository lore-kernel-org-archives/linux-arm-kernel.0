From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:21 +0100
Subject: [PATCH v2 13/25] net: davinci_emac: use nvmem_get_mac_address()
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-14-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All DaVinci boards still supported in board files now define nvmem
cells containing the MAC address. We want to stop using the setup
callback from at24 so the MAC address for those users will no longer
be provided over platform data. If we didn't get a valid MAC in pdata,
try nvmem before resorting to a random MAC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 9153db120352..840820402cd0 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1912,11 +1912,15 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Use random MAC if none passed */
-		eth_hw_addr_random(ndev);
-		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-							priv->mac_addr);
+		/* Try nvmem if MAC wasn't passed over pdata or DT. */
+		rc = nvmem_get_mac_address(&pdev->dev, priv->mac_addr);
+		if (rc) {
+			/* Use random MAC if still none obtained. */
+			eth_hw_addr_random(ndev);
+			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+				 priv->mac_addr);
+		}
 	}
 
 	ndev->netdev_ops = &emac_netdev_ops;
-- 
2.19.1
