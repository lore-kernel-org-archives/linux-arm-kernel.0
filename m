From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 14:36:13 +0100
Subject: [PATCH] 8250: mediatek: mark PM functions as __maybe_unused
Message-ID: <1454938591-2743892-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtk8250_runtime_suspend function is not used when runtime PM is
disabled, so we get a warning about an unused function:

drivers/tty/serial/8250/8250_mtk.c:119:12: error: 'mtk8250_runtime_suspend' defined but not used [-Werror=unused-function]
 static int mtk8250_runtime_suspend(struct device *dev)

This marks all the PM functions as __maybe_unused to avoid the warning,
and removes the #ifdef around the PM_SLEEP functions for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 0e590b233f03..9038843cadc7 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -116,7 +116,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 }
 
-static int mtk8250_runtime_suspend(struct device *dev)
+static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -126,7 +126,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk8250_runtime_resume(struct device *dev)
+static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	int err;
@@ -245,8 +245,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mtk8250_suspend(struct device *dev)
+static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -255,7 +254,7 @@ static int mtk8250_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk8250_resume(struct device *dev)
+static int __maybe_unused mtk8250_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -263,7 +262,6 @@ static int mtk8250_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops mtk8250_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtk8250_suspend, mtk8250_resume)
-- 
2.7.0
