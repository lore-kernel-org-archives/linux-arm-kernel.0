From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:24 +0100
Subject: [PATCH v2 5/6] serial: imx: reorder functions to simplify next patch
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 98 ++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1bf7b86acf66..c07e652f8f58 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -729,6 +729,55 @@ static void imx_dma_rxint(struct imx_port *sport)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
+/*
+ * We have a modem side uart, so the meanings of RTS and CTS are inverted.
+ */
+static unsigned int imx_get_hwmctrl(struct imx_port *sport)
+{
+	unsigned int tmp = TIOCM_DSR;
+	unsigned usr1 = readl(sport->port.membase + USR1);
+
+	if (usr1 & USR1_RTSS)
+		tmp |= TIOCM_CTS;
+
+	/* in DCE mode DCDIN is always 0 */
+	if (!(usr1 & USR2_DCDIN))
+		tmp |= TIOCM_CAR;
+
+	if (sport->dte_mode)
+		if (!(readl(sport->port.membase + USR2) & USR2_RIIN))
+			tmp |= TIOCM_RI;
+
+	return tmp;
+}
+
+/*
+ * Handle any change of modem status signal since we were last called.
+ */
+static void imx_mctrl_check(struct imx_port *sport)
+{
+	unsigned int status, changed;
+
+	status = imx_get_hwmctrl(sport);
+	changed = status ^ sport->old_status;
+
+	if (changed == 0)
+		return;
+
+	sport->old_status = status;
+
+	if (changed & TIOCM_RI && status & TIOCM_RI)
+		sport->port.icount.rng++;
+	if (changed & TIOCM_DSR)
+		sport->port.icount.dsr++;
+	if (changed & TIOCM_CAR)
+		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
+	if (changed & TIOCM_CTS)
+		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
+
+	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
+}
+
 static irqreturn_t imx_int(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
@@ -791,28 +840,6 @@ static unsigned int imx_tx_empty(struct uart_port *port)
 	return ret;
 }
 
-/*
- * We have a modem side uart, so the meanings of RTS and CTS are inverted.
- */
-static unsigned int imx_get_hwmctrl(struct imx_port *sport)
-{
-	unsigned int tmp = TIOCM_DSR;
-	unsigned usr1 = readl(sport->port.membase + USR1);
-
-	if (usr1 & USR1_RTSS)
-		tmp |= TIOCM_CTS;
-
-	/* in DCE mode DCDIN is always 0 */
-	if (!(usr1 & USR2_DCDIN))
-		tmp |= TIOCM_CAR;
-
-	if (sport->dte_mode)
-		if (!(readl(sport->port.membase + USR2) & USR2_RIIN))
-			tmp |= TIOCM_RI;
-
-	return tmp;
-}
-
 static unsigned int imx_get_mctrl(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -870,33 +897,6 @@ static void imx_break_ctl(struct uart_port *port, int break_state)
 }
 
 /*
- * Handle any change of modem status signal since we were last called.
- */
-static void imx_mctrl_check(struct imx_port *sport)
-{
-	unsigned int status, changed;
-
-	status = imx_get_hwmctrl(sport);
-	changed = status ^ sport->old_status;
-
-	if (changed == 0)
-		return;
-
-	sport->old_status = status;
-
-	if (changed & TIOCM_RI && status & TIOCM_RI)
-		sport->port.icount.rng++;
-	if (changed & TIOCM_DSR)
-		sport->port.icount.dsr++;
-	if (changed & TIOCM_CAR)
-		uart_handle_dcd_change(&sport->port, status & TIOCM_CAR);
-	if (changed & TIOCM_CTS)
-		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
-
-	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
-}
-
-/*
  * This is our per-port timeout handler, for checking the
  * modem status signals.
  */
-- 
2.7.0
