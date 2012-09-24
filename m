From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 24 Sep 2012 14:27:55 -0700
Subject: [PATCH 06/11] tty/serial/amba-pl011: Quiesce interrupts in
 poll_get_char
In-Reply-To: <20120924212648.GA27605@lizard>
References: <20120924212648.GA27605@lizard>
Message-ID: <1348522080-32629-6-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to quiesce interrupts in the poll_get_char routine, otherwise,
if used with KGDB NMI debugger, we'll keep reentering the NMI.

Quiescing interrupts is pretty straightforward, except for TXIM
interrupt. The interrupt has "ready to transmit" meaning, so it's
almost always raised, and the only way to silence it is to mask it. But
that's OK, ops->start_tx will unmask it.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Acked-by: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/amba-pl011.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 45137e4..459f8ba 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1284,11 +1284,40 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+
+static void pl011_quiesce_irqs(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	unsigned char __iomem *regs = uap->port.membase;
+
+	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
+	/*
+	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
+	 * we simply mask it. start_tx() will unmask it.
+	 *
+	 * Note we can race with start_tx(), and if the race happens, the
+	 * polling user might get another interrupt just after we clear it.
+	 * But it should be OK and can happen even w/o the race, e.g.
+	 * controller immediately got some new data and raised the IRQ.
+	 *
+	 * And whoever uses polling routines assumes that it manages the device
+	 * (including tx queue), so we're also fine with start_tx()'s caller
+	 * side.
+	 */
+	writew(readw(regs + UART011_IMSC) & ~UART011_TXIM, regs + UART011_IMSC);
+}
+
 static int pl011_get_poll_char(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status;
 
+	/*
+	 * The caller might need IRQs lowered, e.g. if used with KDB NMI
+	 * debugger.
+	 */
+	pl011_quiesce_irqs(port);
+
 	status = readw(uap->port.membase + UART01x_FR);
 	if (status & UART01x_FR_RXFE)
 		return NO_POLL_CHAR;
-- 
1.7.12
