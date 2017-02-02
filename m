From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:56 +0100
Subject: [PATCH 06/23] tty/serial: atmel: ensure state is restored after
 suspending
In-Reply-To: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
References: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202185213.21698-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When going to suspend, the UART registers may be lost because the power to
VDDcore is cut. This is not an issue in the normal case but when
no_console_suspend is used, we need to restore the registers in order to
get a functional console.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fabbe76203bb..337a0a6f7434 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -175,6 +175,17 @@ struct atmel_uart_port {
 	unsigned int		pending_status;
 	spinlock_t		lock_suspended;
 
+	struct {
+		u32		cr;
+		u32		mr;
+		u32		imr;
+		u32		brgr;
+		u32		rtor;
+		u32		ttgr;
+		u32		fmr;
+		u32		fimr;
+	} cache;
+
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -2659,6 +2670,19 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 			cpu_relax();
 	}
 
+	if (atmel_is_console_port(port) && !console_suspend_enabled) {
+		/* Cache register values as we won't get a full shutdown/startup
+		 * cycle*/
+		atmel_port->cache.mr = atmel_uart_readl(port, ATMEL_US_MR);
+		atmel_port->cache.imr = atmel_uart_readl(port, ATMEL_US_IMR);
+		atmel_port->cache.brgr = atmel_uart_readl(port, ATMEL_US_BRGR);
+		atmel_port->cache.rtor = atmel_uart_readl(port,
+							  atmel_port->rtor);
+		atmel_port->cache.ttgr = atmel_uart_readl(port, ATMEL_US_TTGR);
+		atmel_port->cache.fmr = atmel_uart_readl(port, ATMEL_US_FMR);
+		atmel_port->cache.fimr = atmel_uart_readl(port, ATMEL_US_FIMR);
+	}
+
 	/* we can not wake up if we're running on slow clock */
 	atmel_port->may_wakeup = device_may_wakeup(&pdev->dev);
 	if (atmel_serial_clk_will_stop()) {
@@ -2681,6 +2705,25 @@ static int atmel_serial_resume(struct platform_device *pdev)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
 
+	if (atmel_is_console_port(port) && !console_suspend_enabled) {
+		atmel_uart_writel(port, ATMEL_US_MR, atmel_port->cache.mr);
+		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->cache.imr);
+		atmel_uart_writel(port, ATMEL_US_BRGR, atmel_port->cache.brgr);
+		atmel_uart_writel(port, atmel_port->rtor,
+				  atmel_port->cache.rtor);
+		atmel_uart_writel(port, ATMEL_US_TTGR, atmel_port->cache.ttgr);
+
+		if (atmel_port->fifo_size) {
+			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_FIFOEN |
+					  ATMEL_US_RXFCLR | ATMEL_US_TXFLCLR);
+			atmel_uart_writel(port, ATMEL_US_FMR,
+					  atmel_port->cache.fmr);
+			atmel_uart_writel(port, ATMEL_US_FIER,
+					  atmel_port->cache.fimr);
+		}
+		atmel_start_rx(port);
+	}
+
 	spin_lock_irqsave(&atmel_port->lock_suspended, flags);
 	if (atmel_port->pending) {
 		atmel_handle_receive(port, atmel_port->pending);
-- 
2.11.0
