From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 18 Dec 2011 18:34:15 +0100
Subject: [PATCH 2/2 v2] imx: add polled io uart methods
In-Reply-To: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1324229655-5538-2-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saleem Abdulrasool <compnerd@compnerd.org>

These methods are invoked if the iMX uart is used in conjuction with kgdb during
early boot.  In order to access the UART without the interrupts, the kernel uses
the basic polling methods for IO with the device.  With these methods
implemented, it is now possible to enable kgdb during early boot over serial.

Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
CC: linux-serial at vger.kernel.org
---
Note: Changes in the v2 compared to Saleem's original version:
       * Remove volatile form status variable
       * Remove blank line
       * Factor out imx_console_mode/restore()

 drivers/tty/serial/imx.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6a01c2a..cd81ac0 100644
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
@@ -1104,6 +1105,66 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+#if defined(CONFIG_CONSOLE_POLL)
+static int imx_poll_get_char(struct uart_port *port)
+{
+	unsigned int status, cr1, cr2, cr3;
+	unsigned char c;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
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
+	imx_console_restore(port, cr1, cr2, cr3);
+
+	return c & 0xff;
+}
+
+static void imx_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned int status, cr1, cr2, cr3;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
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
+	imx_console_restore(port, cr1, cr2, cr3);
+}
+#endif
+
 static struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
@@ -1121,6 +1182,11 @@ static struct uart_ops imx_pops = {
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
1.7.7.4
