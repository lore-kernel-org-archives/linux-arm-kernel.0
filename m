From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 26 Sep 2014 16:33:50 +0200
Subject: [PATCH v5 04/10] net: pxa168_eth: fix Ethernet flow control status
In-Reply-To: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1411742036-23520-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IEEE 802.3x Ethernet flow control is disabled when bit (1 << 2) is set
in the port status register. Fix the flow control detection in the link
event handling function which was relying on the opposite assumption.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 978f26198dd6..b9073e2f3623 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -163,7 +163,7 @@
 /* Bit definitions for Port status */
 #define PORT_SPEED_100		(1 << 0)
 #define FULL_DUPLEX		(1 << 1)
-#define FLOW_CONTROL_ENABLED	(1 << 2)
+#define FLOW_CONTROL_DISABLED	(1 << 2)
 #define LINK_UP			(1 << 3)
 
 /* Bit definitions for work to be done */
@@ -885,7 +885,7 @@ static void handle_link_event(struct pxa168_eth_private *pep)
 		speed = 10;
 
 	duplex = (port_status & FULL_DUPLEX) ? 1 : 0;
-	fc = (port_status & FLOW_CONTROL_ENABLED) ? 1 : 0;
+	fc = (port_status & FLOW_CONTROL_DISABLED) ? 0 : 1;
 	netdev_info(dev, "link up, %d Mb/s, %s duplex, flow control %sabled\n",
 		    speed, duplex ? "full" : "half", fc ? "en" : "dis");
 	if (!netif_carrier_ok(dev))
-- 
1.9.1
