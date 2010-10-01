From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:01:20 -0700
Subject: [PATCH 2/2] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
In-Reply-To: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
References: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285966880-26448-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lo?c Minier <loic.minier@linaro.org>

Since 6cdee91257bee23a46dc869ca62469b67cba2c7e the references to
enable_off_mode and sleep_while_idle can't be resolved when CONFIG_PM_DEBUG
isn't set:
arch/arm/mach-omap2/built-in.o: In function `omap_uart_restore_context':
arch/arm/mach-omap2/serial.c:253: undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
arch/arm/mach-omap2/pm34xx.c:479: undefined reference to `sleep_while_idle'

Simply #define these in pm.h just like omap2_pm_debug.

Signed-off-by: Lo?c Minier <loic.minier@linaro.org>
[khilman: moved down into existing #ifdef section]
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 77770a1..0d75bfd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,9 +13,6 @@
 
 #include <plat/powerdomain.h>
 
-extern u32 enable_off_mode;
-extern u32 sleep_while_idle;
-
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
@@ -50,10 +47,14 @@ extern struct omap_dm_timer *gptimer_wakeup;
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds);
 extern int omap2_pm_debug;
+extern u32 enable_off_mode;
+extern u32 sleep_while_idle;
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
 #define omap2_pm_debug				0
+#define enable_off_mode 0
+#define sleep_while_idle 0
 #endif
 
 #if defined(CONFIG_CPU_IDLE)
-- 
1.7.2.1
