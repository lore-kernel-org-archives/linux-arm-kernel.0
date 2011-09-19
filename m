From: compnerd@compnerd.org (Saleem Abdulrasool)
Date: Sun, 18 Sep 2011 18:45:18 -0700
Subject: [PATCH] mxcuart: add polled io methods
In-Reply-To: <1316396718-31886-1-git-send-email-compnerd@compnerd.org>
References: <1316396718-31886-1-git-send-email-compnerd@compnerd.org>
Message-ID: <1316396718-31886-2-git-send-email-compnerd@compnerd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/serial/mxc_uart.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/mxc_uart.c b/drivers/serial/mxc_uart.c
index 347a746..5769465 100644
--- a/drivers/serial/mxc_uart.c
+++ b/drivers/serial/mxc_uart.c
@@ -1534,6 +1534,79 @@ mxcuart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
 		clk_enable(umxc->clk);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int mxc_uart_get_poll_char(struct uart_port *port)
+{
+       volatile unsigned int status;
+       unsigned int cr1, cr2, cr3;
+       unsigned char c;
+
+       /* save control registers */
+       cr1 = readl(port->membase + MXC_UARTUCR1);
+       cr2 = readl(port->membase + MXC_UARTUCR2);
+       cr3 = readl(port->membase + MXC_UARTUCR3);
+
+       /* disable interrupts */
+       writel(MXC_UARTUCR1_UARTEN, port->membase + MXC_UARTUCR1);
+       writel(cr2 & ~(MXC_UARTUCR2_ATEN | MXC_UARTUCR2_RTSEN | MXC_UARTUCR2_ESCI),
+              port->membase + MXC_UARTUCR2);
+       writel(cr3 & ~(MXC_UARTUCR3_DCD | MXC_UARTUCR3_RI | MXC_UARTUCR3_DTRDEN),
+              port->membase + MXC_UARTUCR3);
+
+       /* poll */
+       do {
+               status = readl(port->membase + MXC_UARTUSR2);
+       } while (~status & MXC_UARTUSR2_RDR);
+
+       /* read */
+       c = readl(port->membase + MXC_UARTURXD);
+
+       /* restore control registers */
+       writel(cr1, port->membase + MXC_UARTUCR1);
+       writel(cr2, port->membase + MXC_UARTUCR2);
+       writel(cr3, port->membase + MXC_UARTUCR3);
+
+       return c & 0xff;
+}
+
+static void mxc_uart_put_poll_char(struct uart_port *port,
+                                  unsigned char c)
+{
+       volatile unsigned int status;
+       unsigned int cr1, cr2, cr3;
+
+       /* save control registers */
+       cr1 = readl(port->membase + MXC_UARTUCR1);
+       cr2 = readl(port->membase + MXC_UARTUCR2);
+       cr3 = readl(port->membase + MXC_UARTUCR3);
+
+       /* disable interrupts */
+       writel(MXC_UARTUCR1_UARTEN, port->membase + MXC_UARTUCR1);
+       writel(cr2 & ~(MXC_UARTUCR2_ATEN | MXC_UARTUCR2_RTSEN | MXC_UARTUCR2_ESCI),
+              port->membase + MXC_UARTUCR2);
+       writel(cr3 & ~(MXC_UARTUCR3_DCD | MXC_UARTUCR3_RI | MXC_UARTUCR3_DTRDEN),
+              port->membase + MXC_UARTUCR3);
+
+       /* drain */
+       do {
+               status = readl(port->membase + MXC_UARTUSR1);
+       } while (~status & MXC_UARTUSR1_TRDY);
+
+       /* write */
+       writel(c, port->membase + MXC_UARTUTXD);
+
+       /* flush */
+       do {
+               status = readl(port->membase + MXC_UARTUSR2);
+       } while (~status & MXC_UARTUSR2_TXDC);
+
+       /* restore control registers */
+       writel(cr1, port->membase + MXC_UARTUCR1);
+       writel(cr2, port->membase + MXC_UARTUCR2);
+       writel(cr3, port->membase + MXC_UARTUCR3);
+}
+#endif
+
 /*!
  * This structure contains the pointers to the control functions that are
  * invoked by the core serial driver to access the UART hardware. The
@@ -1558,6 +1631,11 @@ static struct uart_ops mxc_ops = {
 	.config_port = mxcuart_config_port,
 	.verify_port = mxcuart_verify_port,
 	.send_xchar = mxcuart_send_xchar,
+
+#ifdef CONFIG_CONSOLE_POLL
+        .poll_get_char = mxc_uart_get_poll_char,
+        .poll_put_char = mxc_uart_put_poll_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MXC_CONSOLE
-- 
1.7.6.1
