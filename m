From: balbi@ti.com (Felipe Balbi)
Date: Thu,  6 Sep 2012 15:45:29 +0300
Subject: [PATCH v4 10/21] serial: omap: make sure to suspend device before
 remove
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Message-ID: <1346935540-1792-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

before removing the driver, let's make sure
to force device into a suspended state in order
to conserve power.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c19d340..0ceca44 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1369,6 +1369,7 @@ static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
+	pm_runtime_put_sync(up->dev);
 	pm_runtime_disable(up->dev);
 	uart_remove_one_port(&serial_omap_reg, &up->port);
 	pm_qos_remove_request(&up->pm_qos_request);
-- 
1.7.12.rc3
