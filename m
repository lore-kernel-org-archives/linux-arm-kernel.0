From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:41:05 +0100
Subject: [PATCH 4/7] serial: imx: drop support for IRDA
In-Reply-To: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424292068-28197-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for IRDA was added in 2009 in commit v2.6.31-rc1~399^2~2. There
are no in-tree users.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Oskar Schirmer <os@emlix.com>
---
 drivers/tty/serial/imx.c | 156 +++--------------------------------------------
 1 file changed, 9 insertions(+), 147 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cf1a612435cc..587f7b3075e4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -6,9 +6,6 @@
  * Author: Sascha Hauer <sascha@saschahauer.de>
  * Copyright (C) 2004 Pengutronix
  *
- * Author: Fabian Godehardt (added IrDA support for iMX)
- * Copyright (C) 2009 emlix GmbH
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -200,7 +197,6 @@ struct imx_port {
 	unsigned int		old_status;
 	unsigned int		have_rtscts:1;
 	unsigned int		dte_mode:1;
-	unsigned int		use_irda:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
@@ -227,12 +223,6 @@ struct imx_port_ucrs {
 	unsigned int	ucr3;
 };
 
-#ifdef CONFIG_IRDA
-#define USE_IRDA(sport)	((sport)->use_irda)
-#else
-#define USE_IRDA(sport)	(0)
-#endif
-
 static struct imx_uart_data imx_uart_devdata[] = {
 	[IMX1_UART] = {
 		.uts_reg = IMX1_UTS,
@@ -367,48 +357,6 @@ static void imx_stop_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	if (USE_IRDA(sport)) {
-		/* half duplex - wait for end of transmission */
-		int n = 256;
-		while ((--n > 0) &&
-		      !(readl(sport->port.membase + USR2) & USR2_TXDC)) {
-			udelay(5);
-			barrier();
-		}
-		/*
-		 * irda transceiver - wait a bit more to avoid
-		 * cutoff, hardware dependent
-		 */
-		udelay(sport->trcv_delay);
-
-		/*
-		 * half duplex - reactivate receive mode,
-		 * flush receive pipe echo crap
-		 */
-		if (readl(sport->port.membase + USR2) & USR2_TXDC) {
-			temp = readl(sport->port.membase + UCR1);
-			temp &= ~(UCR1_TXMPTYEN | UCR1_TRDYEN);
-			writel(temp, sport->port.membase + UCR1);
-
-			temp = readl(sport->port.membase + UCR4);
-			temp &= ~(UCR4_TCEN);
-			writel(temp, sport->port.membase + UCR4);
-
-			while (readl(sport->port.membase + URXD0) &
-			       URXD_CHARRDY)
-				barrier();
-
-			temp = readl(sport->port.membase + UCR1);
-			temp |= UCR1_RRDYEN;
-			writel(temp, sport->port.membase + UCR1);
-
-			temp = readl(sport->port.membase + UCR4);
-			temp |= UCR4_DREN;
-			writel(temp, sport->port.membase + UCR4);
-		}
-		return;
-	}
-
 	/*
 	 * We are maybe in the SMP context, so if the DMA TX thread is running
 	 * on other cpu, we have to wait for it to finish.
@@ -572,16 +520,6 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	if (USE_IRDA(sport)) {
-		/* half duplex in IrDA mode; have to disable receive mode */
-		temp = readl(sport->port.membase + UCR4);
-		temp &= ~(UCR4_DREN);
-		writel(temp, sport->port.membase + UCR4);
-
-		temp = readl(sport->port.membase + UCR1);
-		temp &= ~(UCR1_RRDYEN);
-		writel(temp, sport->port.membase + UCR1);
-	}
 	/* Clear any pending ORE flag before enabling interrupt */
 	temp = readl(sport->port.membase + USR2);
 	writel(temp | USR2_ORE, sport->port.membase + USR2);
@@ -595,16 +533,6 @@ static void imx_start_tx(struct uart_port *port)
 		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
 	}
 
-	if (USE_IRDA(sport)) {
-		temp = readl(sport->port.membase + UCR1);
-		temp |= UCR1_TRDYEN;
-		writel(temp, sport->port.membase + UCR1);
-
-		temp = readl(sport->port.membase + UCR4);
-		temp |= UCR4_TCEN;
-		writel(temp, sport->port.membase + UCR4);
-	}
-
 	if (sport->dma_is_enabled) {
 		/* FIXME: port->x_char must be transmitted if != 0 */
 		if (!uart_circ_empty(&port->state->xmit) &&
@@ -1081,9 +1009,6 @@ static int imx_startup(struct uart_port *port)
 	 */
 	temp = readl(sport->port.membase + UCR4);
 
-	if (USE_IRDA(sport))
-		temp |= UCR4_IRSC;
-
 	/* set the trigger level for CTS */
 	temp &= ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
 	temp |= CTSTL << UCR4_CTSTL_SHF;
@@ -1109,11 +1034,6 @@ static int imx_startup(struct uart_port *port)
 	temp = readl(sport->port.membase + UCR1);
 	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
 
-	if (USE_IRDA(sport)) {
-		temp |= UCR1_IREN;
-		temp &= ~(UCR1_RTSDEN);
-	}
-
 	writel(temp, sport->port.membase + UCR1);
 
 	temp = readl(sport->port.membase + UCR2);
@@ -1128,38 +1048,12 @@ static int imx_startup(struct uart_port *port)
 		writel(temp, sport->port.membase + UCR3);
 	}
 
-	if (USE_IRDA(sport)) {
-		temp = readl(sport->port.membase + UCR4);
-		if (sport->irda_inv_rx)
-			temp |= UCR4_INVR;
-		else
-			temp &= ~(UCR4_INVR);
-		writel(temp | UCR4_DREN, sport->port.membase + UCR4);
-
-		temp = readl(sport->port.membase + UCR3);
-		if (sport->irda_inv_tx)
-			temp |= UCR3_INVT;
-		else
-			temp &= ~(UCR3_INVT);
-		writel(temp, sport->port.membase + UCR3);
-	}
-
 	/*
 	 * Enable modem status interrupts
 	 */
 	imx_enable_ms(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	if (USE_IRDA(sport)) {
-		struct imxuart_platform_data *pdata;
-		pdata = dev_get_platdata(sport->port.dev);
-		sport->irda_inv_rx = pdata->irda_inv_rx;
-		sport->irda_inv_tx = pdata->irda_inv_tx;
-		sport->trcv_delay = pdata->transceiver_delay;
-		if (pdata->irda_enable)
-			pdata->irda_enable(1);
-	}
-
 	return 0;
 }
 
@@ -1193,13 +1087,6 @@ static void imx_shutdown(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR2);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	if (USE_IRDA(sport)) {
-		struct imxuart_platform_data *pdata;
-		pdata = dev_get_platdata(sport->port.dev);
-		if (pdata->irda_enable)
-			pdata->irda_enable(0);
-	}
-
 	/*
 	 * Stop our timer.
 	 */
@@ -1212,8 +1099,6 @@ static void imx_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
-	if (USE_IRDA(sport))
-		temp &= ~(UCR1_IREN);
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1343,24 +1228,16 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->port.membase + UCR2);
 	old_txrxen &= (UCR2_TXEN | UCR2_RXEN);
 
-	if (USE_IRDA(sport)) {
-		/*
-		 * use maximum available submodule frequency to
-		 * avoid missing short pulses due to low sampling rate
-		 */
+	/* custom-baudrate handling */
+	div = sport->port.uartclk / (baud * 16);
+	if (baud == 38400 && quot != div)
+		baud = sport->port.uartclk / (quot * 16);
+
+	div = sport->port.uartclk / (baud * 16);
+	if (div > 7)
+		div = 7;
+	if (!div)
 		div = 1;
-	} else {
-		/* custom-baudrate handling */
-		div = sport->port.uartclk / (baud * 16);
-		if (baud == 38400 && quot != div)
-			baud = sport->port.uartclk / (quot * 16);
-
-		div = sport->port.uartclk / (baud * 16);
-		if (div > 7)
-			div = 7;
-		if (!div)
-			div = 1;
-	}
 
 	rational_best_approximation(16 * div * baud, sport->port.uartclk,
 		1 << 16, 1 << 16, &num, &denom);
@@ -1801,9 +1678,6 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
 		sport->have_rtscts = 1;
 
-	if (of_get_property(np, "fsl,irda-mode", NULL))
-		sport->use_irda = 1;
-
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
@@ -1832,9 +1706,6 @@ static void serial_imx_probe_pdata(struct imx_port *sport,
 
 	if (pdata->flags & IMXUART_HAVE_RTSCTS)
 		sport->have_rtscts = 1;
-
-	if (pdata->flags & IMXUART_IRDA)
-		sport->use_irda = 1;
 }
 
 static int serial_imx_probe(struct platform_device *pdev)
@@ -1907,15 +1778,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 				       dev_name(&pdev->dev), sport);
 		if (ret)
 			return ret;
-
-		/* do not use RTS IRQ on IrDA */
-		if (!USE_IRDA(sport)) {
-			ret = devm_request_irq(&pdev->dev, rtsirq,
-					       imx_rtsint, 0,
-					       dev_name(&pdev->dev), sport);
-			if (ret)
-				return ret;
-		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_int, 0,
 				       dev_name(&pdev->dev), sport);
-- 
2.1.4
