From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 11:49:56 +0100
Subject: [PATCH v1] i2c: i2c-stm32f7: add PM Runtime support
Message-ID: <1542365396-9959-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PM Runtime API to enable/disable clock

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 142 +++++++++++++++++++++++++++------------
 1 file changed, 99 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 62d023e..4623b82 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -27,6 +27,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -1545,15 +1547,13 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 	i2c_dev->msg_id = 0;
 	f7_msg->smbus = false;
 
-	ret = clk_enable(i2c_dev->clk);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Failed to enable clock\n");
+	ret = pm_runtime_get_sync(i2c_dev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32f7_i2c_wait_free_bus(i2c_dev);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	stm32f7_i2c_xfer_msg(i2c_dev, msgs);
 
@@ -1569,8 +1569,9 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 		ret = -ETIMEDOUT;
 	}
 
-clk_free:
-	clk_disable(i2c_dev->clk);
+pm_free:
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
 
 	return (ret < 0) ? ret : num;
 }
@@ -1592,39 +1593,37 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	f7_msg->read_write = read_write;
 	f7_msg->smbus = true;
 
-	ret = clk_enable(i2c_dev->clk);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Failed to enable clock\n");
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32f7_i2c_wait_free_bus(i2c_dev);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	ret = stm32f7_i2c_smbus_xfer_msg(i2c_dev, flags, command, data);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	timeout = wait_for_completion_timeout(&i2c_dev->complete,
 					      i2c_dev->adap.timeout);
 	ret = f7_msg->result;
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	if (!timeout) {
 		dev_dbg(dev, "Access to slave 0x%x timed out\n", f7_msg->addr);
 		if (i2c_dev->use_dma)
 			dmaengine_terminate_all(dma->chan_using);
 		ret = -ETIMEDOUT;
-		goto clk_free;
+		goto pm_free;
 	}
 
 	/* Check PEC */
 	if ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && read_write) {
 		ret = stm32f7_i2c_smbus_check_pec(i2c_dev);
 		if (ret)
-			goto clk_free;
+			goto pm_free;
 	}
 
 	if (read_write && size != I2C_SMBUS_QUICK) {
@@ -1649,8 +1648,9 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 		}
 	}
 
-clk_free:
-	clk_disable(i2c_dev->clk);
+pm_free:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -1676,13 +1676,9 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 	if (ret)
 		return ret;
 
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
-		ret = clk_enable(i2c_dev->clk);
-		if (ret) {
-			dev_err(dev, "Failed to enable clock\n");
-			return ret;
-		}
-	}
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
 
 	if (id == 0) {
 		/* Configure Own Address 1 */
@@ -1703,7 +1699,7 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		oar2 &= ~STM32F7_I2C_OAR2_MASK;
 		if (slave->flags & I2C_CLIENT_TEN) {
 			ret = -EOPNOTSUPP;
-			goto exit;
+			goto pm_free;
 		}
 
 		oar2 |= STM32F7_I2C_OAR2_OA2_7(slave->addr);
@@ -1712,7 +1708,7 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		writel_relaxed(oar2, i2c_dev->base + STM32F7_I2C_OAR2);
 	} else {
 		ret = -ENODEV;
-		goto exit;
+		goto pm_free;
 	}
 
 	/* Enable ACK */
@@ -1723,11 +1719,10 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		STM32F7_I2C_CR1_PE;
 	stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
 
-	return 0;
-
-exit:
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
-		clk_disable(i2c_dev->clk);
+	ret = 0;
+pm_free:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -1745,6 +1740,10 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 
 	WARN_ON(!i2c_dev->slave[id]);
 
+	ret = pm_runtime_get_sync(i2c_dev->dev);
+	if (ret < 0)
+		return ret;
+
 	if (id == 0) {
 		mask = STM32F7_I2C_OAR1_OA1EN;
 		stm32f7_i2c_clr_bits(base + STM32F7_I2C_OAR1, mask);
@@ -1755,10 +1754,11 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 
 	i2c_dev->slave[id] = NULL;
 
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
+	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
 		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
-		clk_disable(i2c_dev->clk);
-	}
+
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
 
 	return 0;
 }
