From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 27 Dec 2016 22:22:40 +0800
Subject: [PATCH v3 resend] i2c: designware: add reset interface
In-Reply-To: <y>
References: <y>
Message-ID: <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms like hi3660 need do reset first to allow accessing registers

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ramiro Oliveira <ramiro.oliveira@synopsys.com>
---
rebase to 4.10-rc1

 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 26250b4..302807c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -88,6 +88,7 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct reset_control	*rst;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	struct dw_pci_controller *controller;
 	int			cmd_err;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6ce4313..79c4b4e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -38,6 +38,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/io.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/platform_data/i2c-designware.h>
@@ -199,6 +200,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
+	dev->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(dev->rst)) {
+		if (PTR_ERR(dev->rst) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		reset_control_deassert(dev->rst);
+	}
+
 	if (pdata) {
 		dev->clk_freq = pdata->i2c_scl_freq;
 	} else {
@@ -235,12 +244,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000) {
 		dev_err(&pdev->dev,
 			"Only 100kHz, 400kHz, 1MHz and 3.4MHz supported");
-		return -EINVAL;
+		r = -EINVAL;
+		goto exit_reset;
 	}
 
 	r = i2c_dw_eval_lock_support(dev);
 	if (r)
-		return r;
+		goto exit_reset;
 
 	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
@@ -286,10 +296,18 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	r = i2c_dw_probe(dev);
-	if (r && !dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	if (r)
+		goto exit_probe;
 
 	return r;
+
+exit_probe:
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_disable(&pdev->dev);
+exit_reset:
+	if (!IS_ERR_OR_NULL(dev->rst))
+		reset_control_assert(dev->rst);
+	return r;
 }
 
 static int dw_i2c_plat_remove(struct platform_device *pdev)
@@ -306,6 +324,8 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	if (!dev->pm_runtime_disabled)
 		pm_runtime_disable(&pdev->dev);
+	if (!IS_ERR_OR_NULL(dev->rst))
+		reset_control_assert(dev->rst);
 
 	return 0;
 }
-- 
2.7.4
