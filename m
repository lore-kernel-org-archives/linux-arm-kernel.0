From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 22 Jan 2018 15:42:58 +0100
Subject: [PATCH] i2c: davinci: fix the cpufreq transition
Message-ID: <20180122144258.13627-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

i2c_davinci_cpufreq_transition() is implemented in a way that will
block if it ever gets called while no transfer is in progress.

Not only that, but reinit_completion() is never called for xfr_complete.

Use the fact that cpufreq uses an srcu_notifier (running in process
context) for transitions and that the bus_lock is taken during the call
to master_xfer() and simplify the code by removing the transfer
completion entirely and protecting i2c_davinci_cpufreq_transition()
with i2c_lock/unlock_adapter().

Reported-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/i2c/busses/i2c-davinci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2ead9b9eebb7..53ebf0dec1ad 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -139,7 +139,6 @@ struct davinci_i2c_dev {
 	u8			terminate;
 	struct i2c_adapter	adapter;
 #ifdef CONFIG_CPU_FREQ
-	struct completion	xfr_complete;
 	struct notifier_block	freq_transition;
 #endif
 	struct davinci_i2c_platform_data *pdata;
@@ -567,9 +566,6 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
 	ret = num;
-#ifdef CONFIG_CPU_FREQ
-	complete(&dev->xfr_complete);
-#endif
 
 out:
 	pm_runtime_mark_last_busy(dev->dev);
@@ -717,13 +713,15 @@ static int i2c_davinci_cpufreq_transition(struct notifier_block *nb,
 	struct davinci_i2c_dev *dev;
 
 	dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
+
+	i2c_lock_adapter(&dev->adapter);
 	if (val == CPUFREQ_PRECHANGE) {
-		wait_for_completion(&dev->xfr_complete);
 		davinci_i2c_reset_ctrl(dev, 0);
 	} else if (val == CPUFREQ_POSTCHANGE) {
 		i2c_davinci_calc_clk_dividers(dev);
 		davinci_i2c_reset_ctrl(dev, 1);
 	}
+	i2c_unlock_adapter(&dev->adapter);
 
 	return 0;
 }
@@ -789,9 +787,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&dev->cmd_complete);
-#ifdef CONFIG_CPU_FREQ
-	init_completion(&dev->xfr_complete);
-#endif
+
 	dev->dev = &pdev->dev;
 	dev->irq = irq;
 	dev->pdata = dev_get_platdata(&pdev->dev);
-- 
2.15.1
