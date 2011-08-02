From: simon.budig@kernelconcepts.de (Simon Budig)
Date: Tue,  2 Aug 2011 20:57:46 +0200
Subject: [PATCH] Fix logic of tx_empty.
In-Reply-To: <1312311466-3814-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1312311466-3814-1-git-send-email-simon.budig@kernelconcepts.de>
Message-ID: <1312311466-3814-2-git-send-email-simon.budig@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Budig <simon@budig.de>

   test for TX-FIFO *not empty* instead of TX-FIFO full.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 drivers/tty/serial/amba-pl011.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 05eb292..a23b419 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -792,7 +792,7 @@ static unsigned int pl01x_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status = readw(uap->port.membase + UART01x_FR);
-	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
+	return (status & UART01x_FR_BUSY) || !(status & UART011_FR_TXFE) ? 0 : TIOCSER_TEMT;
 }
 
 static unsigned int pl01x_get_mctrl(struct uart_port *port)
-- 
1.7.0.4
