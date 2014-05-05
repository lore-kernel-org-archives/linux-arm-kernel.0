From: 21cnbao@gmail.com (Barry Song)
Date: Mon,  5 May 2014 08:05:51 +0800
Subject: [PATCH] serial: sirf: move to writel for TXFIFO instead of writeb
Message-ID: <1399248352-7329-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

All SiRFSoC UART registers are in 32-bits. If we use writeb for
TXFIFO, actually all of 32-bits are still written, for TXTIFO,
only low 8-bits are valid, so in prima2&atlas6, this causes no
problem.
But in the new atlas7, using writeb to write UART registers will
cause an imprecise data abort as HW does check the "wrong" writeb.
So move to writel and this also makes the code consistent with
sirfsoc_uart_pio_tx_chars() in which we use writel.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    2 +-
 drivers/tty/serial/sirfsoc_uart.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 68b0fd4..845548c 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1228,7 +1228,7 @@ static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
 	while (rd_regl(port,
 		ureg->sirfsoc_tx_fifo_status) & ufifo_st->ff_full(port->line))
 		cpu_relax();
-	wr_regb(port, ureg->sirfsoc_tx_fifo_data, ch);
+	wr_regl(port, ureg->sirfsoc_tx_fifo_data, ch);
 }
 
 static void sirfsoc_uart_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 8a6edda..4280819 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -441,9 +441,7 @@ struct sirfsoc_uart_port {
 
 /* Register Access Control */
 #define portaddr(port, reg)		((port)->membase + (reg))
-#define rd_regb(port, reg)		(__raw_readb(portaddr(port, reg)))
 #define rd_regl(port, reg)		(__raw_readl(portaddr(port, reg)))
-#define wr_regb(port, reg, val)		__raw_writeb(val, portaddr(port, reg))
 #define wr_regl(port, reg, val)		__raw_writel(val, portaddr(port, reg))
 
 /* UART Port Mask */
-- 
1.7.5.4
