From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 22 Nov 2011 09:25:01 +0100
Subject: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
Message-ID: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Blair <chris.blair@stericsson.com>

Moves the disabling of the device and clocks to the same thread in
which the device and clocks are enabled. This avoids SMP issues where
the device can be enabled for a transfer by one thread and then
disabled by the completion of the previous transfer in another thread.

Signed-off-by: Chris Blair <chris.blair@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Moved this patch before the block disable patch at request from
  Viresh.
- Insert blank line...
---
 drivers/spi/spi-pl022.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index b4038f9..8cdf052 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -512,8 +512,6 @@ static void giveback(struct pl022 *pl022)
 	msg->state = NULL;
 	if (msg->complete)
 		msg->complete(msg->context);
-	/* This message is completed, so let's turn off the clocks & power */
-	pm_runtime_put(&pl022->adev->dev);
 }
 
 /**
@@ -1509,14 +1507,19 @@ static void pump_messages(struct work_struct *work)
 	struct pl022 *pl022 =
 		container_of(work, struct pl022, pump_messages);
 	unsigned long flags;
+	bool was_busy = false;
 
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&pl022->queue_lock, flags);
 	if (list_empty(&pl022->queue) || !pl022->running) {
+		if (pl022->busy) {
+			pm_runtime_put(&pl022->adev->dev);
+		}
 		pl022->busy = false;
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
 		return;
 	}
+
 	/* Make sure we are not already running a message */
 	if (pl022->cur_msg) {
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
@@ -1527,7 +1530,10 @@ static void pump_messages(struct work_struct *work)
 	    list_entry(pl022->queue.next, struct spi_message, queue);
 
 	list_del_init(&pl022->cur_msg->queue);
-	pl022->busy = true;
+	if (pl022->busy)
+		was_busy = true;
+	else
+		pl022->busy = true;
 	spin_unlock_irqrestore(&pl022->queue_lock, flags);
 
 	/* Initial message state */
@@ -1537,12 +1543,14 @@ static void pump_messages(struct work_struct *work)
 
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
-	/*
-	 * We enable the core voltage and clocks here, then the clocks
-	 * and core will be disabled when giveback() is called in each method
-	 * (poll/interrupt/DMA)
-	 */
-	pm_runtime_get_sync(&pl022->adev->dev);
+	if (!was_busy)
+		/*
+		 * We enable the core voltage and clocks here, then the clocks
+		 * and core will be disabled when this workqueue is run again
+		 * and there is no more work to be done.
+		 */
+		pm_runtime_get_sync(&pl022->adev->dev);
+
 	restore_state(pl022);
 	flush(pl022);
 
-- 
1.7.3.2
