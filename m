From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:39:14 +0000
Subject: [PATCH 27/33] MFD: ucb1x00-core: convert to use dev_pm_ops
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq40I-0000ZZ-G4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ucb1x00-core driver to use dev_pm_ops rather than the legacy
members in the mcp driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c  |   32 ++++++++++++++++++--------------
 include/linux/mfd/ucb1x00.h |    2 +-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index ed2a4b2..6fab825 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/mfd/ucb1x00.h>
+#include <linux/pm.h>
 #include <linux/gpio.h>
 
 static DEFINE_MUTEX(ucb1x00_mutex);
@@ -697,47 +698,50 @@ void ucb1x00_unregister_driver(struct ucb1x00_driver *drv)
 	mutex_unlock(&ucb1x00_mutex);
 }
 
-static int ucb1x00_suspend(struct mcp *mcp, pm_message_t state)
+static int ucb1x00_suspend(struct device *dev)
 {
-	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
-	struct ucb1x00_dev *dev;
+	struct ucb1x00 *ucb = dev_get_drvdata(dev);
+	struct ucb1x00_dev *udev;
 
 	mutex_lock(&ucb1x00_mutex);
-	list_for_each_entry(dev, &ucb->devs, dev_node) {
-		if (dev->drv->suspend)
-			dev->drv->suspend(dev, state);
+	list_for_each_entry(udev, &ucb->devs, dev_node) {
+		if (udev->drv->suspend)
+			udev->drv->suspend(udev);
 	}
 	mutex_unlock(&ucb1x00_mutex);
 	return 0;
 }
 
-static int ucb1x00_resume(struct mcp *mcp)
+static int ucb1x00_resume(struct device *dev)
 {
-	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
-	struct ucb1x00_dev *dev;
+	struct ucb1x00 *ucb = dev_get_drvdata(dev);
+	struct ucb1x00_dev *udev;
 
 	ucb1x00_enable(ucb);
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
 	ucb1x00_disable(ucb);
 	mutex_lock(&ucb1x00_mutex);
-	list_for_each_entry(dev, &ucb->devs, dev_node) {
-		if (dev->drv->resume)
-			dev->drv->resume(dev);
+	list_for_each_entry(udev, &ucb->devs, dev_node) {
+		if (udev->drv->resume)
+			udev->drv->resume(udev);
 	}
 	mutex_unlock(&ucb1x00_mutex);
 	return 0;
 }
 
+static const struct dev_pm_ops ucb1x00_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ucb1x00_suspend, ucb1x00_resume)
+};
+
 static struct mcp_driver ucb1x00_driver = {
 	.drv		= {
 		.name	= "ucb1x00",
 		.owner	= THIS_MODULE,
+		.pm	= &ucb1x00_pm_ops,
 	},
 	.probe		= ucb1x00_probe,
 	.remove		= ucb1x00_remove,
-	.suspend	= ucb1x00_suspend,
-	.resume		= ucb1x00_resume,
 };
 
 static int __init ucb1x00_init(void)
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index a4b9543..253c12c 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -154,7 +154,7 @@ struct ucb1x00_driver {
 	struct list_head	devs;
 	int	(*add)(struct ucb1x00_dev *dev);
 	void	(*remove)(struct ucb1x00_dev *dev);
-	int	(*suspend)(struct ucb1x00_dev *dev, pm_message_t state);
+	int	(*suspend)(struct ucb1x00_dev *dev);
 	int	(*resume)(struct ucb1x00_dev *dev);
 };
 
-- 
1.7.4.4
