From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Sep 2015 16:47:10 +0100
Subject: [PATCH 14/17] media: st-rc: remove misuse of IRQF_NO_SUSPEND flag
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1442850433-5903-15-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device is set as wakeup capable using proper wakeup API but the
driver misuses IRQF_NO_SUSPEND to set the interrupt as wakeup source
which is incorrect.

This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
enable_irq_wake instead.

Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: kernel at stlinux.com
Cc: linux-media at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/media/rc/st_rc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
index 37d040158dff..1fa0c9d1c508 100644
--- a/drivers/media/rc/st_rc.c
+++ b/drivers/media/rc/st_rc.c
@@ -16,6 +16,7 @@
 #include <linux/reset.h>
 #include <media/rc-core.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_wakeirq.h>
 
 struct st_rc_device {
 	struct device			*dev;
@@ -190,6 +191,9 @@ static void st_rc_hardware_init(struct st_rc_device *dev)
 static int st_rc_remove(struct platform_device *pdev)
 {
 	struct st_rc_device *rc_dev = platform_get_drvdata(pdev);
+
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 	clk_disable_unprepare(rc_dev->sys_clock);
 	rc_unregister_device(rc_dev->rdev);
 	return 0;
@@ -298,22 +302,22 @@ static int st_rc_probe(struct platform_device *pdev)
 	rdev->map_name = RC_MAP_LIRC;
 	rdev->input_name = "ST Remote Control Receiver";
 
-	/* enable wake via this device */
-	device_set_wakeup_capable(dev, true);
-	device_set_wakeup_enable(dev, true);
-
 	ret = rc_register_device(rdev);
 	if (ret < 0)
 		goto clkerr;
 
 	rc_dev->rdev = rdev;
 	if (devm_request_irq(dev, rc_dev->irq, st_rc_rx_interrupt,
-			IRQF_NO_SUSPEND, IR_ST_NAME, rc_dev) < 0) {
+			     0, IR_ST_NAME, rc_dev) < 0) {
 		dev_err(dev, "IRQ %d register failed\n", rc_dev->irq);
 		ret = -EINVAL;
 		goto rcerr;
 	}
 
+	/* enable wake via this device */
+	device_init_wakeup(dev, true);
+	dev_pm_set_wake_irq(dev, rc_dev->irq);
+
 	/**
 	 * for LIRC_MODE_MODE2 or LIRC_MODE_PULSE or LIRC_MODE_RAW
 	 * lircd expects a long space first before a signal train to sync.
-- 
1.9.1
