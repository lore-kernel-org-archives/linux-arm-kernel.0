From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 23 Jul 2018 20:32:02 +0530
Subject: [PATCH v2 3/4] iio: adc: xilinx: Remove platform_get_irq from
 xadc_remove function
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1532358123-23485-4-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch avoids getting irq number in xadc_remove function. Instead
store 'irq' in xadc struct and use xadc->irq wherever needed.
This patch also resolves a warning reported by coverity where it asks to
check return value of platform_get_irq() for any errors in xadc_remove.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 10 +++++-----
 drivers/iio/adc/xilinx-xadc.h      |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0dd306d..44a2519 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1175,6 +1175,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	xadc = iio_priv(indio_dev);
 	xadc->ops = id->data;
+	xadc->irq = irq;
 	init_completion(&xadc->completion);
 	mutex_init(&xadc->mutex);
 	spin_lock_init(&xadc->lock);
@@ -1225,11 +1226,11 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
-	ret = xadc->ops->setup(pdev, indio_dev, irq);
+	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
+	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
@@ -1288,7 +1289,7 @@ static int xadc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
-	free_irq(irq, indio_dev);
+	free_irq(xadc->irq, indio_dev);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
@@ -1310,7 +1311,6 @@ static int xadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct xadc *xadc = iio_priv(indio_dev);
-	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(indio_dev);
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
@@ -1318,7 +1318,7 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_trigger_free(xadc->convst_trigger);
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
-	free_irq(irq, indio_dev);
+	free_irq(xadc->irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
 	cancel_delayed_work(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 62edbda..8c00095 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -68,6 +68,7 @@ struct xadc {
 	spinlock_t lock;
 
 	struct completion completion;
+	int irq;
 };
 
 struct xadc_ops {
-- 
2.1.1
