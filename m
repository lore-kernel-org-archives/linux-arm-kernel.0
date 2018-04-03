From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 3 Apr 2018 17:04:23 -0500
Subject: [PATCH v2] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereferences
Message-ID: <20180403220423.GA718@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add null check on kmalloc() return value in order to prevent
a null pointer dereference.

Addresses-Coverity-ID: 1467429 ("Dereference null return value")
Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Add a null check on a second kmalloc a few lines below. Thanks to
   Eric Dumazet for pointing this out.

 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 1e9a31f..f7b5ca5 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1999,10 +1999,14 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 				struct xcast_addr *xaddr;
 
 				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
+				if (unlikely(!mc_list))
+					return;
 				INIT_LIST_HEAD(&mc_list->list);
 				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
 					xaddr = kmalloc(sizeof(*xaddr),
 							GFP_ATOMIC);
+					if (unlikely(!xaddr))
+						return;
 					xaddr->addr =
 						ether_addr_to_u64(ha->addr);
 					list_add_tail(&xaddr->list,
-- 
2.7.4
