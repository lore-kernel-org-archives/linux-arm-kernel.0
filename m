From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:27 +0100
Subject: [PATCH 2/6] serial: pl010: Convert to modern PM ops
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to modern PM ops and use the SIMPLE_DEV_PM_OPS macro to set up
the PM callbacks.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/tty/serial/amba-pl010.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 33bd860..01c9e72 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -756,9 +756,10 @@ static int pl010_remove(struct amba_device *dev)
 	return 0;
 }
 
-static int pl010_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int pl010_suspend(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct uart_amba_port *uap = dev_get_drvdata(dev);
 
 	if (uap)
 		uart_suspend_port(&amba_reg, &uap->port);
@@ -766,15 +767,18 @@ static int pl010_suspend(struct amba_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int pl010_resume(struct amba_device *dev)
+static int pl010_resume(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct uart_amba_port *uap = dev_get_drvdata(dev);
 
 	if (uap)
 		uart_resume_port(&amba_reg, &uap->port);
 
 	return 0;
 }
+#endif
+
+static SIMPLE_DEV_PM_OPS(pl010_dev_pm_ops, pl010_suspend, pl010_resume);
 
 static struct amba_id pl010_ids[] = {
 	{
@@ -789,12 +793,11 @@ MODULE_DEVICE_TABLE(amba, pl010_ids);
 static struct amba_driver pl010_driver = {
 	.drv = {
 		.name	= "uart-pl010",
+		.pm	= &pl010_dev_pm_ops,
 	},
 	.id_table	= pl010_ids,
 	.probe		= pl010_probe,
 	.remove		= pl010_remove,
-	.suspend	= pl010_suspend,
-	.resume		= pl010_resume,
 };
 
 static int __init pl010_init(void)
-- 
1.7.9.5
