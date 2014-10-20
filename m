From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 20 Oct 2014 11:42:14 +0800
Subject: [PATCH 3/3] i2c/at91: adopt pinctrl support
In-Reply-To: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
References: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1413776535-10123-4-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amend the i2c at91 pin controller to optionally take a pin control
handle and set the state of the pins to:

- "default" on boot, resume and before performing an transfer
- "sleep" on suspend()

This should make it possible to optimize energy usage for the pins
both for the suspend/resume cycle

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 8f408f8..ed2c382 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
 #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
@@ -748,6 +749,8 @@ static int at91_twi_probe(struct platform_device *pdev)
 	u32 phy_addr;
 	u32 bus_clk_rate;
 
+	pinctrl_pm_select_default_state(&pdev->dev);
+
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
@@ -850,8 +853,10 @@ static int at91_twi_suspend(struct device *dev)
 {
 	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
 
-	if (!pm_runtime_suspended(dev))
+	if (!pm_runtime_suspended(dev)) {
 		clk_disable_unprepare(twi_dev->clk);
+		pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return 0;
 }
@@ -862,6 +867,7 @@ static int at91_twi_resume(struct device *dev)
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
+		pinctrl_pm_select_default_state(dev);
 		ret = clk_prepare_enable(twi_dev->clk);
 		if (ret)
 			return ret;
@@ -881,6 +887,8 @@ static int at91_twi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(twi_dev->clk);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -888,6 +896,8 @@ static int at91_twi_runtime_resume(struct device *dev)
 {
 	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	return clk_prepare_enable(twi_dev->clk);
 }
 #endif
-- 
1.7.9.5
