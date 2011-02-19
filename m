From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 19 Feb 2011 21:17:24 +0100
Subject: [PATCH 2/2] pl011: factor our FIFO to TTY code
Message-ID: <1298146644-31007-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This piece of code was just slightly different between the DMA
and IRQ paths, in DMA mode we surely shouldn't read more than
256 character either, so factor this out in its own function and
use for both DMA and PIO mode.

Tested on Ux500 and U300.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |  157 ++++++++++++++++----------------------
 1 files changed, 66 insertions(+), 91 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cb45136..faa16ee 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -144,6 +144,62 @@ struct uart_amba_port {
 };
 
 /*
+ * Reads up to 256 characters from the FIFO or until it's empty and
+ * inserts them into the TTY layer. Returns the number of characters
+ * read from the FIFO.
+ */
+static int pl011_fifo_to_tty(struct uart_amba_port *uap)
+{
+	u16 status, ch;
+	unsigned int flag, max_count = 256;
+	int fifotaken = 0;
+
+	while (max_count--) {
+		status = readw(uap->port.membase + UART01x_FR);
+		if (status & UART01x_FR_RXFE)
+			break;
+
+		/* Take chars from the FIFO and update status */
+		ch = readw(uap->port.membase + UART01x_DR) |
+			UART_DUMMY_DR_RX;
+		flag = TTY_NORMAL;
+		uap->port.icount.rx++;
+		fifotaken++;
+
+		if (unlikely(ch & UART_DR_ERROR)) {
+			if (ch & UART011_DR_BE) {
+				ch &= ~(UART011_DR_FE | UART011_DR_PE);
+				uap->port.icount.brk++;
+				if (uart_handle_break(&uap->port))
+					continue;
+			} else if (ch & UART011_DR_PE)
+				uap->port.icount.parity++;
+			else if (ch & UART011_DR_FE)
+				uap->port.icount.frame++;
+			if (ch & UART011_DR_OE)
+				uap->port.icount.overrun++;
+
+			ch &= uap->port.read_status_mask;
+
+			if (ch & UART011_DR_BE)
+				flag = TTY_BREAK;
+			else if (ch & UART011_DR_PE)
+				flag = TTY_PARITY;
+			else if (ch & UART011_DR_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (uart_handle_sysrq_char(&uap->port, ch & 255))
+			continue;
+
+		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
+	}
+
+	return fifotaken;
+}
+
+
+/*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
  * no custom DMA interfaces are supported.
@@ -634,7 +690,6 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 	struct pl011_sgbuf *sgbuf = use_buf_b ?
 		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
 	struct device *dev = uap->dmarx.chan->device->dev;
-	unsigned int status, ch, flag;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -671,56 +726,16 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 		/*
 		 * If we read all the DMA'd characters, and we had an
-		 * incomplete buffer, that could be due to an rx error,
-		 * or maybe we just timed out. Read any pending chars
-		 * and check the error status.
+		 * incomplete buffer, that could be due to an rx error, or
+		 * maybe we just timed out. Read any pending chars and check
+		 * the error status.
+		 *
+		 * Error conditions will only occur in the FIFO, these will
+		 * trigger an immediate interrupt and stop the DMA job, so we
+		 * will always find the error in the FIFO, never in the DMA
+		 * buffer.
 		 */
-		while (1) {
-			status = readw(uap->port.membase + UART01x_FR);
-			if (status & UART01x_FR_RXFE)
-				break;
-
-			/* Take chars from the FIFO and update status */
-			ch = readw(uap->port.membase + UART01x_DR) |
-			       UART_DUMMY_DR_RX;
-			flag = TTY_NORMAL;
-			uap->port.icount.rx++;
-			fifotaken++;
-
-			/*
-			 * Error conditions will only occur in the FIFO,
-			 * these will trigger an immediate interrupt and
-			 * stop the DMA job, so we will always find the
-			 * error in the FIFO, never in the DMA buffer.
-			 */
-			if (unlikely(ch & UART_DR_ERROR)) {
-				if (ch & UART011_DR_BE) {
-					ch &= ~(UART011_DR_FE | UART011_DR_PE);
-					uap->port.icount.brk++;
-					if (uart_handle_break(&uap->port))
-						continue;
-				} else if (ch & UART011_DR_PE)
-					uap->port.icount.parity++;
-				else if (ch & UART011_DR_FE)
-					uap->port.icount.frame++;
-				if (ch & UART011_DR_OE)
-					uap->port.icount.overrun++;
-
-				ch &= uap->port.read_status_mask;
-
-				if (ch & UART011_DR_BE)
-					flag = TTY_BREAK;
-				else if (ch & UART011_DR_PE)
-					flag = TTY_PARITY;
-				else if (ch & UART011_DR_FE)
-					flag = TTY_FRAME;
-			}
-
-			if (uart_handle_sysrq_char(&uap->port, ch & 255))
-				continue;
-
-			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
-		}
+		fifotaken = pl011_fifo_to_tty(uap);
 	}
 
 	spin_unlock(&uap->port.lock);
@@ -1036,49 +1051,9 @@ static void pl011_enable_ms(struct uart_port *port)
 static void pl011_rx_chars(struct uart_amba_port *uap)
 {
 	struct tty_struct *tty = uap->port.state->port.tty;
-	unsigned int status, ch, flag, max_count = 256;
 
-	status = readw(uap->port.membase + UART01x_FR);
-	while ((status & UART01x_FR_RXFE) == 0 && max_count--) {
-		ch = readw(uap->port.membase + UART01x_DR) | UART_DUMMY_DR_RX;
-		flag = TTY_NORMAL;
-		uap->port.icount.rx++;
+	pl011_fifo_to_tty(uap);
 
-		/*
-		 * Note that the error handling code is
-		 * out of the main execution path
-		 */
-		if (unlikely(ch & UART_DR_ERROR)) {
-			if (ch & UART011_DR_BE) {
-				ch &= ~(UART011_DR_FE | UART011_DR_PE);
-				uap->port.icount.brk++;
-				if (uart_handle_break(&uap->port))
-					goto ignore_char;
-			} else if (ch & UART011_DR_PE)
-				uap->port.icount.parity++;
-			else if (ch & UART011_DR_FE)
-				uap->port.icount.frame++;
-			if (ch & UART011_DR_OE)
-				uap->port.icount.overrun++;
-
-			ch &= uap->port.read_status_mask;
-
-			if (ch & UART011_DR_BE)
-				flag = TTY_BREAK;
-			else if (ch & UART011_DR_PE)
-				flag = TTY_PARITY;
-			else if (ch & UART011_DR_FE)
-				flag = TTY_FRAME;
-		}
-
-		if (uart_handle_sysrq_char(&uap->port, ch & 255))
-			goto ignore_char;
-
-		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
-
-	ignore_char:
-		status = readw(uap->port.membase + UART01x_FR);
-	}
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(tty);
 	/*
-- 
1.7.3.2
