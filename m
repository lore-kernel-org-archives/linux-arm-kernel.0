From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  5 May 2015 11:14:15 +0800
Subject: [PATCH RESEND] serial/amba-pl011: fix minor bugs for pio mode
Message-ID: <1430795655-22428-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When use pio mode, there have two issues can be observed:

- In the commit f2ee6df "serial/amba-pl011: Leave the TX IRQ alone when
  the UART is not open", it will skip clearing the TX IRQ across
  pl011_shutdown() and pl011_startup(); So at the next time after the
  uart port has been opened, there have chance for the function
  pl011_tx_chars() will not be executed if the TX IRQ will not be
  triggered; finally the console cannot output anymore.

  This is caused by the uart FIFO still keep data rather than
  the threshold. So revert this patch to make sure every time open the
  uart port, it will force to call function pl011_tx_chars().

- Sometimes will output the duplicate chars. Function pl011_tx_char()
  will firstly send char and check if FIFO is full, and if the FIFO is
  full it will return false; Caller function will consider the char
  has _NOT_ been send out and resend it again, finally will send the
  duplicate chars. So change to check FIFO is full or not, if full then
  return false, otherwise send out char and return true.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5a4e9d5..9d9ac76 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1249,20 +1249,19 @@ __acquires(&uap->port.lock)
 
 /*
  * Transmit a character
- * There must be at least one free entry in the TX FIFO to accept the char.
  *
- * Returns true if the FIFO might have space in it afterwards;
- * returns false if the FIFO definitely became full.
+ * Before send character, need check FIFO is full or not;
+ * If FIFO is full, will not send char and return false,
+ * otherwise send out character and return ture.
  */
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
 {
+	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		return false;
+
 	writew(c, uap->port.membase + UART01x_DR);
 	uap->port.icount.tx++;
-
-	if (likely(uap->tx_irq_seen > 1))
-		return true;
-
-	return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
+	return true;
 }
 
 static bool pl011_tx_chars(struct uart_amba_port *uap)
@@ -1639,6 +1638,9 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
+	/* Assume that TX IRQ doesn't work until we see one: */
+	uap->tx_irq_seen = 0;
+
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
@@ -1702,7 +1704,7 @@ static void pl011_shutdown(struct uart_port *port)
 	spin_lock_irq(&uap->port.lock);
 	uap->im = 0;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
+	writew(0xffff, uap->port.membase + UART011_ICR);
 	spin_unlock_irq(&uap->port.lock);
 
 	pl011_dma_shutdown(uap);
-- 
1.9.1
