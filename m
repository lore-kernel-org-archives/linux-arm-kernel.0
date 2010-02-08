From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 8 Feb 2010 19:11:50 +0530
Subject: [PATCH] amba-pl011: support hardware flow control
Message-ID: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable/disable hardware flow control as requested by the termios.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/serial/amba-pl011.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index ef7adc8..6f37db4 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -532,6 +532,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	old_cr = readw(port->membase + UART011_CR);
 	writew(0, port->membase + UART011_CR);
 
+	if (termios->c_cflag & CRTSCTS)
+		old_cr |= UART011_CR_CTSEN | UART011_CR_RTSEN;
+	else
+		old_cr &= ~(UART011_CR_CTSEN | UART011_CR_RTSEN);
+
 	/* Set baud rate */
 	writew(quot & 0x3f, port->membase + UART011_FBRD);
 	writew(quot >> 6, port->membase + UART011_IBRD);
-- 
1.6.5.3
