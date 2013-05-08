From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 21:05:53 +0800
Subject: [PATCH 1/3] ARM: imx: compile fix for hotplug.c
In-Reply-To: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
References: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368018355-26014-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bca7a5a (ARM: cpu hotplug: remove majority of cache flushing
from platforms) removes include of <asm/cacheflush.h> and hence
discovers a few indirect inclusion and declaration problems as below.

  CC      arch/arm/mach-imx/hotplug.o
In file included from arch/arm/mach-imx/hotplug.c:16:0:
arch/arm/mach-imx/common.h:100:29: warning: ?struct pt_regs? declared inside parameter list [enabled by default]
arch/arm/mach-imx/common.h:100:29: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
arch/arm/mach-imx/common.h:101:29: warning: ?struct pt_regs? declared inside parameter list [enabled by default]
arch/arm/mach-imx/hotplug.c: In function ?imx_cpu_die?:
arch/arm/mach-imx/hotplug.c:53:2: error: implicit declaration of function ?cpu_do_idle? [-Werror=implicit-function-declaration]
arch/arm/mach-imx/hotplug.c: In function ?imx_cpu_kill?:
arch/arm/mach-imx/hotplug.c:58:26: error: ?jiffies? undeclared (first use in this function)
arch/arm/mach-imx/hotplug.c:58:26: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-imx/hotplug.c:58:2: error: implicit declaration of function ?msecs_to_jiffies? [-Werror=implicit-function-declaration]
arch/arm/mach-imx/hotplug.c:61:3: error: implicit declaration of function ?time_after? [-Werror=implicit-function-declaration]

Fix them by adding the needed inclusion and declaration.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/common.h  |    1 +
 arch/arm/mach-imx/hotplug.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4cba7db..c08ae3f 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -12,6 +12,7 @@
 #define __ASM_ARCH_MXC_COMMON_H__
 
 struct platform_device;
+struct pt_regs;
 struct clk;
 enum mxc_cpu_pwr_mode;
 
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 5e91112..3daf1ed 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -11,7 +11,9 @@
  */
 
 #include <linux/errno.h>
+#include <linux/jiffies.h>
 #include <asm/cp15.h>
+#include <asm/proc-fns.h>
 
 #include "common.h"
 
-- 
1.7.9.5
