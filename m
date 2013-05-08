From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  8 May 2013 09:33:11 +0200
Subject: [PATCH] ARM: imx: fix build breakage in hotplug.c
Message-ID: <1367998391-12801-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit bca7a5a (ARM: cpu hotplug: remove majority of cache
flushing from platforms) hotplug.c fails to compile (e.g. with
imx_v6_v7_defconfig) with:

	arch/arm/mach-imx/common.h:100:29: warning: 'struct pt_regs' declared inside parameter list [enabled by default]
	arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_die':
	arch/arm/mach-imx/hotplug.c:53:2: error: implicit declaration of function 'cpu_do_idle' [-Werror=implicit-function-declaration]
	arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_kill':
	arch/arm/mach-imx/hotplug.c:58:26: error: 'jiffies' undeclared (first use in this function)
	arch/arm/mach-imx/hotplug.c:58:26: note: each undeclared identifier is reported only once for each function it appears in
	arch/arm/mach-imx/hotplug.c:58:2: error: implicit declaration of function 'msecs_to_jiffies' [-Werror=implicit-function-declaration]
	arch/arm/mach-imx/hotplug.c:61:3: error: implicit declaration of function 'time_after' [-Werror=implicit-function-declaration]
	cc1: some warnings being treated as errors

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Russell,

This patch applies on top of Linus' or your master branch.

Best regards
Uwe

 arch/arm/mach-imx/common.h  | 2 ++
 arch/arm/mach-imx/hotplug.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5bf4a97..5241d99b 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -96,6 +96,8 @@ enum mx3_cpu_pwr_mode {
 extern void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
 
+struct pt_regs;
+
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
 
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
1.8.2.rc2
