From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Aug 2012 13:32:48 +0300
Subject: [PATCH v3 08/23] serial: omap: move THRE check to transmit_chars()
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Message-ID: <1345717983-18179-9-git-send-email-balbi@ti.com>
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
index e55f9f1..50ba51e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -195,11 +195,14 @@ static void serial_omap_stop_rx(struct uart_port *port)
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
@@ -369,8 +372,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
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
