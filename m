From: balbi@ti.com (Felipe Balbi)
Date: Thu,  6 Sep 2012 15:45:25 +0300
Subject: [PATCH v4 06/21] serial: omap: move THRE check to transmit_chars()
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Message-ID: <1346935540-1792-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

since all other IRQ types now do all necessary
checks inside their handlers, transmit_chars()
was the only one left expecting serial_omap_irq()
to check THRE for it. We can move THRE check to
transmit_chars() in order to make serial_omap_irq()
more uniform.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9c0a4ae..d3fbb70 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -196,11 +196,14 @@ static void serial_omap_stop_rx(struct uart_port *port)
 	pm_runtime_put_autosuspend(up->dev);
 }
 
-static void transmit_chars(struct uart_omap_port *up)
+static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 {
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int count;
 
+	if (!(lsr & UART_LSR_THRE))
+		return;
+
 	if (up->port.x_char) {
 		serial_out(up, UART_TX, up->port.x_char);
 		up->port.icount.tx++;
@@ -370,8 +373,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			check_modem_status(up);
 			break;
 		case UART_IIR_THRI:
-			if (lsr & UART_LSR_THRE)
-				transmit_chars(up);
+			transmit_chars(up, lsr);
 			break;
 		case UART_IIR_RX_TIMEOUT:
 			/* FALLTHROUGH */
-- 
1.7.12.rc3
