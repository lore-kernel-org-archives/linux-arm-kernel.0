From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 23 Sep 2014 16:34:12 +0800
Subject: [PATCH] serial: of-serial: add PM suspend/resume support
Message-ID: <1411461252-8730-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds PM suspend/resume support for the of-serial driver
to provide power management support on devices attatched to it.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/tty/serial/of_serial.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 27981e2..8bc2563 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -240,6 +240,32 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int of_serial_suspend(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	serial8250_suspend_port(info->line);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int of_serial_resume(struct device *dev)
+{
+	struct of_serial_info *info = dev_get_drvdata(dev);
+
+	if (info->clk)
+		clk_prepare_enable(info->clk);
+
+	serial8250_resume_port(info->line);
+
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
+
 /*
  * A few common types, add more as needed.
  */
@@ -271,6 +297,7 @@ static struct platform_driver of_platform_serial_driver = {
 		.name = "of_serial",
 		.owner = THIS_MODULE,
 		.of_match_table = of_platform_serial_table,
+		.pm = &of_serial_pm_ops,
 	},
 	.probe = of_platform_serial_probe,
 	.remove = of_platform_serial_remove,
-- 
1.8.0
