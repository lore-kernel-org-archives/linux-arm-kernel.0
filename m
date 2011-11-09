From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 9 Nov 2011 11:39:30 +0100
Subject: [PATCH 6/6] spi/pl022: add support for pm_runtime autosuspend
Message-ID: <1320835170-31370-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Blair <chris.blair@stericsson.com>

Adds support for configuring the spi bus to use autosuspend for
runtime power management. This can reduce the latency in starting an
spi transfer by not suspending the device immediately following
completion of a transfer. If another transfer then takes place before
the autosuspend timeout, the call to resume the device can return
immediately rather than needing to risk sleeping in order to resume
the device.

Signed-off-by: Chris Blair <chris.blair@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c    |   20 ++++++++++++++++++--
 include/linux/amba/pl022.h |    4 ++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2e3522d..d3d6521 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1515,7 +1515,13 @@ static void pump_messages(struct work_struct *work)
 			/* nothing more to do - disable spi/ssp and power off */
 			writew((readw(SSP_CR1(pl022->virtbase)) &
 				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-			pm_runtime_put(&pl022->adev->dev);
+
+			if (pl022->master_info->autosuspend_delay > 0) {
+				pm_runtime_mark_last_busy(&pl022->adev->dev);
+				pm_runtime_put_autosuspend(&pl022->adev->dev);
+			} else {
+				pm_runtime_put(&pl022->adev->dev);
+			}
 		}
 		pl022->busy = false;
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
@@ -2245,7 +2251,17 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(dev, "probe succeeded\n");
 
 	/* let runtime pm put suspend */
-	pm_runtime_put(dev);
+	if (platform_info->autosuspend_delay > 0) {
+		dev_info(&adev->dev,
+			"will use autosuspend for runtime pm, delay %dms\n",
+			platform_info->autosuspend_delay);
+		pm_runtime_set_autosuspend_delay(dev,
+			platform_info->autosuspend_delay);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
+	} else {
+		pm_runtime_put(dev);
+	}
 	return 0;
 
  err_spi_register:
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 4ce98f5..572f637 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -238,6 +238,9 @@ struct dma_chan;
  * @enable_dma: if true enables DMA driven transfers.
  * @dma_rx_param: parameter to locate an RX DMA channel.
  * @dma_tx_param: parameter to locate a TX DMA channel.
+ * @autosuspend_delay: delay in ms following transfer completion before the
+ *     runtime power management system suspends the device. A setting of 0
+ *     indicates no delay and the device will be suspended immediately.
  */
 struct pl022_ssp_controller {
 	u16 bus_id;
@@ -246,6 +249,7 @@ struct pl022_ssp_controller {
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
+	int autosuspend_delay;
 };
 
 /**
-- 
1.7.3.2
