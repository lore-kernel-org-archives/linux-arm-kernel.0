From: elen.song@atmel.com (Elen Song)
Date: Mon, 22 Jul 2013 16:30:29 +0800
Subject: [PATCH 6/8 V3] serial: at91: distinguish usart and uart
In-Reply-To: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
References: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
Message-ID: <1374481831-24573-7-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Distinguish usart and uart by read ip name register,
The usart read name is "USAR",
The uart and dbgu read name is "DBGU".

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/atmel_serial.h      |    2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7bd8607..c9c42fd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -98,6 +98,7 @@ static void atmel_stop_rx(struct uart_port *port);
 #define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_BRGR)
 #define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATMEL_US_RTOR)
 #define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_IP_NAME(port)	__raw_readl((port)->membase + ATMEL_US_NAME)
 
  /* PDC registers */
 #define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_PTCR)
@@ -167,6 +168,7 @@ struct atmel_uart_port {
 
 	struct serial_rs485	rs485;		/* rs485 settings */
 	unsigned int		tx_done_mask;
+	bool			is_usart;	/* usart or uart */
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -1479,6 +1481,34 @@ static void atmel_set_ops(struct uart_port *port)
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
@@ -2323,6 +2353,13 @@ static int atmel_serial_probe(struct platform_device *pdev)
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
