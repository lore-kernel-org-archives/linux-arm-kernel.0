From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:38 +0100
Subject: [PATCH 102/222] net:fec: clear receive interrupts before processing a
 packet
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTi-0007K1-9I@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear any pending receive interrupt before we process a pending packet.
This helps to avoid any spurious interrupts being raised after we have
fully cleaned the receive ring, while still allowing an interrupt to be
raised if we receive another packet.

The timing of this is critical: we must do this prior to reading the
next packet status to avoid delaying a pending packet.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0d1580ebaede..51b00c77bf00 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -904,6 +904,8 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		if ((status & BD_ENET_RX_LAST) == 0)
 			netdev_err(ndev, "rcv is not +last\n");
 
+		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
+
 		/* Check for errors. */
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
 			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
-- 
1.8.3.1
