From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 18 Nov 2014 19:00:54 +0800
Subject: [PATCH V5 1/2] can: m_can: fix not set can_dlc for remote frame
Message-ID: <1416308455-29134-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code missed to set the cf->can_dlc in the RTR case, so add it.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/net/can/m_can/m_can.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 06541f1..2f61676 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -331,7 +331,7 @@ static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
 			    u32 rxfs)
 {
 	struct m_can_priv *priv = netdev_priv(dev);
-	u32 id, fgi;
+	u32 id, fgi, dlc;
 
 	/* calculate the fifo get index for where to read data */
 	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
@@ -341,11 +341,12 @@ static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
 	else
 		cf->can_id = (id >> 18) & CAN_SFF_MASK;
 
+	dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
+	cf->can_dlc = get_can_dlc((dlc >> 16) & 0x0F);
+
 	if (id & RX_BUF_RTR) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
-		id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
-		cf->can_dlc = get_can_dlc((id >> 16) & 0x0F);
 		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi,
 							 M_CAN_FIFO_DATA(0));
 		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi,
-- 
1.9.1
