From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 29 Feb 2016 15:48:44 -0500
Subject: [PATCH 8/8] drivers/pinctrl: clean up samsung modular vs. non-modular
 distinctions
In-Reply-To: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1456778924-20730-9-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixups here tend to be more all over the map vs. some of the other
repeated/systematic ones we've seen elsewhere.

We remove module.h from code that isn't doing anything modular at
all;  if they have __init sections, then replace it with init.h

A couple drivers have module_exit() code that is essentially orphaned,
and so we remove that.

There are no module_init replacements, so we have no concerns wrt.
initcall ordering changes as per some of the other cleanups.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-gpio at vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c     |  1 -
 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 15 +++------------
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c    |  2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c    |  2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c    | 12 +-----------
 5 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 051b5bf701a8..428094e797bd 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -18,7 +18,6 @@
  * external gpio and wakeup interrupt support.
  */
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index 00ab63abf1d9..50cb7d3bb098 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -1,6 +1,8 @@
 /*
  * pin-controller/pin-mux/pin-config/gpio-driver for Samsung's EXYNOS5440 SoC.
  *
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -10,7 +12,7 @@
  * (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -990,7 +992,6 @@ static const struct of_device_id exynos5440_pinctrl_dt_match[] = {
 	{ .compatible = "samsung,exynos5440-pinctrl" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, exynos5440_pinctrl_dt_match);
 
 static struct platform_driver exynos5440_pinctrl_driver = {
 	.probe		= exynos5440_pinctrl_probe,
@@ -1005,13 +1006,3 @@ static int __init exynos5440_pinctrl_drv_register(void)
 	return platform_driver_register(&exynos5440_pinctrl_driver);
 }
 postcore_initcall(exynos5440_pinctrl_drv_register);
-
-static void __exit exynos5440_pinctrl_drv_unregister(void)
-{
-	platform_driver_unregister(&exynos5440_pinctrl_driver);
-}
-module_exit(exynos5440_pinctrl_drv_unregister);
-
-MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com>");
-MODULE_DESCRIPTION("Samsung EXYNOS5440 SoC pinctrl driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 3d92f827da7a..edf27264b603 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -13,7 +13,7 @@
  * external gpio and wakeup interrupt support.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index 43407ab248f5..5eda18297a4e 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -15,7 +15,7 @@
  * external gpio and wakeup interrupt support.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 5cc97f85db02..b698bfe1814f 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -20,7 +20,7 @@
  * and wakeup interrupts can be hooked to.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -1289,13 +1289,3 @@ static int __init samsung_pinctrl_drv_register(void)
 	return platform_driver_register(&samsung_pinctrl_driver);
 }
 postcore_initcall(samsung_pinctrl_drv_register);
-
-static void __exit samsung_pinctrl_drv_unregister(void)
-{
-	platform_driver_unregister(&samsung_pinctrl_driver);
-}
-module_exit(samsung_pinctrl_drv_unregister);
-
-MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com>");
-MODULE_DESCRIPTION("Samsung pinctrl driver");
-MODULE_LICENSE("GPL v2");
-- 
2.6.1
