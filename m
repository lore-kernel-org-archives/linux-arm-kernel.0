From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 20 Jun 2014 13:13:56 +0100
Subject: [PATCH RFC 26/30] net: fec: clear receive interrupts before
 processing a packet
In-Reply-To: <20140620121118.GR32514@n2100.arm.linux.org.uk>
References: <20140620121118.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1Wxxhc-0005YX-0k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear any pending receive interrupt before we process a pending packet.
This helps to avoid any spurious interrupts being raised after we have
fully cleaned the receive ring, while still allowing an interrupt to be
raised if we receive another packet.

The position of this is critical: we must do this prior to reading the
next packet status to avoid potentially dropping an interrupt when a
packet is still pending.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e00616d54ec7..317c58ff9b95 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1185,6 +1185,8 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		if ((status & BD_ENET_RX_LAST) == 0)
 			netdev_err(ndev, "rcv is not +last\n");
 
+		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
+
 		/* Check for errors. */
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
 			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
-- 
1.8.3.1
