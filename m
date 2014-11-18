From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Tue, 18 Nov 2014 18:37:13 +0100
Subject: [PATCH] serial: mxs-auart: fix tx_empty against shift register
Message-ID: <1416332233-4143-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tx_empty() should test whether both the transmitter fifo and shifter
for the port is empty, ie. the whole last char was transmitted.
The shift register is empty if AUART_STAT_BUSY is cleared.
The patch fixes the function against the shift register.

According to i.MX23 and i.MX28 Reference Manual:
AUART_STAT_TXFE:
 TX FIFO or transmit holding register is empty.

AUART_STAT_BUSY:
 AUART still transmits bits.
 The BUSY signal goes HIGH as soon as the data is written to the
 transmit FIFO (that is, the FIFO is non-empty) and remains asserted
 HIGH while data is being transmitted.
 BUSY is negated only when the transmit FIFO is empty, and the last
 character has been transmitted from the shift register, including
 the stop bits.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 5ad18bd..4422dbb 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -889,10 +889,11 @@ static void mxs_auart_shutdown(struct uart_port *u)
 
 static unsigned int mxs_auart_tx_empty(struct uart_port *u)
 {
-	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
+	if ((readl(u->membase + AUART_STAT) &
+		 (AUART_STAT_TXFE | AUART_STAT_BUSY)) == AUART_STAT_TXFE)
 		return TIOCSER_TEMT;
-	else
-		return 0;
+
+	return 0;
 }
 
 static void mxs_auart_start_tx(struct uart_port *u)
-- 
1.7.11.3
