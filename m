From: compnerd@compnerd.org (Saleem Abdulrasool)
Date: Sun, 16 Oct 2011 20:22:01 -0700
Subject: [PATCH] imx: add polled io uart methods
In-Reply-To: <1318821721-11965-1-git-send-email-compnerd@compnerd.org>
References: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>
	<1318821721-11965-1-git-send-email-compnerd@compnerd.org>
Message-ID: <1318821721-11965-2-git-send-email-compnerd@compnerd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These methods are invoked if the iMX uart is used in conjuction with kgdb during
early boot.  In order to access the UART without the interrupts, the kernel uses
the basic polling methods for IO with the device.  With these methods
implemented, it is now possible to enable kgdb during early boot over serial.

Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
---
 drivers/tty/serial/imx.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7e91b3d..4fcf9ca 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -102,6 +102,7 @@
 #define  UCR2_STPB       (1<<6)	 /* Stop */
 #define  UCR2_WS         (1<<5)	 /* Word size */
 #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
+#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
 #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
 #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
 #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
@@ -1075,6 +1076,77 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+
+#if defined(CONFIG_CONSOLE_POLL)
+static int imx_poll_get_char(struct uart_port *port)
+{
+	volatile unsigned int status;
+	unsigned int cr1, cr2, cr3;
+	unsigned char c;
+
+	/* save control registers */
+	cr1 = readl(port->membase + UCR1);
+	cr2 = readl(port->membase + UCR2);
+	cr3 = readl(port->membase + UCR3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
+
+	/* poll */
+	do {
+		status = readl(port->membase + USR2);
+	} while (~status & USR2_RDR);
+
+	/* read */
+	c = readl(port->membase + URXD0);
+
+	/* restore control registers */
+	writel(cr1, port->membase + UCR1);
+	writel(cr2, port->membase + UCR2);
+	writel(cr3, port->membase + UCR3);
+
+	return (c & 0xff);
+}
+
+static void imx_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	volatile unsigned int status;
+	unsigned int cr1, cr2, cr3;
+
+	/* save control registers */
+	cr1 = readl(port->membase + UCR1);
+	cr2 = readl(port->membase + UCR2);
+	cr3 = readl(port->membase + UCR3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
+
+	/* drain */
+	do {
+		status = readl(port->membase + USR1);
+	} while (~status & USR1_TRDY);
+
+	/* write */
+	writel(c, port->membase + URTX0);
+
+	/* flush */
+	do {
+		status = readl(port->membase + USR2);
+	} while (~status & USR2_TXDC);
+
+	/* restore control registers */
+	writel(cr1, port->membase + UCR1);
+	writel(cr2, port->membase + UCR2);
+	writel(cr3, port->membase + UCR3);
+}
+#endif
+
 static struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
@@ -1092,6 +1164,11 @@ static struct uart_ops imx_pops = {
 	.request_port	= imx_request_port,
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
+
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char  = imx_poll_get_char,
+	.poll_put_char  = imx_poll_put_char,
+#endif
 };
 
 static struct imx_port *imx_ports[UART_NR];
-- 
1.7.6.1
