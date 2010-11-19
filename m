From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 19 Nov 2010 09:00:11 -0800
Subject: [PATCH] spi/pxa2xx: register driver properly
Message-ID: <mailman.27.1290768644.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use platform_driver_register instead of platform_driver_probe. The
latter only checks available devices at the time of calling. So if a
device gets inserter at a later point in time then the driver will never
play with it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index e76b1af..4e169b5 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1366,7 +1366,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static int __init init_queue(struct driver_data *drv_data)
+static int __devinit init_queue(struct driver_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1454,7 +1454,7 @@ static int destroy_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static int __init pxa2xx_spi_probe(struct platform_device *pdev)
+static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
@@ -1723,13 +1723,14 @@ static struct platform_driver driver = {
 		.pm	= &pxa2xx_spi_pm_ops,
 #endif
 	},
+	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
 	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
 {
-	return platform_driver_probe(&driver, pxa2xx_spi_probe);
+	return platform_driver_register(&driver);
 }
 subsys_initcall(pxa2xx_spi_init);
 
-- 
1.7.3.2
