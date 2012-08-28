From: den@openvz.org (Denis V. Lunev)
Date: Tue, 28 Aug 2012 13:12:04 +0400
Subject: [PATCH 1/1] arm: KGDB support for PXA
Message-ID: <1346145124-23384-1-git-send-email-den@openvz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Denis V. Lunev" <den@openvz.org>

Actually, in order to support KGDB over serial console one must
implement two callbacks for character polling. Clone them from
8250 driver with a bit of tuning.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Marko Katic <dromede@gmail.com>
CC: Eric Miao <eric.y.miao@gmail.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Haojian Zhuang <haojian.zhuang@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>
---
This patch has been originally posted by me to LKML in 2009 and postponed.
I was contacted last week by Marko who has kindly ported the patch to the
latest v3.6 kernel and asked to re-send it.

Here it is :)

 drivers/tty/serial/pxa.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5847a4b..54cbb02 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -691,6 +691,57 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable_unprepare(up->clk);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context.
+ */
+
+static int serial_pxa_get_poll_char(struct uart_port *port)
+{
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+	unsigned char lsr = serial_in(up, UART_LSR);
+
+	while (!(lsr & UART_LSR_DR))
+		lsr = serial_in(up, UART_LSR);
+
+	return serial_in(up, UART_RX);
+}
+
+
+static void serial_pxa_put_poll_char(struct uart_port *port,
+			 unsigned char c)
+{
+	unsigned int ier;
+	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, UART_IER_UUE);
+
+	wait_for_xmitr(up);
+	/*
+	 *	Send the character out.
+	 *	If a LF, also do CR...
+	 */
+	serial_out(up, UART_TX, c);
+	if (c == 10) {
+		wait_for_xmitr(up);
+		serial_out(up, UART_TX, 13);
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	serial_out(up, UART_IER, ier);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static int __init
 serial_pxa_console_setup(struct console *co, char *options)
 {
@@ -745,6 +796,10 @@ struct uart_ops serial_pxa_pops = {
 	.request_port	= serial_pxa_request_port,
 	.config_port	= serial_pxa_config_port,
 	.verify_port	= serial_pxa_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char = serial_pxa_get_poll_char,
+	.poll_put_char = serial_pxa_put_poll_char,
+#endif
 };
 
 static struct uart_driver serial_pxa_reg = {
-- 
1.7.7.6
