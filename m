From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri, 13 Oct 2017 11:01:52 +0200
Subject: [PATCH v2 08/16] serial: mvebu-uart: clear state register before IRQ
 request
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Message-ID: <20171013090200.31034-9-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Allen Yan <yanwei@marvell.com>

When receiving data on RX pin before ->uart_startup() is called, some
error bits in the state register could be set up (like BRK_DET).

This is harmless when using only the standard UART (error bits are
read-only), but may procude an endless loop once in the extended UART
RX interrupt handler (error bits must be cleared).

Clear the status register in ->uart_startup() to avoid this situation.

Signed-off-by: Allen Yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 5767196ec0a9..6bd0c40008bb 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -322,6 +322,12 @@ static int mvebu_uart_startup(struct uart_port *port)
 	writel(CTRL_TXFIFO_RST | CTRL_RXFIFO_RST,
 	       port->membase + UART_CTRL(port));
 	udelay(1);
+
+	/* Clear the error bits of state register before IRQ request */
+	ret = readl(port->membase + UART_STAT);
+	ret |= STAT_BRK_ERR;
+	writel(ret, port->membase + UART_STAT);
+
 	writel(CTRL_BRK_INT, port->membase + UART_CTRL(port));
 
 	ctl = readl(port->membase + UART_INTR(port));
-- 
2.11.0
