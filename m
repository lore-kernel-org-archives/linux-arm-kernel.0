From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 16:55:38 +0100
Subject: [PATCH 04/14] net: axienet: Handle 0 packet receive gracefully
In-Reply-To: <cover.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
Message-ID: <f360a8bd55e2ec2b24f48acd4e85ef48ac46d55b.1392220536.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

The AXI-DMA rx-delay interrupt can sometimes be triggered when there are 0
outstanding packets received. This is due to the fact that the receive function
will greedily consume as many packets as possible on interrupt. So if two
packets (with a very particular timing) arrive in succession they will each
cause the rx-delay interrupt, but the first interrupt will consume both packets.
This means the second interrupt is a 0 packet receive.

This is mostly OK, except that the tail pointer register is updated
unconditionally on receive. Currently the tail pointer is always set to the
current bd-ring descriptor under the assumption that the hardware has moved onto
the next descriptor. What this means for length 0 recv is the current descriptor
that the hardware is potentially yet to use will be marked as the tail. This
causes the hardware to think its run out of descriptors deadlocking the whole rx
path.

Fixed by updating the tail pointer to the most recent successfully consumed
descriptor.

Reported-by: Wendy Liang <wendy.liang@xilinx.com>
Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Jason Wu <huanyu@xilinx.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 3966d83..2e21ab2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -726,15 +726,15 @@ static void axienet_recv(struct net_device *ndev)
 	u32 csumstatus;
 	u32 size = 0;
 	u32 packets = 0;
-	dma_addr_t tail_p;
+	dma_addr_t tail_p = 0;
 	struct axienet_local *lp = netdev_priv(ndev);
 	struct sk_buff *skb, *new_skb;
 	struct axidma_bd *cur_p;

-	tail_p = lp->rx_bd_p + sizeof(*lp->rx_bd_v) * lp->rx_bd_ci;
 	cur_p = &lp->rx_bd_v[lp->rx_bd_ci];

 	while ((cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
+		tail_p = lp->rx_bd_p + sizeof(*lp->rx_bd_v) * lp->rx_bd_ci;
 		skb = (struct sk_buff *) (cur_p->sw_id_offset);
 		length = cur_p->app4 & 0x0000FFFF;

@@ -786,7 +786,8 @@ static void axienet_recv(struct net_device *ndev)
 	ndev->stats.rx_packets += packets;
 	ndev->stats.rx_bytes += size;

-	axienet_dma_out32(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
+	if (tail_p)
+		axienet_dma_out32(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 }

 /**
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/e6875092/attachment.sig>
