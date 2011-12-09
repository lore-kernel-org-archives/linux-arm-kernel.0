From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  9 Dec 2011 13:55:24 -0200
Subject: [PATCH v3 1/2] tty: serial: imx: Allow UART to be a source for wakeup
In-Reply-To: <1323434541-27689-1-git-send-email-festevam@gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
Message-ID: <1323446124-11865-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow UART to be a source for wakeup from low power mode.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Remove incorrect enable_irq_wake from serial_imx_resume
Changes since v1:
- Pass the can-wake property via DT correctly
 .../bindings/tty/serial/fsl-imx-uart.txt           |    2 +
 arch/arm/plat-mxc/include/mach/imx-uart.h          |    1 +
 drivers/tty/serial/imx.c                           |   36 ++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
index a9c0406..676cc39 100644
--- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
@@ -8,6 +8,8 @@ Required properties:
 Optional properties:
 - fsl,uart-has-rtscts : Indicate the uart has rts and cts
 - fsl,irda-mode : Indicate the uart supports irda mode
+- fsl,uart-can-wake : Indicate that uart can be a source for wakeup from
+low-power mode
 
 Example:
 
diff --git a/arch/arm/plat-mxc/include/mach/imx-uart.h b/arch/arm/plat-mxc/include/mach/imx-uart.h
index 4adec9b..0ba6c6b 100644
--- a/arch/arm/plat-mxc/include/mach/imx-uart.h
+++ b/arch/arm/plat-mxc/include/mach/imx-uart.h
@@ -21,6 +21,7 @@
 
 #define IMXUART_HAVE_RTSCTS (1<<0)
 #define IMXUART_IRDA        (1<<1)
+#define IMXUART_CANWAKE     (1<<2)
 
 struct imxuart_platform_data {
 	int (*init)(struct platform_device *pdev);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..f0b736e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -200,6 +200,7 @@ struct imx_port {
 	int			txirq,rxirq,rtsirq;
 	unsigned int		have_rtscts:1;
 	unsigned int		use_irda:1;
+	unsigned int		can_wake:1;
 	unsigned int		irda_inv_rx:1;
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
@@ -566,6 +567,9 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts & USR1_RTSD)
 		imx_rtsint(irq, dev_id);
 
+	if (sts & USR1_AWAKE)
+		writel(USR1_AWAKE, sport->port.membase + USR1);
+
 	return IRQ_HANDLED;
 }
 
@@ -660,6 +664,7 @@ static int imx_setup_ufcr(struct imx_port *sport, unsigned int mode)
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
+	struct tty_struct *tty;
 	int retval;
 	unsigned long flags, temp;
 
@@ -791,6 +796,8 @@ static int imx_startup(struct uart_port *port)
 		if (pdata->irda_enable)
 			pdata->irda_enable(1);
 	}
+	tty = sport->port.state->port.tty;
+	device_set_wakeup_enable(tty->dev, 1);
 
 	return 0;
 
@@ -1269,6 +1276,15 @@ static struct uart_driver imx_reg = {
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
+	unsigned int val;
+
+	if (device_may_wakeup(&dev->dev)) {
+		enable_irq_wake(sport->rxirq);
+		/* enable wakeup from i.MX UART */
+		val = readl(sport->port.membase + UCR3);
+		val |= UCR3_AWAKEN;
+		writel(val, sport->port.membase + UCR3);
+	}
 
 	if (sport)
 		uart_suspend_port(&imx_reg, &sport->port);
@@ -1279,6 +1295,15 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 static int serial_imx_resume(struct platform_device *dev)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
+	unsigned int val;
+
+	if (device_may_wakeup(&dev->dev)) {
+		/* disable wakeup from i.MX UART */
+		val = readl(sport->port.membase + UCR3);
+		val &= ~UCR3_AWAKEN;
+		writel(val, sport->port.membase + UCR3);
+		disable_irq_wake(sport->rxirq);
+	}
 
 	if (sport)
 		uart_resume_port(&imx_reg, &sport->port);
@@ -1311,6 +1336,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,irda-mode", NULL))
 		sport->use_irda = 1;
 
+	if (of_get_property(np, "fsl,uart-can-wake", NULL))
+		sport->can_wake = 1;
+
 	sport->devdata = of_id->data;
 
 	return 0;
@@ -1339,6 +1367,9 @@ static void serial_imx_probe_pdata(struct imx_port *sport,
 
 	if (pdata->flags & IMXUART_IRDA)
 		sport->use_irda = 1;
+
+	if (pdata->flags & IMXUART_CANWAKE)
+		sport->can_wake = 1;
 }
 
 static int serial_imx_probe(struct platform_device *pdev)
@@ -1408,6 +1439,11 @@ static int serial_imx_probe(struct platform_device *pdev)
 		goto deinit;
 	platform_set_drvdata(pdev, &sport->port);
 
+	if (sport->can_wake)
+		device_init_wakeup(&pdev->dev, 1);
+	else
+		device_init_wakeup(&pdev->dev, 0);
+
 	return 0;
 deinit:
 	if (pdata && pdata->exit)
-- 
1.7.1
