From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:39:20 +0100
Subject: [RFC 01/24] SERIAL: omap: fix set_mctrl() breakage
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKTf6-0002mO-Oj@rmk-PC.arm.linux.org.uk>
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
index d3cda0c..0a50669 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -488,7 +488,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned char mcr = 0;
+	unsigned char mcr = 0, old_mcr;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
 	if (mctrl & TIOCM_RTS)
@@ -503,8 +503,10 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	pm_runtime_get_sync(&up->pdev->dev);
-	up->mcr = serial_in(up, UART_MCR);
-	up->mcr |= mcr;
+	old_mcr = serial_in(up, UART_MCR);
+	old_mcr &= ~(UART_MCR_LOOP | UART_MCR_OUT2 | UART_MCR_OUT1 |
+		     UART_MCR_DTR | UART_MCR_RTS);
+	up->mcr = old_mcr | mcr;
 	serial_out(up, UART_MCR, up->mcr);
 	pm_runtime_put(&up->pdev->dev);
 }
-- 
1.7.4.4
