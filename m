From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 16 Jan 2015 13:49:25 +0100
Subject: [PATCH] tty: xuartps: Fix RX hang, and TX corruption in termios call
Message-ID: <688e4e2492ef33cc5ab0e33b8f9878735ee3c43a.1421412563.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nathan Rossi <nathan.rossi@xilinx.com>

The implementation of flushing the RX FIFO breaks in a number of cases,
it is impossible to ensure an complete flush of the RX FIFO due to the
hardware not allowing the use of the FIFOs when the receiver is disabled
(Reading from the FIFO register does not remove it from the FIFO when
the RX_EN=0 or RX_DIS=1). Additionally during an initial set_termios
call where RX_DIS=1 causes a hang waiting forever for the RX FIFO to
empty. On top of this the FIFO will be cleared by the use of the RXRST
bits on the Control Register, making the RX flush pointless (as it does
not preserve the data read anyway).

Due to the TXRST the TX FIFO and transmitter can be interrupted during
frame trasmission, causing corruption and additionally data lost in the
FIFO. Most other serial drivers do not flush or clear the FIFOs during
a termios configuration change and as such do not have issues with
corruption. For this UART controller is it required that the TXRST/RXRST
bit be flagged during the change, this means that the data in the FIFO
will be dropped when changing configuration. In order to prevent data
loss and corruption of the transmitted data, wait until the TX FIFO is
empty before changing the configuration. The performance of this may
cause the set_termios call to take a longer amount of time especially
on lower baud rates, however it is comparable to the same performance
hit that a console_write call costs.

Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
Acked-by: Anirudha Sarangi <anirudh@xilinx.com>
Acked-by: Harini Katakam <harinik@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 542bab37e502..cff531a51a78 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -637,10 +637,12 @@ static void cdns_uart_set_termios(struct uart_port *port,

 	spin_lock_irqsave(&port->lock, flags);

-	/* Empty the receive FIFO 1st before making changes */
-	while ((cdns_uart_readl(CDNS_UART_SR_OFFSET) &
-		 CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
-		cdns_uart_readl(CDNS_UART_FIFO_OFFSET);
+	/* Wait for the transmit FIFO to empty before making changes */
+	if (!(cdns_uart_readl(CDNS_UART_CR_OFFSET) & CDNS_UART_CR_TX_DIS)) {
+		while (!(cdns_uart_readl(CDNS_UART_SR_OFFSET) &
+				CDNS_UART_SR_TXEMPTY)) {
+			cpu_relax();
+		}
 	}

 	/* Disable the TX and RX to set baud rate */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/44583ac9/attachment.sig>
