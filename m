From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Fri, 24 Aug 2018 14:24:17 +0000
Subject: [PATCH] tty: pl011:write to TXFIFO may miss some characters form
 interrupt routine
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F95F68@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Write to TXFIFO form interrupt routine is not check
the UART01x_FR_TXFF bit.
However the writing will not stop until circ_buf(xmit) become empty.
So when writing to TXFIFO, UART01x_FR_TXFF bit maybe set.
The result is miss some characters form interrupt routine.

Below is my patch to fix this problem.

---
amba-pl011.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-) 

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b40a5b..9ca9f37 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1380,8 +1380,8 @@ __acquires(&uap->port.lock)
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
                          bool from_irq)
 {
-       if (unlikely(!from_irq) &&
-           pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
+       /* Even from irq routine, we need to check UART01x_FR_TXFF bit */
+       if ( pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
                return false; /* unable to transmit character */

        pl011_write(c, uap, REG_DR);

Best Regards,
Lei Zhang
zhang.lei at jp.fujitsu.com
