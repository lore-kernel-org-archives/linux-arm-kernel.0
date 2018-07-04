From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jul 2018 20:33:24 +0200
Subject: [PATCH net-next 5/5 v2] net: gemini: Indicate that we can handle
 jumboframes
In-Reply-To: <20180704183324.10605-1-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
Message-ID: <20180704183324.10605-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware supposedly handles frames up to 10236 bytes and
implements .ndo_change_mtu() so accept 10236 minus the ethernet
header for a VLAN tagged frame on the netdevices. Use
ETH_MIN_MTU as minimum MTU.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change the min MTU from 256 (vendor code) to ETH_MIN_MTU
  which makes more sense.
---
 drivers/net/ethernet/cortina/gemini.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4e341570047f..af38f9869734 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2476,6 +2476,11 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
+	/* We can handle jumbo frames up to 10236 bytes so, let's accept
+	 * payloads of 10236 bytes minus VLAN and ethernet header
+	 */
+	netdev->min_mtu = ETH_MIN_MTU;
+	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll,
-- 
2.17.1
