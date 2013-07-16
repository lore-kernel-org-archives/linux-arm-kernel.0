From: elen.song@atmel.com (Elen Song)
Date: Tue, 16 Jul 2013 10:43:46 +0800
Subject: [PATCH V2 7/8] serial: at91: distinguish usart and uart
In-Reply-To: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
References: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373942627-7121-8-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Distinguish usart and uart by read ip name register,
dbgu regards as uart.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/atmel_serial.h      |    2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index afecdfa..769b90b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -99,6 +99,7 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_BRGR)
 #define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
 #define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_IP_NAME(port)	__raw_readl((port)->membase + ATMEL_US_NAME)
 
  /* PDC registers */
 #define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
@@ -169,6 +170,7 @@ struct atmel_uart_port {
 	struct serial_rs485	rs485;		/* rs485 settings */
 	unsigned int		tx_done_mask;
 	struct timer_list       uart_timer;     /* dbgu timer */
+	bool			is_usart;	/* usart or uart */
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -1496,6 +1498,34 @@ static void atmel_set_ops(struct uart_port *port)
 }
 
 /*
+ * Get ip name usart or uart
+ */
+static int atmel_get_ip_name(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int name = UART_GET_IP_NAME(port);
+	int usart, uart;
+	/* usart and uart ascii */
+	usart = 0x55534152;
+	uart = 0x44424755;
+
+	atmel_port->is_usart = false;
+
+	if (name == usart) {
+		dev_dbg(port->dev, "This is usart\n");
+		atmel_port->is_usart = true;
+	} else if (name == uart) {
+		dev_dbg(port->dev, "This is uart\n");
+		atmel_port->is_usart = false;
+	} else {
+		dev_err(port->dev, "Not supported ip name, set to uart\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
  * Perform initialization and enable port for reception
  */
 static int atmel_startup(struct uart_port *port)
@@ -2359,6 +2389,13 @@ static int atmel_serial_probe(struct platform_device *pdev)
 		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
 	}
 
+	/*
+	 * Get port name of usart or uart
+	 */
+	ret = atmel_get_ip_name(&port->uart);
+	if (ret < 0)
+		goto err_add_port;
+
 	return 0;
 
 err_add_port:
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index fd68337..be201ca 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -124,4 +124,6 @@
 #define ATMEL_US_NER		0x44			/* Number of Errors Register */
 #define ATMEL_US_IF		0x4c			/* IrDA Filter Register */
 
+#define ATMEL_US_NAME		0xf0			/* Ip Name */
+
 #endif
-- 
1.7.9.5