@@ -1819,6 +1819,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Error: Missing controller clock\n");
 		return PTR_ERR(i2c_dev->clk);
 	}
+
 	ret = clk_prepare_enable(i2c_dev->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare_enable clock\n");
@@ -1888,8 +1889,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_free;
 
-	stm32f7_i2c_hw_config(i2c_dev);
-
 	adap = &i2c_dev->adap;
 	i2c_set_adapdata(adap, i2c_dev);
 	snprintf(adap->name, sizeof(adap->name), "STM32F7 I2C(%pa)",
@@ -1908,18 +1907,35 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 					     STM32F7_I2C_TXDR,
 					     STM32F7_I2C_RXDR);
 
-	ret = i2c_add_adapter(adap);
-	if (ret)
-		goto clk_free;
-
 	platform_set_drvdata(pdev, i2c_dev);
 
-	clk_disable(i2c_dev->clk);
+	pm_runtime_set_autosuspend_delay(i2c_dev->dev,
+					 STM32F7_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(i2c_dev->dev);
+	pm_runtime_set_active(i2c_dev->dev);
+	pm_runtime_enable(i2c_dev->dev);
+
+	pm_runtime_get_noresume(&pdev->dev);
+
+	stm32f7_i2c_hw_config(i2c_dev);
+
+	ret = i2c_add_adapter(adap);
+	if (ret)
+		goto pm_disable;
 
 	dev_info(i2c_dev->dev, "STM32F7 I2C-%d bus adapter\n", adap->nr);
 
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
+
 	return 0;
 
+pm_disable:
+	pm_runtime_put_noidle(i2c_dev->dev);
+	pm_runtime_disable(i2c_dev->dev);
+	pm_runtime_set_suspended(i2c_dev->dev);
+	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
+
 clk_free:
 	clk_disable_unprepare(i2c_dev->clk);
 
@@ -1936,12 +1952,51 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
 	}
 
 	i2c_del_adapter(&i2c_dev->adap);
+	pm_runtime_get_sync(i2c_dev->dev);
+
+	clk_disable_unprepare(i2c_dev->clk);
 
-	clk_unprepare(i2c_dev->clk);
+	pm_runtime_put_noidle(i2c_dev->dev);
+	pm_runtime_disable(i2c_dev->dev);
+	pm_runtime_set_suspended(i2c_dev->dev);
+	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int stm32f7_i2c_runtime_suspend(struct device *dev)
+{
+	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
+
+	if (!stm32f7_i2c_is_slave_registered(i2c_dev))
+		clk_disable_unprepare(i2c_dev->clk);
+
+	return 0;
+}
+
+static int stm32f7_i2c_runtime_resume(struct device *dev)
+{
+	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
+	int ret;
+
+	if (!stm32f7_i2c_is_slave_registered(i2c_dev)) {
+		ret = clk_prepare_enable(i2c_dev->clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare_enable clock\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32f7_i2c_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32f7_i2c_runtime_suspend,
+			   stm32f7_i2c_runtime_resume, NULL)
+};
+
 static const struct of_device_id stm32f7_i2c_match[] = {
 	{ .compatible = "st,stm32f7-i2c", .data = &stm32f7_setup},
 	{},
@@ -1952,6 +2007,7 @@ static struct platform_driver stm32f7_i2c_driver = {
 	.driver = {
 		.name = "stm32f7-i2c",
 		.of_match_table = stm32f7_i2c_match,
+		.pm = &stm32f7_i2c_pm_ops,
 	},
 	.probe = stm32f7_i2c_probe,
 	.remove = stm32f7_i2c_remove,
-- 
2.7.4
