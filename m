From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 15 Nov 2012 17:43:30 +0530
Subject: [PATCH 1/4] i2c-s3c2410: grab adapter lock while changing i2c clock
In-Reply-To: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1352981613-2098-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

We probably don't want to change I2C frequency while a transfer is in
progress.  The current implementation grabs a spinlock, but that only
protected the writes to IICCON when starting a message, it didn't protect
against clock changes in the middle of a transaction.

Note: The i2c-core already grabs the adapter lock before calling
s3c24xx_i2c_doxfer(), which ensures that only one caller is issuing a
xfer at a time. This means it is not necessary to disable interrupts
(spin_lock_irqsave) when changing frequencies, since there won't be
any i2c interrupts if there is no on-going xfer.

Lastly, i2c_lock_adapter() may cause the cpufreq_transition to sleep if
if a xfer is in progress, but this is ok since cpufreq notifiers are
called in a kernel thread, and there are already cases where it could
sleep, such as when using i2c to update the output of a voltage
regulator.

Note: the cpufreq part of this change has no functional affect on
	exynos, where the i2c clock is independent of the cpufreq.
	But, there is a slight perfomance boost since we no longer need to
	lock/unlock an additional spinlock.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Cc: Olof Johansson <olofj@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3e0335f..155cb04 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -59,7 +59,6 @@ enum s3c24xx_i2c_state {
 };
 
 struct s3c24xx_i2c {
-	spinlock_t		lock;
 	wait_queue_head_t	wait;
 	unsigned int            quirks;
 	unsigned int		suspended:1;
@@ -540,8 +539,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 		goto out;
 	}
 
-	spin_lock_irq(&i2c->lock);
-
 	i2c->msg     = msgs;
 	i2c->msg_num = num;
 	i2c->msg_ptr = 0;
@@ -550,7 +547,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 
 	s3c24xx_i2c_enable_irq(i2c);
 	s3c24xx_i2c_message_start(i2c, msgs);
-	spin_unlock_irq(&i2c->lock);
 
 	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
 
@@ -740,7 +736,6 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
 					  unsigned long val, void *data)
 {
 	struct s3c24xx_i2c *i2c = freq_to_i2c(nb);
-	unsigned long flags;
 	unsigned int got;
 	int delta_f;
 	int ret;
@@ -754,9 +749,9 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
 
 	if ((val == CPUFREQ_POSTCHANGE && delta_f < 0) ||
 	    (val == CPUFREQ_PRECHANGE && delta_f > 0)) {
-		spin_lock_irqsave(&i2c->lock, flags);
+		i2c_lock_adapter(&i2c->adap);
 		ret = s3c24xx_i2c_clockrate(i2c, &got);
-		spin_unlock_irqrestore(&i2c->lock, flags);
+		i2c_unlock_adapter(&i2c->adap);
 
 		if (ret < 0)
 			dev_err(i2c->dev, "cannot find frequency\n");
@@ -962,7 +957,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	i2c->adap.class   = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	i2c->tx_setup     = 50;
 
-	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 
 	/* find the clock and enable it */
-- 
1.7.9.5
