From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 12 May 2015 14:44:26 +0100
Subject: [PATCH] serial/amba-pl011: Unconditionally poll for FIFO space before
 each TX char
Message-ID: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 734745caeb9f155ab58918834a8c70e83fa6afd3 serial/amba-pl011:
(Activate TX IRQ passively) introduces a race which causes the driver
sometimes to attempt to write a character to the TX FIFO when the FIFO
is already full.

The PL011 does not guarantee its behaviour when the FIFO is overfilled.
In practice, this can cause duplicate and/or dropped characters to be
output on the wire.  The problem is common enough to be readily
observable on the ARM Juno platform when the PL011 UART is used as
the console and DMA is not in use.

This patch fixes this problem by always polling for space before each
character is written to the FIFO.

This will be amended to a less brute-force approach in a later commit,
but this patch should help ensure correct behaviour for now.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

The patch is based on gregkh/tty.git tty-linus.

Please consider applying it for v4.1.  Without it, we have a regression
compared with v4.0.

*Note*
This will cause a conflict with tty-next because it pulls forward
some changes made by commit 1e84d22 (serial/amba-pl011: Refactor and
simplify TX FIFO handling); however, the resolution is simple except
for the following lines which may need to be deleted manually from
amba-pl011.c:pl011_startup():

-8<-
	/* Assume that TX IRQ doesn't work until we see one: */
	uap->tx_irq_seen = 0;

->8-

(This is is the same mismerge already observed by Steven Rothwell when
building next.)

Cheers
---Dave


 drivers/tty/serial/amba-pl011.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6f5a072..763eb20 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1249,20 +1249,19 @@ __acquires(&uap->port.lock)
 
 /*
  * Transmit a character
- * There must be at least one free entry in the TX FIFO to accept the char.
  *
- * Returns true if the FIFO might have space in it afterwards;
- * returns false if the FIFO definitely became full.
+ * Returns true if the character was successfully queued to the FIFO.
+ * Returns false otherwise.
  */
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
 {
+	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		return false; /* unable to transmit character */
+
 	writew(c, uap->port.membase + UART01x_DR);
 	uap->port.icount.tx++;
 
-	if (likely(uap->tx_irq_seen > 1))
-		return true;
-
-	return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
+	return true;
 }
 
 static bool pl011_tx_chars(struct uart_amba_port *uap)
@@ -1296,7 +1295,8 @@ static bool pl011_tx_chars(struct uart_amba_port *uap)
 		return false;
 
 	if (uap->port.x_char) {
-		pl011_tx_char(uap, uap->port.x_char);
+		if (!pl011_tx_char(uap, uap->port.x_char))
+			goto done;
 		uap->port.x_char = 0;
 		--count;
 	}
-- 
1.7.10.4
