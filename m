From: jslaby@suse.cz (Jiri Slaby)
Date: Fri, 29 Apr 2016 11:22:01 +0200
Subject: [PATCH] tty: serial, return values platform_get_irq, part II.
Message-ID: <1461921721-30169-1-git-send-email-jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When commit "TTY: serial, handle platform_get_irq retval properly" was
merged, it was pointed out, that platform_get_irq is more peculiar
than it seems.

platform_get_irq can actually return zero for some platforms. So
reverts parts of the aforementioned commits which did the worng thing
on those platforms.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "Uwe Kleine-K?nig" <kernel@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 drivers/tty/serial/efm32-uart.c    | 4 ++--
 drivers/tty/serial/pmac_zilog.c    | 2 +-
 drivers/tty/serial/uartlite.c      | 2 +-
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index efadba355a20..195acc868763 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -724,7 +724,7 @@ static int efm32_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
+	if (ret <= 0) {
 		dev_dbg(&pdev->dev, "failed to get rx irq\n");
 		goto err_get_rxirq;
 	}
@@ -732,7 +732,7 @@ static int efm32_uart_probe(struct platform_device *pdev)
 	efm_port->port.irq = ret;
 
 	ret = platform_get_irq(pdev, 1);
-	if (ret < 0)
+	if (ret <= 0)
 		ret = efm_port->port.irq + 1;
 
 	efm_port->txirq = ret;
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 0f086a2559ff..b24b0556f5a8 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1720,7 +1720,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 
 	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(uap->pdev, 0);
-	if (!r_ports || irq < 0)
+	if (!r_ports || irq <= 0)
 		return -ENODEV;
 
 	uap->port.mapbase  = r_ports->start;
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 0e4e398c66c0..c9fdfc8bf47f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -693,7 +693,7 @@ static int ulite_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq <= 0)
 		return -ENXIO;
 
 	return ulite_assign(&pdev->dev, id, res->start, irq);
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 34a705b15a4f..cd46e64c4255 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1368,7 +1368,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	if (irq <= 0) {
 		rc = -ENXIO;
 		goto err_out_clk_disable;
 	}
-- 
2.8.1
