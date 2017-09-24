From: vigneshr@ti.com (Vignesh R)
Date: Sun, 24 Sep 2017 16:29:24 +0530
Subject: [PATCH v3 5/5] mtd: spi-nor: cadence-quadspi: Add runtime PM support
In-Reply-To: <20170924105924.23923-1-vigneshr@ti.com>
References: <20170924105924.23923-1-vigneshr@ti.com>
Message-ID: <20170924105924.23923-6-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm_runtime* calls to cadence-quadspi driver. This is required to
switch on QSPI power domain on TI 66AK2G SoC during probe.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index d9629e8f4798..2c8e6226d267 100644
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
@@ -1224,6 +1225,13 @@ static int cqspi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
@@ -1275,6 +1283,9 @@ static int cqspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(cqspi->clk);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.14.1
