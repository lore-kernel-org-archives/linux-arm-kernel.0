From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:49 +0530
Subject: [PATCH 11/14] ux500: move sys_timer to cpu.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-12-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the common system timer setup code to cpu.c.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c       |    2 +-
 arch/arm/mach-ux500/cpu-u8500.c          |   21 ---------------------
 arch/arm/mach-ux500/cpu.c                |   21 +++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/setup.h |    2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index cd0bd36..072196c 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -145,6 +145,6 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
-	.timer		= &u8500_timer,
+	.timer		= &ux500_timer,
 	.init_machine	= u8500_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 51e9bf2..d04299f 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -17,9 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <asm/localtimer.h>
 #include <asm/mach/map.h>
-#include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
@@ -78,22 +76,3 @@ void __init u8500_init_devices(void)
 
 	return ;
 }
-
-static void __init u8500_timer_init(void)
-{
-#ifdef CONFIG_LOCAL_TIMERS
-	/* Setup the local timer base */
-	twd_base = __io_address(U8500_TWD_BASE);
-#endif
-	/* Setup the MTU base */
-	if (cpu_is_u8500ed())
-		mtu_base = __io_address(U8500_MTU0_BASE_ED);
-	else
-		mtu_base = __io_address(U8500_MTU0_BASE);
-
-	nmdk_timer_init();
-}
-
-struct sys_timer u8500_timer = {
-	.init	= u8500_timer_init,
-};
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 05615c0..d81ad02 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -13,7 +13,9 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
+#include <asm/localtimer.h>
 
+#include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
@@ -76,3 +78,22 @@ static int ux500_l2x0_init(void)
 }
 early_initcall(ux500_l2x0_init);
 #endif
+
+static void __init ux500_timer_init(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	/* Setup the local timer base */
+	twd_base = __io_address(UX500_TWD_BASE);
+#endif
+	/* Setup the MTU base */
+	if (cpu_is_u8500ed())
+		mtu_base = __io_address(U8500_MTU0_BASE_ED);
+	else
+		mtu_base = __io_address(UX500_MTU0_BASE);
+
+	nmdk_timer_init();
+}
+
+struct sys_timer ux500_timer = {
+	.init	= ux500_timer_init,
+};
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 6187eff..c730d07 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -27,7 +27,7 @@ extern void nmdk_timer_init(void);
 extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
 struct sys_timer;
-extern struct sys_timer u8500_timer;
+extern struct sys_timer ux500_timer;
 
 #define __IO_DEV_DESC(x, sz)	{		\
 	.virtual	= IO_ADDRESS(x),	\
-- 
1.7.0
