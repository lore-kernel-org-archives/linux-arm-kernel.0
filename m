From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 14 Mar 2011 00:27:10 +0200
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
Message-ID: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a race condition in stop_queue(),
if drv_data->queue is empty, but drv_data->busy is still set
(or opposite situation) stop_queue will return -EBUSY.
So fix loop condition to check that both drv_data->queue is empty
and drv_data->busy is not set.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/spi/pxa2xx_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index a429b01..3aa7820 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1493,7 +1493,7 @@ static int stop_queue(struct driver_data *drv_data)
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead */
 	drv_data->run = QUEUE_STOPPED;
-	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
+	while ((!list_empty(&drv_data->queue) || drv_data->busy) && limit--) {
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 		msleep(10);
 		spin_lock_irqsave(&drv_data->lock, flags);
-- 
1.7.4.1
