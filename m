From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Oct 2014 18:45:27 +0800
Subject: [PATCH 7/7] can: m_can: workaround for transmit data less than 4 bytes
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <1414579527-31100-7-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We meet an IC issue that we have to write the full 8 bytes (whatever
value for the second word) in Message RAM to avoid bit error for transmit
data less than 4 bytes.

Without the workaround, we can easily see the following errors:
root at imx6qdlsolo:~# ip link set can0 up type can bitrate 1000000
[   66.882520] IPv6: ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
root at imx6qdlsolo:~# cansend can0 123#112233
[   66.935640] m_can 20e8000.can can0: Bit Error Uncorrected

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/net/can/m_can/m_can.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 219e0e3..f2d9ebe 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1058,10 +1058,19 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
 	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16);
 
-	for (i = 0; i < cf->len; i += 4)
+	for (i = 0; i < cf->len; i += 4) {
 		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
 				 *(u32 *)(cf->data + i));
 
+		/* FIXME: we meet an IC issue that we have to write the full 8
+		 * bytes (whatever value for the second word) in Message RAM to
+		 * avoid bit error for transmit data less than 4 bytes
+		 */
+		if (cf->len <= 4)
+			m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4 + 1),
+					 0x0);
+	}
+
 	can_put_echo_skb(skb, dev, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-- 
1.9.1
