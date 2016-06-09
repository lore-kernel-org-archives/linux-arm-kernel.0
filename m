From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 9 Jun 2016 20:40:35 +0530
Subject: [PATCH 4/8] tty: serial: fsl_lpuart: Fix broken 8m/s1 support
In-Reply-To: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20160609151039.20817-5-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default the driver always configure the mode as 8s1 even when 8m1
mode is selected. Fix this by adding support to control the space/mark bit.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 97c1fda..615f191 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1220,13 +1220,14 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char cr1, old_cr1, old_cr2, cr4, bdh, modem;
+	unsigned char cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned int sbr, brfa;
 
 	cr1 = old_cr1 = readb(sport->port.membase + UARTCR1);
 	old_cr2 = readb(sport->port.membase + UARTCR2);
+	cr3 = readb(sport->port.membase + UARTCR3);
 	cr4 = readb(sport->port.membase + UARTCR4);
 	bdh = readb(sport->port.membase + UARTBDH);
 	modem = readb(sport->port.membase + UARTMODEM);
@@ -1274,7 +1275,10 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & PARENB)) {
 		if (termios->c_cflag & CMSPAR) {
 			cr1 &= ~UARTCR1_PE;
-			cr1 |= UARTCR1_M;
+			if (termios->c_cflag & PARODD)
+				cr3 |= UARTCR3_T8;
+			else
+				cr3 &= ~UARTCR3_T8;
 		} else {
 			cr1 |= UARTCR1_PE;
 			if ((termios->c_cflag & CSIZE) == CS8)
@@ -1342,6 +1346,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	writeb(cr4 | brfa, sport->port.membase + UARTCR4);
 	writeb(bdh, sport->port.membase + UARTBDH);
 	writeb(sbr & 0xFF, sport->port.membase + UARTBDL);
+	writeb(cr3, sport->port.membase + UARTCR3);
 	writeb(cr1, sport->port.membase + UARTCR1);
 	writeb(modem, sport->port.membase + UARTMODEM);
 
-- 
2.8.3
