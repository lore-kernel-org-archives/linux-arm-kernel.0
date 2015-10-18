From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 18 Oct 2015 18:21:18 -0400
Subject: [PATCH 5/5] drivers/tty/serial: make 8250/8250_mtk.c explicitly
 non-modular
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1445206878-12455-6-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/8250/Kconfig:config SERIAL_8250_MT6577
drivers/tty/serial/8250/Kconfig:        bool "Mediatek serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 78883ca64ddd..0e590b233f03 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -16,7 +16,7 @@
  */
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -245,23 +245,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk8250_remove(struct platform_device *pdev)
-{
-	struct mtk8250_data *data = platform_get_drvdata(pdev);
-
-	pm_runtime_get_sync(&pdev->dev);
-
-	serial8250_unregister_port(data->line);
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
-
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk8250_runtime_suspend(&pdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mtk8250_suspend(struct device *dev)
 {
@@ -292,18 +275,18 @@ static const struct of_device_id mtk8250_of_match[] = {
 	{ .compatible = "mediatek,mt6577-uart" },
 	{ /* Sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, mtk8250_of_match);
 
 static struct platform_driver mtk8250_platform_driver = {
 	.driver = {
-		.name		= "mt6577-uart",
-		.pm		= &mtk8250_pm_ops,
-		.of_match_table	= mtk8250_of_match,
+		.name			= "mt6577-uart",
+		.pm			= &mtk8250_pm_ops,
+		.of_match_table		= mtk8250_of_match,
+		.suppress_bind_attrs	= true,
+
 	},
 	.probe			= mtk8250_probe,
-	.remove			= mtk8250_remove,
 };
-module_platform_driver(mtk8250_platform_driver);
+builtin_platform_driver(mtk8250_platform_driver);
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_mtk8250_setup(struct earlycon_device *device,
@@ -319,7 +302,3 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
 #endif
-
-MODULE_AUTHOR("Matthias Brugger");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
-- 
2.6.1
