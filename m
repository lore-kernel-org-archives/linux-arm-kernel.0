From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  3 Nov 2009 11:47:15 +0100
Subject: [PATCH] [ARM] serial/pxa: work around Errata #75
Message-ID: <1257245235-14783-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Intel(R) PXA27x Processor Family Specification Update (Nov 2005)
says:

  E75. UART: Baud rate may not be programmed correctly on
       back-to-back writes.

  Problem:
  When programming the Divisor Latch registers, Low and High (DLL and
  DLH), with back-to-back writes, the second register write may not
  take effect. The result is an incorrect baud rate.

  Workaround:
  After programming the first Divisor Latch register, read and verify
  it before programming the second Divisor Latch register.

This was hit when changing the baud rate from 115200 to 9600 while
receiving characters at 9600 Bd.

And fixed indention of some comments nearby.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Mike Rapoport <mike@compulab.co.il>
---
 drivers/serial/pxa.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
index b8629d7..4a82104 100644
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -438,6 +438,7 @@ serial_pxa_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
 	unsigned int baud, quot;
+	unsigned int dll;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -534,10 +535,18 @@ serial_pxa_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->mcr &= ~UART_MCR_AFE;
 
-	serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+	serial_out(up, UART_LCR, cval | UART_LCR_DLAB);	/* set DLAB */
 	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */
+
+	/*
+	 * work around Errata #75 according to Intel(R) PXA27x Processor Family
+	 * Specification Update (Nov 2005)
+	 */
+	dll = serial_in(up, UART_DLL);
+	WARN_ON(dll != (quot & 0xff));
+
 	serial_out(up, UART_DLM, quot >> 8);		/* MS of divisor */
-	serial_out(up, UART_LCR, cval);		/* reset DLAB */
+	serial_out(up, UART_LCR, cval);			/* reset DLAB */
 	up->lcr = cval;					/* Save LCR */
 	serial_pxa_set_mctrl(&up->port, up->port.mctrl);
 	serial_out(up, UART_FCR, fcr);
-- 
1.6.5.2
