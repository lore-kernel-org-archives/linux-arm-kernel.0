From: jslaby@suse.cz (Jiri Slaby)
Date: Thu, 31 Mar 2016 10:23:33 +0200
Subject: [PATCH 1/2] TTY: serial, handle platform_get_irq retval properly
Message-ID: <1459412614-4549-1-git-send-email-jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq:
* can fail => handle negative value
* can return 0 as irq number, change '<= 0' checks accordingly
* returns int => when converted to uint (e.g. uart_port->irq),
  '< 0' would not work on that, do '< 0' on the int instead
* '!retval' does not mean bad irq, 'retval < 0' does

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: "Uwe Kleine-K?nig" <kernel@pengutronix.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-serial at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c    | 8 +++++++-
 drivers/tty/serial/efm32-uart.c    | 4 ++--
 drivers/tty/serial/fsl_lpuart.c    | 8 +++++++-
 drivers/tty/serial/pmac_zilog.c    | 2 +-
 drivers/tty/serial/serial-tegra.c  | 7 ++++++-
 drivers/tty/serial/uartlite.c      | 2 +-
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 7 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7c198e0a3178..59f31073e746 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2552,11 +2552,17 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (!uap)
 		return -ENOMEM;
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	uap->port.irq	= ret;
+
 	uap->reg_offset	= vendor_sbsa.reg_offset;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.irq	= platform_get_irq(pdev, 0);
 	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 195acc868763..efadba355a20 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -724,7 +724,7 @@ static int efm32_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
+	if (ret < 0) {
 		dev_dbg(&pdev->dev, "failed to get rx irq\n");
 		goto err_get_rxirq;
 	}
@@ -732,7 +732,7 @@ static int efm32_uart_probe(struct platform_device *pdev)
 	efm_port->port.irq = ret;
 
 	ret = platform_get_irq(pdev, 1);
-	if (ret <= 0)
+	if (ret < 0)
 		ret = efm_port->port.irq + 1;
 
 	efm_port->txirq = ret;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3d790033744e..7f95f782a485 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1830,7 +1830,13 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->port.iotype = UPIO_MEM;
-	sport->port.irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	sport->port.irq = ret;
+
 	if (sport->lpuart32)
 		sport->port.ops = &lpuart32_pops;
 	else
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e156e39d620c..0f086a2559ff 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1720,7 +1720,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 
 	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(uap->pdev, 0);
-	if (!r_ports || !irq)
+	if (!r_ports || irq < 0)
 		return -ENODEV;
 
 	uap->port.mapbase  = r_ports->start;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 5dde7ed3950a..11e64624dcdc 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1312,7 +1312,12 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	}
 
 	u->iotype = UPIO_MEM32;
-	u->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+		return ret;
+	}
+	u->irq = ret;
 	u->regshift = 2;
 	ret = uart_add_one_port(&tegra_uart_driver, u);
 	if (ret < 0) {
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c9fdfc8bf47f..0e4e398c66c0 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -693,7 +693,7 @@ static int ulite_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return -ENXIO;
 
 	return ulite_assign(&pdev->dev, id, res->start, irq);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index cd46e64c4255..34a705b15a4f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1368,7 +1368,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		rc = -ENXIO;
 		goto err_out_clk_disable;
 	}
-- 
2.7.4
