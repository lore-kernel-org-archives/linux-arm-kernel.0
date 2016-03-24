From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:22 +0100
Subject: [PATCH v2 3/6] serial: imx: make sure unhandled irqs are disabled
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that events that are not handled in the irq function don't
trigger an interrupt.

When the serial port is operated in DTE mode, the events for DCD and RI
events are enabled after a system reset by default.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5ced61e1de6a..fcd48fd78bf5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1221,11 +1221,32 @@ static int imx_startup(struct uart_port *port)
 	temp |= (UCR2_RXEN | UCR2_TXEN);
 	if (!sport->have_rtscts)
 		temp |= UCR2_IRTS;
+	/*
+	 * make sure the edge sensitive RTS-irq is disabled,
+	 * we're using RTSD instead.
+	 */
+	if (!is_imx1_uart(sport))
+		temp &= ~UCR2_RTSEN;
 	writel(temp, sport->port.membase + UCR2);
 
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
-		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP;
+
+		/*
+		 * The effect of RI and DCD differs depending on the UFCR_DCEDTE
+		 * bit. In DCE mode they control the outputs, in DTE mode they
+		 * enable the respective irqs. At least the DCD irq cannot be
+		 * cleared on i.MX25 at least, so it's not usable and must be
+		 * disabled. I don't have test hardware to check if RI has the
+		 * same problem but I consider this likely so it's disabled for
+		 * now, too.
+		 */
+		temp |= IMX21_UCR3_RXDMUXSEL | UCR3_ADNIMP |
+			UCR3_RI | UCR3_DCD;
+
+		if (sport->dte_mode)
+			temp &= ~(UCR3_RI | UCR3_DCD);
+
 		writel(temp, sport->port.membase + UCR3);
 	}
 
-- 
2.7.0
