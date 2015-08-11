From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 11 Aug 2015 19:39:04 -0300
Subject: [PATCH 1/3] [media] c8sectpfe: fix pinctrl dependencies
Message-ID: <53cc7c9043f0a68a66e53623b114c86051a7250c.1439332733.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compiling on some archs fail with:

drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:540:8: error: implicit declaration of function ?pinctrl_select_state? [-Werror=implicit-function-declaration]
  ret = pinctrl_select_state(fei->pinctrl, tsin->pstate);

That's due the need of including pinctrl.h header and because
CONFIG_PINCTRL needs to be true.

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/sti/c8sectpfe/Kconfig
index a7227d2ab6cc..1b1110d7374f 100644
--- a/drivers/media/platform/sti/c8sectpfe/Kconfig
+++ b/drivers/media/platform/sti/c8sectpfe/Kconfig
@@ -1,6 +1,7 @@
 config DVB_C8SECTPFE
 	tristate "STMicroelectronics C8SECTPFE DVB support"
-	depends on DVB_CORE && I2C && (ARCH_STI || ARCH_MULTIPLATFORM || COMPILE_TEST)
+	depends on PINCTRL && DVB_CORE && I2C
+	depends on ARCH_STI || ARCH_MULTIPLATFORM || COMPILE_TEST
 	select LIBELF_32
 	select FW_LOADER
 	select FW_LOADER_USER_HELPER_FALLBACK
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 955d8daf055f..1586a1e6836d 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -33,6 +33,7 @@
 #include <linux/time.h>
 #include <linux/version.h>
 #include <linux/wait.h>
+#include <linux/pinctrl/pinctrl.h>
 
 #include "c8sectpfe-core.h"
 #include "c8sectpfe-common.h"
-- 
2.4.3
