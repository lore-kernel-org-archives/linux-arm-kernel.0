From: shaju.abraham@linaro.org (shaju.abraham at linaro.org)
Date: Fri, 03 Sep 2010 10:45:34 +0530
Subject: [PATCH] Serial: Samsung: Fix uart clock init order
Message-ID: <1283490934-9728-1-git-send-email-shaju.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaju Abraham <shaju.abraham@linaro.org>

The clk_get API returns -ENOENT when invoked from s3c24xx_serial_initconsole.
This happens since the serial_console gets registered before the platform
driver is registered.Defer the call to clk_get to s3c24xx_serial_probe so that
the API returns a valid clock.

Signed-off-by: Shaju Abraham <shaju.abraham@linaro.org>
---
 drivers/serial/samsung.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index b1156ba..f6a526a 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -1115,7 +1115,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (ret > 0)
 		ourport->tx_irq = ret;
 
-	ourport->clk	= clk_get(&platdev->dev, "uart");
 
 	dbg("port: map=%08x, mem=%08x, irq=%d (%d,%d), clock=%ld\n",
 	    port->mapbase, port->membase, port->irq,
@@ -1159,6 +1158,8 @@ int s3c24xx_serial_probe(struct platform_device *dev,
 	if (ret < 0)
 		goto probe_err;
 
+	ourport->clk	= clk_get(&dev->dev, "uart");
+
 	dbg("%s: adding port\n", __func__);
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
 	platform_set_drvdata(dev, &ourport->port);
-- 
1.6.2.5
