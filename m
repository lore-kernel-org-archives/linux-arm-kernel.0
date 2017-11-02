From: preid@electromag.com.au (Phil Reid)
Date: Thu,  2 Nov 2017 10:40:25 +0800
Subject: [PATCH v5 2/7] i2c: designware: move i2c_dw_plat_prepare_clk to common
In-Reply-To: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509590430-11968-3-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the i2c_dw_plat_prepare_clk funciton to common file in preparation
for its use also by the master driver.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-designware-common.c  | 13 +++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 12 ------------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index d1a6937..b79f342 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -21,6 +21,7 @@
  * ----------------------------------------------------------------------------
  *
  */
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/errno.h>
@@ -185,6 +186,18 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 	return dev->get_clk_rate_khz(dev);
 }
 
+int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
+{
+	if (IS_ERR(i_dev->clk))
+		return PTR_ERR(i_dev->clk);
+
+	if (prepare)
+		return clk_prepare_enable(i_dev->clk);
+
+	clk_disable_unprepare(i_dev->clk);
+	return 0;
+}
+
 int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
 {
 	int ret;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 21bf619..e80a14c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -301,6 +301,7 @@ struct dw_i2c_dev {
 void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable);
 void __i2c_dw_enable_and_wait(struct dw_i2c_dev *dev, bool enable);
 unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev);
+int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare);
 int i2c_dw_acquire_lock(struct dw_i2c_dev *dev);
 void i2c_dw_release_lock(struct dw_i2c_dev *dev);
 int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 58add69..a5fd0ee 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -214,18 +214,6 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 	}
 }
 
-static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
-{
-	if (IS_ERR(i_dev->clk))
-		return PTR_ERR(i_dev->clk);
-
-	if (prepare)
-		return clk_prepare_enable(i_dev->clk);
-
-	clk_disable_unprepare(i_dev->clk);
-	return 0;
-}
-
 static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 {
 	u32 param, tx_fifo_depth, rx_fifo_depth;
-- 
1.8.3.1
