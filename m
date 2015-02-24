From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:10 +0100
Subject: [PATCH v2 6/7] serial: imx: drop support for IRDA
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424773031-19692-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for IRDA was added in 2009 in commit v2.6.31-rc1~399^2~2. There
are no in-tree users.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c                 | 157 ++-----------------------------
 include/linux/platform_data/serial-imx.h |   5 -
 2 files changed, 9 insertions(+), 153 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e74dd74d84d0..95bd0a5ae0d1 100644
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
@@ -201,7 +198,6 @@ struct imx_port {
 	unsigned int		old_status;
 	unsigned int		have_rtscts:1;
 	unsigned int		dte_mode:1;
-	unsigned int		use_irda:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
@@ -228,12 +224,6 @@ struct imx_port_ucrs {
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
@@ -368,48 +358,6 @@ static void imx_stop_tx(struct uart_port *port)
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
@@ -612,32 +560,11 @@ static void imx_start_tx(struct uart_port *port)
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
-
 	if (!sport->dma_is_enabled) {
 		temp = readl(sport->port.membase + UCR1);
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
 		if (sport->port.x_char) {
 			/* We have X-char to send, so enable TX IRQ and
@@ -1148,9 +1075,6 @@ static int imx_startup(struct uart_port *port)
 	 */
 	temp = readl(sport->port.membase + UCR4);
 
-	if (USE_IRDA(sport))
-		temp |= UCR4_IRSC;
-
 	/* set the trigger level for CTS */
 	temp &= ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
 	temp |= CTSTL << UCR4_CTSTL_SHF;
@@ -1186,11 +1110,6 @@ static int imx_startup(struct uart_port *port)
 	temp = readl(sport->port.membase + UCR1);
 	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
 
-	if (USE_IRDA(sport)) {
-		temp |= UCR1_IREN;
-		temp &= ~(UCR1_RTSDEN);
-	}
-
 	writel(temp, sport->port.membase + UCR1);
 
 	temp = readl(sport->port.membase + UCR4);
@@ -1209,38 +1128,12 @@ static int imx_startup(struct uart_port *port)
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
 
@@ -1276,13 +1169,6 @@ static void imx_shutdown(struct uart_port *port)
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
@@ -1295,8 +1181,6 @@ static void imx_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
-	if (USE_IRDA(sport))
-		temp &= ~(UCR1_IREN);
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1452,24 +1336,16 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -1908,9 +1784,6 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
 		sport->have_rtscts = 1;
 
-	if (of_get_property(np, "fsl,irda-mode", NULL))
-		sport->use_irda = 1;
-
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
@@ -1939,9 +1812,6 @@ static void serial_imx_probe_pdata(struct imx_port *sport,
 
 	if (pdata->flags & IMXUART_HAVE_RTSCTS)
 		sport->have_rtscts = 1;
-
-	if (pdata->flags & IMXUART_IRDA)
-		sport->use_irda = 1;
 }
 
 static int serial_imx_probe(struct platform_device *pdev)
@@ -2014,15 +1884,6 @@ static int serial_imx_probe(struct platform_device *pdev)
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
diff --git a/include/linux/platform_data/serial-imx.h b/include/linux/platform_data/serial-imx.h
index 3cc2e3c40914..a938eba2f18e 100644
--- a/include/linux/platform_data/serial-imx.h
+++ b/include/linux/platform_data/serial-imx.h
@@ -20,14 +20,9 @@
 #define ASMARM_ARCH_UART_H
 
 #define IMXUART_HAVE_RTSCTS (1<<0)
-#define IMXUART_IRDA        (1<<1)
 
 struct imxuart_platform_data {
 	unsigned int flags;
-	void (*irda_enable)(int enable);
-	unsigned int irda_inv_rx:1;
-	unsigned int irda_inv_tx:1;
-	unsigned short transceiver_delay;
 };
 
 #endif
-- 
2.1.4
