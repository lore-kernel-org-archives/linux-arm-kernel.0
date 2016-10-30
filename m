From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 29 Oct 2016 21:24:39 -0400
Subject: [PATCH 5/6] mfd: ab8500: make sysctrl explicitly non-modular
In-Reply-To: <20161030012440.10495-1-paul.gortmaker@windriver.com>
References: <20161030012440.10495-1-paul.gortmaker@windriver.com>
Message-ID: <20161030012440.10495-6-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config AB8500_CORE
drivers/mfd/Kconfig:    bool "ST-Ericsson AB8500 Mixed Signal Power Management chip"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We replace module.h with init.h and export.h -- the latter since the file
does make use of EXPORT_SYMBOL.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/ab8500-sysctrl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 207cc497958a..80c0efa66ac1 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -1,11 +1,14 @@
 /*
+ * AB8500 system control driver
+ *
  * Copyright (C) ST-Ericsson SA 2010
  * Author: Mattias Nilsson <mattias.i.nilsson@stericsson.com> for ST Ericsson.
  * License terms: GNU General Public License (GPL) version 2
  */
 
 #include <linux/err.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -158,7 +161,3 @@ static int __init ab8500_sysctrl_init(void)
 	return platform_driver_register(&ab8500_sysctrl_driver);
 }
 arch_initcall(ab8500_sysctrl_init);
-
-MODULE_AUTHOR("Mattias Nilsson <mattias.i.nilsson@stericsson.com");
-MODULE_DESCRIPTION("AB8500 system control driver");
-MODULE_LICENSE("GPL v2");
-- 
2.10.1
