From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 18 Dec 2011 18:34:14 +0100
Subject: [PATCH 1/2] imx: Add save/restore functions for UART control regs
Message-ID: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the uart save/restore functionality instead of
having the same code several times in the driver.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Saleem Abdulrasool <compnerd@compnerd.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
CC: linux-serial at vger.kernel.org
---
 drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..6a01c2a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -260,6 +260,31 @@ static inline int is_imx21_uart(struct imx_port *sport)
 }
 
 /*
+ * Save and restore functions for UCR1, UCR2 and UCR3 registers
+ */
+static void imx_console_mode(struct uart_port *port,
+			     unsigned int *ucr1,
+			     unsigned int *ucr2,
+			     unsigned int *ucr3)
+{
+	/* save control registers */
+	*ucr1 = readl(port->membase + UCR1);
+	*ucr2 = readl(port->membase + UCR2);
+	*ucr3 = readl(port->membase + UCR3);
+}
+
+static void imx_console_restore(struct uart_port *port,
+				unsigned int ucr1,
+				unsigned int ucr2,
+				unsigned int ucr3)
+{
+	/* restore control registers */
+	writel(ucr1, port->membase + UCR1);
+	writel(ucr2, port->membase + UCR2);
+	writel(ucr3, port->membase + UCR3);
+}
+
+/*
  * Handle any change of modem status signal since we were last called.
  */
 static void imx_mctrl_check(struct imx_port *sport)
@@ -1118,13 +1143,13 @@ static void
 imx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = imx_ports[co->index];
-	unsigned int old_ucr1, old_ucr2, ucr1;
+	unsigned int old_ucr1, old_ucr2, old_ucr3, ucr1;
 
 	/*
-	 *	First, save UCR1/2 and then disable interrupts
+	 *	First, save UCR1/2/3 and then disable interrupts
 	 */
-	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
-	old_ucr2 = readl(sport->port.membase + UCR2);
+	imx_console_mode(&sport->port, &old_ucr1, &old_ucr2, &old_ucr3);
+	ucr1 = old_ucr1;
 
 	if (is_imx1_uart(sport))
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
@@ -1139,12 +1164,11 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-	 *	and restore UCR1/2
+	 *	and restore UCR1/2/3
 	 */
 	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
 
-	writel(old_ucr1, sport->port.membase + UCR1);
-	writel(old_ucr2, sport->port.membase + UCR2);
+	imx_console_restore(&sport->port, old_ucr1, old_ucr2, old_ucr3);
 }
 
 /*
-- 
1.7.7.4
