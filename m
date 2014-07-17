From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 17 Jul 2014 16:48:40 +0200
Subject: [PATCH v2 5/5] i2c: tegra: Remove suspension check
In-Reply-To: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
Message-ID: <1405608520-5644-5-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now take care of suspension in the i2c core code. So we can remove this
check here.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
same as v1

 drivers/i2c/busses/i2c-tegra.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index f1bb2fc..c279d85 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -172,7 +172,6 @@ struct tegra_i2c_dev {
 	size_t msg_buf_remaining;
 	int msg_read;
 	u32 bus_clk_rate;
-	bool is_suspended;
 };
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned long reg)
@@ -628,9 +627,6 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int i;
 	int ret = 0;
 
-	if (i2c_dev->is_suspended)
-		return -EBUSY;
-
 	ret = tegra_i2c_clock_enable(i2c_dev);
 	if (ret < 0) {
 		dev_err(i2c_dev->dev, "Clock enable failed %d\n", ret);
@@ -817,17 +813,6 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra_i2c_suspend(struct device *dev)
-{
-	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-
-	i2c_lock_adapter(&i2c_dev->adapter);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
-
-	return 0;
-}
-
 static int tegra_i2c_resume(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
@@ -842,14 +827,12 @@ static int tegra_i2c_resume(struct device *dev)
 		return ret;
 	}
 
-	i2c_dev->is_suspended = false;
-
 	i2c_unlock_adapter(&i2c_dev->adapter);
 
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
+static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_resume);
 #define TEGRA_I2C_PM	(&tegra_i2c_pm)
 #else
 #define TEGRA_I2C_PM	NULL
-- 
1.9.1
