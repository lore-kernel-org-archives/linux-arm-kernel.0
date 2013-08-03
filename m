From: shijie8@gmail.com (Huang Shijie)
Date: Sat,  3 Aug 2013 10:09:15 -0400
Subject: [PATCH v3 2/3] serial: mxs: remove the MXS_AUART_DMA_CONFIG
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Message-ID: <1375538956-15862-3-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MXS_AUART_DMA_CONFIG is originally used to check if the DT node
is configured with the DMA property.

But now, the MXS_AUART_DMA_CONFIG is set unconditionally in the
serial_mxs_probe_dt(), so the check in the mxs_auart_settermios() is
not necessary anymore. This patch removes this macro.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/tty/serial/mxs-auart.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index eac7b58..10e9d70 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -133,7 +133,6 @@ enum mxs_auart_type {
 struct mxs_auart_port {
 	struct uart_port port;
 
-#define MXS_AUART_DMA_CONFIG	0x1
 #define MXS_AUART_DMA_ENABLED	0x2
 #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
@@ -640,7 +639,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * we can only implement the DMA support for auart
 		 * in mx28.
 		 */
-		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)
+		if (is_imx28_auart(s)
 				&& test_bit(MXS_AUART_RTSCTS, &s->flags)) {
 			if (!mxs_auart_dma_init(s))
 				/* enable DMA tranfer */
@@ -1009,8 +1008,6 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	s->flags |= MXS_AUART_DMA_CONFIG;
-
 	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
 		set_bit(MXS_AUART_RTSCTS, &s->flags);
 
-- 
1.7.4.4
