From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:44 +0800
Subject: [PATCH 5/7] serial: at91: distinguish usart and uart
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-6-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Distinguish usart and uart by read ip name register,
dbgu regards as uart.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/atmel_serial.h      |    2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 52beb7e..5762244 100644
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
 	struct timer_list 	uart_timer;	/* dbgu timer */
+	bool			is_usart;	/* usart or uart */
 };
 
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
@@ -1328,6 +1330,34 @@ static void atmel_tasklet_func(unsigned long data)
 }
 
 /*
+ * Get ip name usart or uart
+ */
+static inline unsigned int atmel_get_ip_name(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned int name = cpu_to_be32(UART_GET_IP_NAME(port));
+	char *ip_name = (char *)&name;
+	char *usart = "USAR";
+	char *uart = "DBGU";
+
+	atmel_port->is_usart = false;
+
+	/* USAR is regards as usart, DBGU is regards as uart */
+	if (!strncmp(ip_name, usart, 4)) {
+		dev_dbg(port->dev, "This is usart\n");
+		atmel_port->is_usart = true;
+	} else if (!strncmp(ip_name, uart, 4)) {
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
@@ -1354,6 +1384,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/*
+	 * Get port name of usart or uart
+	 */
+	atmel_get_ip_name(port);
+
+	/*
 	 * Initialize DMA (if necessary)
 	 */
 	if (atmel_use_pdc_rx(port)) {
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
