From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:28 +0100
Subject: [PATCH 3/6] serial: pl011: Convert to modern PM ops
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to modern PM ops and use the SIMPLE_DEV_PM_OPS macro to set up
the PM callbacks.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7203864..1273777 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2169,10 +2169,10 @@ static int pl011_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pl011_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int pl011_suspend(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct uart_amba_port *uap = dev_get_drvdata(dev);
 
 	if (!uap)
 		return -EINVAL;
@@ -2180,9 +2180,9 @@ static int pl011_suspend(struct amba_device *dev, pm_message_t state)
 	return uart_suspend_port(&amba_reg, &uap->port);
 }
 
-static int pl011_resume(struct amba_device *dev)
+static int pl011_resume(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct uart_amba_port *uap = dev_get_drvdata(dev);
 
 	if (!uap)
 		return -EINVAL;
@@ -2191,6 +2191,8 @@ static int pl011_resume(struct amba_device *dev)
 }
 #endif
 
+static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
+
 static struct amba_id pl011_ids[] = {
 	{
 		.id	= 0x00041011,
@@ -2210,14 +2212,11 @@ MODULE_DEVICE_TABLE(amba, pl011_ids);
 static struct amba_driver pl011_driver = {
 	.drv = {
 		.name	= "uart-pl011",
+		.pm	= &pl011_dev_pm_ops,
 	},
 	.id_table	= pl011_ids,
 	.probe		= pl011_probe,
 	.remove		= pl011_remove,
-#ifdef CONFIG_PM
-	.suspend	= pl011_suspend,
-	.resume		= pl011_resume,
-#endif
 };
 
 static int __init pl011_init(void)
-- 
1.7.9.5
