From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 31 May 2010 15:11:02 +0200
Subject: [PATCH] ixp4xx: Support the all multicast flag on the NPE devices.
Message-ID: <20100531131102.GA15870@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the IFF_ALLMULTI flag. Previously only the
IFF_PROMISC flag was supported.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 drivers/net/arm/ixp4xx_eth.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/arm/ixp4xx_eth.c b/drivers/net/arm/ixp4xx_eth.c
index 6be8b09..5d35064 100644
--- a/drivers/net/arm/ixp4xx_eth.c
+++ b/drivers/net/arm/ixp4xx_eth.c
@@ -739,6 +739,17 @@ static void eth_set_mcast_list(struct net_device *dev)
 	struct dev_mc_list *mclist;
 	u8 diffs[ETH_ALEN], *addr;
 	int i;
+	u8 allmulti[] = { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
+	if (dev->flags & IFF_ALLMULTI) {
+		for (i = 0; i < ETH_ALEN; i++) {
+			__raw_writel(allmulti[i], &port->regs->mcast_addr[i]);
+			__raw_writel(allmulti[i], &port->regs->mcast_mask[i]);
+		}
+		__raw_writel(DEFAULT_RX_CNTRL0 | RX_CNTRL0_ADDR_FLTR_EN,
+			&port->regs->rx_control[0]);
+		return;
+	}
 
 	if ((dev->flags & IFF_PROMISC) || netdev_mc_empty(dev)) {
 		__raw_writel(DEFAULT_RX_CNTRL0 & ~RX_CNTRL0_ADDR_FLTR_EN,
-- 
1.6.3.3
