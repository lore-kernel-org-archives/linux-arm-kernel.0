From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed,  9 Jul 2014 19:49:33 +0200
Subject: [PATCH 2/6] tty: serial: 8250 core: allow to overwrite & export
 serial8250_startup()
In-Reply-To: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP version of the 8250 can actually use 1:1 serial8250_startup().
However it needs to be extended by a wakeup irq which should to be
requested & enabled at ->startup() time and disabled at ->shutdown() time.

v1?v2: add shutdown callback

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 22 ++++++++++++++++++++--
 include/linux/serial_8250.h         |  2 ++
 include/linux/serial_core.h         |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 6db2ee2..d37eb08 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1939,7 +1939,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int serial8250_startup(struct uart_port *port)
+int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
@@ -2191,8 +2191,17 @@ static int serial8250_startup(struct uart_port *port)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(serial8250_do_startup);
 
-static void serial8250_shutdown(struct uart_port *port)
+static int serial8250_startup(struct uart_port *port)
+{
+	if (port->startup)
+		return port->startup(port);
+	else
+		return serial8250_do_startup(port);
+}
+
+void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
@@ -2243,6 +2252,15 @@ static void serial8250_shutdown(struct uart_port *port)
 	if (port->irq)
 		serial_unlink_irq_chain(up);
 }
+EXPORT_SYMBOL_GPL(serial8250_do_shutdown);
+
+static void serial8250_shutdown(struct uart_port *port)
+{
+	if (port->shutdown)
+		port->shutdown(port);
+	else
+		serial8250_do_shutdown(port);
+}
 
 static unsigned int serial8250_get_divisor(struct uart_port *port, unsigned int baud)
 {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index af47a8a..0ec21ec 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -114,6 +114,8 @@ extern void serial8250_early_out(struct uart_port *port, int offset, int value);
 extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
+extern int serial8250_do_startup(struct uart_port *port);
+extern void serial8250_do_shutdown(struct uart_port *port);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
 extern int fsl8250_handle_irq(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5bbb809..6f20ff0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -122,6 +122,8 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	int			(*startup)(struct uart_port *port);
+	void			(*shutdown)(struct uart_port *port);
 	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
-- 
2.0.1
