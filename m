From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri,  5 Sep 2014 21:02:42 +0200
Subject: [PATCH 07/18] tty: serial: 8250_core: remove UART_IER_RDI in
 serial8250_stop_rx()
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1409943773-7874-8-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

serial8250_do_startup() adds UART_IER_RDI and UART_IER_RLSI to ier.
serial8250_stop_rx() should remove both.
This is what the serial-omap driver has been doing and is now moved to
the 8250-core since it does no look to be *that* omap specific.

Cc: heikki.krogerus at linux.intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 8f5fb81d5fad..e8df7cd85ba7 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1389,7 +1389,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	up->ier &= ~UART_IER_RLSI;
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_port_out(port, UART_IER, up->ier);
 
-- 
2.1.0
