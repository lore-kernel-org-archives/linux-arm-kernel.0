From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 29 May 2012 16:26:14 +0530
Subject: [PATCHv10 02/11] I2C: OMAP: Fix the mismatch of pm_runtime enable and
 disable
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1338288983-15026-3-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the i2c driver calls the pm_runtime_enable and never
the disable. This may cause a warning when pm_runtime_enable
checks for the count match.Fix the same by calling
pm_runtime_disable in the error and the remove path.

Cc: Rajendra Nayak <rnayak@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
-v10 Adding Kevin's ack.
-v9 Remove attempting from the changelogs.

 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4f4188d..c851672 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1090,6 +1090,7 @@ err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
 	iounmap(dev->base);
+	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
@@ -1110,6 +1111,7 @@ omap_i2c_remove(struct platform_device *pdev)
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	pm_runtime_disable(&pdev->dev);
 	iounmap(dev->base);
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.5.4
