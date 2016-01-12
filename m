From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 11 Jan 2016 17:41:39 -0800
Subject: [PATCH LINUX 4/6] tty: xuartps: Improve sysrq handling
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1452562901-17848-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling magic sysrq included dropping a lock to avoid a deadlock that
happened when cdns_uart_console_write tried to acquire a lock in the
from the sysrq code path. By making the acquisition of the lock in
cdns_uart_console_write depending on port->sysrq, cdns_uart_handle_rx can be
simplified to simply call uart_handle_sysrq.

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v4:
 - added this patch
---
 drivers/tty/serial/xilinx_uartps.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8014dd3c6d55..0eecba88298f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -220,20 +220,8 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 				continue;
 		}
 
-#ifdef SUPPORT_SYSRQ
-		/*
-		 * uart_handle_sysrq_char() doesn't work if
-		 * spinlocked, for some reason
-		 */
-		 if (port->sysrq) {
-			spin_unlock(&port->lock);
-			if (uart_handle_sysrq_char(port, data)) {
-				spin_lock(&port->lock);
-				continue;
-			}
-			spin_lock(&port->lock);
-		}
-#endif
+		if (uart_handle_sysrq_char(port, data))
+			continue;
 
 		port->icount.rx++;
 
@@ -1128,7 +1116,9 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	unsigned int imr, ctrl;
 	int locked = 1;
 
-	if (oops_in_progress)
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.7.0.3.g497ea1e
