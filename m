From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 27 Mar 2016 17:10:57 -0400
Subject: [PATCH 3/4] drivers/bus: make simple-pm-bus.c explicitly non-modular
In-Reply-To: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1459113058-14340-4-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

config SIMPLE_PM_BUS
        bool "Simple Power-Managed Bus Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/simple-pm-bus.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index c5eb46cbf388..e194ef4a7583 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -1,6 +1,8 @@
 /*
  * Simple Power-Managed Bus Driver
  *
+ * Author: Geert Uytterhoeven <geert+renesas@glider.be>
+ *
  * Copyright (C) 2014-2015 Glider bvba
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -8,7 +10,7 @@
  * for more details.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -28,31 +30,17 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int simple_pm_bus_remove(struct platform_device *pdev)
-{
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
-	pm_runtime_disable(&pdev->dev);
-	return 0;
-}
-
 static const struct of_device_id simple_pm_bus_of_match[] = {
 	{ .compatible = "simple-pm-bus", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
 
 static struct platform_driver simple_pm_bus_driver = {
 	.probe = simple_pm_bus_probe,
-	.remove = simple_pm_bus_remove,
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
-
-module_platform_driver(simple_pm_bus_driver);
-
-MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
-MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(simple_pm_bus_driver);
-- 
2.6.1
