From: ao2@ao2.it (Antonio Ospite)
Date: Fri, 30 May 2014 18:18:09 +0200
Subject: [PATCH] spi/pxa2xx: fix runtime PM enabling order
Message-ID: <1401466689-24335-1-git-send-email-ao2@ao2.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 7dd62787334ac6e0e2a0ef3f20bb1936ac431b04 (spi/pxa2xx: Convert
to core runtime PM) master->auto_runtime_pm was set to true.

In this case pm_runtime_enable() must be called *before*
spi_register_master(), otherwise the kernel hangs with this error
message:

  spi_master spi0: Failed to power device: -13

A similar fix, but for spi/hspi, was applied in
268d76430d1b68c340687357ffd18b4b12d02269.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Hi,

I must admit I copied from 268d76430d1b68c340687357ffd18b4b12d02269 without
understanding much of what is going on, but fact is that the patch makes my
board boot again.

Can anyone confirm that this is indeed the correct fix?

Thanks,
   Antonio

 drivers/spi/spi-pxa2xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 41185d0..a07b758 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1202,6 +1202,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = devm_spi_register_master(&pdev->dev, master);
@@ -1210,11 +1215,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		goto out_error_clock_enabled;
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	return status;
 
 out_error_clock_enabled:
-- 
2.0.0
