From: vigneshr@ti.com (Vignesh R)
Date: Tue, 3 Oct 2017 10:49:25 +0530
Subject: [PATCH v4 6/6] mtd: spi-nor: cadence-quadspi: Add runtime PM support
In-Reply-To: <20171003051925.8821-1-vigneshr@ti.com>
References: <20171003051925.8821-1-vigneshr@ti.com>
Message-ID: <20171003051925.8821-7-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm_runtime* calls to cadence-quadspi driver. This is required to
switch on QSPI power domain on TI 66AK2G SoC during probe.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v4: Disable pm in error path.

 drivers/mtd/spi-nor/cadence-quadspi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 60b557e00cfb..75a2bc447a99 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -31,6 +31,7 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/timer.h>
@@ -1224,10 +1225,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
-		return ret;
+		goto probe_clk_failed;
 	}
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
@@ -1259,6 +1267,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi_controller_enable(cqspi, 0);
 probe_irq_failed:
 	clk_disable_unprepare(cqspi->clk);
+probe_clk_failed:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -1275,6 +1286,9 @@ static int cqspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(cqspi->clk);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.14.1
