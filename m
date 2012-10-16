From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 12:00:46 +0100
Subject: [PATCH 09/11] SERIAL: omap: fix set_mctrl() breakage
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4tC-0000WV-Es@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

c538d20c7f (and maybe previous commits) broke set_mctrl() by making
it only capable of setting bits in the MCR register.  This prevents
software controlled flow control and modem control line manipulation
via TIOCMSET/TIOCMBIC from working correctly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c8a0425..537829f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -504,7 +504,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
-	unsigned char mcr = 0;
+	unsigned char mcr = 0, old_mcr;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
 	if (mctrl & TIOCM_RTS)
@@ -519,8 +519,10 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	pm_runtime_get_sync(up->dev);
-	up->mcr = serial_in(up, UART_MCR);
-	up->mcr |= mcr;
+	old_mcr = serial_in(up, UART_MCR);
+	old_mcr &= ~(UART_MCR_LOOP | UART_MCR_OUT2 | UART_MCR_OUT1 |
+		     UART_MCR_DTR | UART_MCR_RTS);
+	up->mcr = old_mcr | mcr;
 	serial_out(up, UART_MCR, up->mcr);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
-- 
1.7.4.4
