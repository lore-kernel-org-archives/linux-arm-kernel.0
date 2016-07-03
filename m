From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 3 Jul 2016 13:30:39 -0400
Subject: [PATCH 3/4] bus: tegra-aconnect: make it explicitly non-modular
In-Reply-To: <20160703173040.23612-1-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
Message-ID: <20160703173040.23612-4-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/bus/Kconfig:config TEGRA_ACONNECT
drivers/bus/Kconfig:    bool "Tegra ACONNECT Bus Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/tegra-aconnect.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/tegra-aconnect.c b/drivers/bus/tegra-aconnect.c
index 7e4104b74fa8..f3982946ab8a 100644
--- a/drivers/bus/tegra-aconnect.c
+++ b/drivers/bus/tegra-aconnect.c
@@ -1,6 +1,8 @@
 /*
  * Tegra ACONNECT Bus Driver
  *
+ * Author: Jon Hunter <jonathanh@nvidia.com>
+ *
  * Copyright (C) 2016, NVIDIA CORPORATION.  All rights reserved.
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -9,7 +11,7 @@
  */
 
 #include <linux/clk.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
@@ -66,15 +68,6 @@ clk_destroy:
 	return ret;
 }
 
-static int tegra_aconnect_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-
-	pm_clk_destroy(&pdev->dev);
-
-	return 0;
-}
-
 static int tegra_aconnect_runtime_resume(struct device *dev)
 {
 	return pm_clk_resume(dev);
@@ -94,19 +87,14 @@ static const struct of_device_id tegra_aconnect_of_match[] = {
 	{ .compatible = "nvidia,tegra210-aconnect", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, tegra_aconnect_of_match);
 
 static struct platform_driver tegra_aconnect_driver = {
 	.probe = tegra_aconnect_probe,
-	.remove = tegra_aconnect_remove,
 	.driver = {
 		.name = "tegra-aconnect",
+		.suppress_bind_attrs = true,
 		.of_match_table = tegra_aconnect_of_match,
 		.pm = &tegra_aconnect_pm_ops,
 	},
 };
-module_platform_driver(tegra_aconnect_driver);
-
-MODULE_DESCRIPTION("NVIDIA Tegra ACONNECT Bus Driver");
-MODULE_AUTHOR("Jon Hunter <jonathanh@nvidia.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(tegra_aconnect_driver);
-- 
2.8.4
