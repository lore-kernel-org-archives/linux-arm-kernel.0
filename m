From: dirk.behme@googlemail.com (Dirk Behme)
Date: Thu, 22 Dec 2011 09:57:53 +0100
Subject: [PATCH 2/2 v3] imx: add polled io uart methods
In-Reply-To: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
References: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1324544273-9820-2-git-send-email-dirk.behme@gmail.com>
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
CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
CC: linux-serial at vger.kernel.org
CC: Alan Cox <alan@linux.intel.com>
---
Changes in v3:
* Remove blank line
* Remove '& 0xff' in 'return c' as 'c' is an unsigned char
* Rename imx_console_mode/restore() to imx_port_ucrs_save/restore()
* Add Alan Cox to CC

Changes in the v2 compared to Saleem's original version:
* Remove volatile form status variable
* Remove blank line
* Factor out imx_console_mode/restore()

 drivers/tty/serial/imx.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3daa008..d6162ec 100644
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
@@ -1106,6 +1107,70 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+#if defined(CONFIG_CONSOLE_POLL)
+static int imx_poll_get_char(struct uart_port *port)
+{
+	struct imx_port_ucrs old_ucr;
+	unsigned int status;
+	unsigned char c;
+
+	/* save control registers */
+	imx_port_ucrs_save(port, &old_ucr);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(old_ucr.ucr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(old_ucr.ucr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN),
+	       port->membase + UCR3);
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
+	imx_port_ucrs_restore(port, &old_ucr);
+
+	return c;
+}
+
+static void imx_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	struct imx_port_ucrs old_ucr;
+	unsigned int status;
+
+	/* save control registers */
+	imx_port_ucrs_save(port, &old_ucr);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(old_ucr.ucr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(old_ucr.ucr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN),
+	       port->membase + UCR3);
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
+	imx_port_ucrs_restore(port, &old_ucr);
+}
+#endif
+
 static struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
@@ -1123,6 +1188,10 @@ static struct uart_ops imx_pops = {
 	.request_port	= imx_request_port,
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char  = imx_poll_get_char,
+	.poll_put_char  = imx_poll_put_char,
+#endif
 };
 
 static struct imx_port *imx_ports[UART_NR];
-- 
1.7.7.4
