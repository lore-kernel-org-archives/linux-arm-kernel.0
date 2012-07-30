From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 30 Jul 2012 04:58:14 -0700
Subject: [PATCH 05/11] tty/serial/amba-pl011: Implement clear_irqs callback
In-Reply-To: <20120730115719.GA5742@lizard>
References: <20120730115719.GA5742@lizard>
Message-ID: <1343649500-18491-5-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's all pretty straightforward, except for TXIM interrupt. The interrupt
has meaning "ready to transmit", so it's almost always raised, and the
only way to silence it is to mask it. But that's OK, ops->start_tx will
unmask it.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c17923e..378d26b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1308,6 +1308,18 @@ static void pl010_put_poll_char(struct uart_port *port,
 	writew(ch, uap->port.membase + UART01x_DR);
 }
 
+static void pl010_clear_irqs(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	unsigned char __iomem *regs = uap->port.membase;
+
+	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
+	/*
+	 * There is no way to clear TXIM, this is "ready to transmit IRQ", so
+	 * we simply mask it. ops->start_tx will unmask it.
+	 */
+	writew(readw(regs + UART011_IMSC) & ~UART011_TXIM, regs + UART011_IMSC);
+}
 #endif /* CONFIG_CONSOLE_POLL */
 
 static int pl011_startup(struct uart_port *port)
@@ -1698,6 +1710,7 @@ static struct uart_ops amba_pl011_pops = {
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char = pl010_get_poll_char,
 	.poll_put_char = pl010_put_poll_char,
+	.clear_irqs    = pl010_clear_irqs,
 #endif
 };
 
-- 
1.7.10.4
