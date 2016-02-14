From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 14 Feb 2016 12:19:11 -0500
Subject: [PATCH] drivers/hwtracing: make coresight-* explicitly non-modular
Message-ID: <1455470351-15219-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the Kconfig currently controlling compilation of any of
the files here are tristate, meaning that none of it currently
is being built as a module by anyone.

We need not be concerned about .remove functions and blocking the
unbind sysfs operations, since that was already done in a recent
commit.

Lets remove any remaining modular references, so that when reading the
drivers there is no doubt they are builtin-only.

All drivers get mostly the same changes, so they are handled in batch.
Changes are (1) convert to builtin_amba_driver, (2) delete module.h
include where unused, and (3) relocate the description into the
comments so we don't need MODULE_DESCRIPTION and associated tags.

The etm3x and etm4x use module_param_named, and have been adjusted
to just include moduleparam.h for that purpose.

In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
better support builtin boilerplate avoidance") we introduced the
builtin_driver macro.

Here we use that support and extend it to amba driver registration,
so where a driver is clearly non-modular and builtin-only, we can
update with the simple mapping of

     module_amba_driver(...)  ---> builtin_amba_driver(...)

Since module_amba_driver() uses the same init level priority as
builtin_amba_driver() the init ordering remains unchanged with
this commit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[This is what I sent back in October[1], but with the .remove and
 .suppress bits stripped out, since that is now in Mathieu's queue.
 And to make this a standalone commit that Mathieu can also add to
 his queue, I've squished the amba/bus.h change[2] into this change.]

[1]  http://www.spinics.net/lists/kernel/msg2096702.html
[2]  http://lkml.iu.edu/hypermail/linux/kernel/1510.1/02464.html

 drivers/hwtracing/coresight/coresight-etb10.c           |  9 +++------
 drivers/hwtracing/coresight/coresight-etm3x.c           | 14 ++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.c           |  4 +---
 drivers/hwtracing/coresight/coresight-funnel.c          |  9 +++------
 drivers/hwtracing/coresight/coresight-replicator-qcom.c |  4 +---
 drivers/hwtracing/coresight/coresight-replicator.c      |  7 ++-----
 drivers/hwtracing/coresight/coresight-tmc.c             |  9 +++------
 drivers/hwtracing/coresight/coresight-tpiu.c            |  9 +++------
 drivers/hwtracing/coresight/coresight.c                 |  3 ---
 drivers/hwtracing/coresight/of_coresight.c              |  1 -
 include/linux/amba/bus.h                                |  9 +++++++++
 11 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 92969dae739d..21f6afd24a66 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Embedded Trace Buffer driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -534,8 +535,4 @@ static struct amba_driver etb_driver = {
 	.probe		= etb_probe,
 	.id_table	= etb_ids,
 };
-
-module_amba_driver(etb_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Embedded Trace Buffer driver");
+builtin_amba_driver(etb_driver);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index aae80e14508d..8750b432ad36 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Program Flow Trace driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -35,6 +37,10 @@
 
 #include "coresight-etm.h"
 
+/*
+ * not really modular but using module_param is the easiest way to
+ * remain consistent with existing use cases for now.
+ */
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 
@@ -1950,8 +1956,4 @@ static struct amba_driver etm_driver = {
 	.probe		= etm_probe,
 	.id_table	= etm_ids,
 };
-
-module_amba_driver(etm_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Program Flow Trace driver");
+builtin_amba_driver(etm_driver);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d6a92c6d3a66..040327ac6e1f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -2714,5 +2713,4 @@ static struct amba_driver etm4x_driver = {
 	.probe		= etm4_probe,
 	.id_table	= etm4_ids,
 };
-
-module_amba_driver(etm4x_driver);
+builtin_amba_driver(etm4x_driver);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 25e8ea140a09..2c1850c8dbe7 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Funnel driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -270,8 +271,4 @@ static struct amba_driver funnel_driver = {
 	.probe		= funnel_probe,
 	.id_table	= funnel_ids,
 };
-
-module_amba_driver(funnel_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Funnel driver");
+builtin_amba_driver(funnel_driver);
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 444815179460..6344dcf19639 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -15,7 +15,6 @@
 #include <linux/clk.h>
 #include <linux/coresight.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -202,5 +201,4 @@ static struct amba_driver replicator_driver = {
 	.probe		= replicator_probe,
 	.id_table	= replicator_ids,
 };
-
-module_amba_driver(replicator_driver);
+builtin_amba_driver(replicator_driver);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b77d700a3f0e..d31da8004d2e 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Replicator driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -168,8 +169,4 @@ static struct platform_driver replicator_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-
 builtin_platform_driver(replicator_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Replicator driver");
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index c4fa70ed14ce..021cbb5d9eb3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Trace Memory Controller driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -787,8 +788,4 @@ static struct amba_driver tmc_driver = {
 	.probe		= tmc_probe,
 	.id_table	= tmc_ids,
 };
-
-module_amba_driver(tmc_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Trace Memory Controller driver");
+builtin_amba_driver(tmc_driver);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index ca50e73d9df7..e24bfb04f168 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -1,5 +1,7 @@
 /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
+ * Description: CoreSight Trace Port Interface Unit driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -11,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -220,8 +221,4 @@ static struct amba_driver tpiu_driver = {
 	.probe		= tpiu_probe,
 	.id_table	= tpiu_ids,
 };
-
-module_amba_driver(tpiu_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("CoreSight Trace Port Interface Unit driver");
+builtin_amba_driver(tpiu_driver);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7e6e9ff27dd1..4b33f1938a58 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
@@ -766,5 +765,3 @@ void coresight_unregister(struct coresight_device *csdev)
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 3cc57c1e3b5d..b68da1888fd5 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -10,7 +10,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 9006c4e75cf7..3d8dcdd1aeae 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -163,4 +163,13 @@ struct amba_device name##_device = {				\
 #define module_amba_driver(__amba_drv) \
 	module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
 
+/*
+ * builtin_amba_driver() - Helper macro for drivers that don't do anything
+ * special in driver initcall.  This eliminates a lot of boilerplate.  Each
+ * driver may only use this macro once, and calling it replaces the instance
+ * device_initcall().
+ */
+#define builtin_amba_driver(__amba_drv) \
+	builtin_driver(__amba_drv, amba_driver_register)
+
 #endif
-- 
2.6.1
