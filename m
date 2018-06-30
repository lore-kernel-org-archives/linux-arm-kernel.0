From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Jun 2018 18:18:06 +0200
Subject: [PATCH net-next 5/5] net: gemini: Indicate that we can handle
 jumboframes
In-Reply-To: <20180630161806.24312-1-linus.walleij@linaro.org>
References: <20180630161806.24312-1-linus.walleij@linaro.org>
Message-ID: <20180630161806.24312-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware supposedly handles frames up to 10236 bytes and
implements .ndo_change_mtu() so accept 10236 minus the ethernet
header for a VLAN tagged frame on the netdevices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 79324bbfd768..ae475393e4ac 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2473,6 +2473,11 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
+	/* We can handle jumbo frames up to 10236 bytes so, let's accept
+	 * payloads of 10236 bytes minus VLAN and ethernet header
+	 */
+	netdev->min_mtu = 256;
+	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll,
-- 
2.17.1
