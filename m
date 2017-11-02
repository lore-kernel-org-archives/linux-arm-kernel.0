From: preid@electromag.com.au (Phil Reid)
Date: Thu,  2 Nov 2017 10:40:26 +0800
Subject: [PATCH v5 3/7] i2c: designware: rename i2c_dw_plat_prepare_clk to
 i2c_dw_prepare_clk
In-Reply-To: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509590430-11968-4-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with the rest of the file rename function and parameter to
be consistent with the reset of the common file.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-common.c  | 10 +++++-----
 drivers/i2c/busses/i2c-designware-core.h    |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index b79f342..3d684c6 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -186,15 +186,15 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 	return dev->get_clk_rate_khz(dev);
 }
 
-int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
+int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
-	if (IS_ERR(i_dev->clk))
-		return PTR_ERR(i_dev->clk);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	if (prepare)
-		return clk_prepare_enable(i_dev->clk);
+		return clk_prepare_enable(dev->clk);
 
-	clk_disable_unprepare(i_dev->clk);
+	clk_disable_unprepare(dev->clk);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e80a14c..33c6c8f 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -301,7 +301,7 @@ struct dw_i2c_dev {
 void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable);
 void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable);
 unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev);
-int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare);
+int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare);
 int i2c_dw_acquire_lock(struct dw_i2c_dev *dev);
 void i2c_dw_release_lock(struct dw_i2c_dev *dev);
 int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index a5fd0ee..9c5f649 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -343,7 +343,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		i2c_dw_configure_master(dev);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!i2c_dw_plat_prepare_clk(dev, true)) {
+	if (!i2c_dw_prepare_clk(dev, true)) {
 		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
 		if (!dev->sda_hold_time && ht)
@@ -447,7 +447,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	}
 
 	i_dev->disable(i_dev);
-	i2c_dw_plat_prepare_clk(i_dev, false);
+	i2c_dw_prepare_clk(i_dev, false);
 
 	i_dev->suspended = true;
 
@@ -466,7 +466,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 		return 0;
 	}
 
-	i2c_dw_plat_prepare_clk(i_dev, true);
+	i2c_dw_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
 
 	i_dev->suspended = false;
-- 
1.8.3.1
