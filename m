From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 23 Feb 2010 15:43:00 +0530
Subject: [PATCH 2/4] ux500: move system timer to cpu file
In-Reply-To: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
References: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1266919983-32759-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is nothing board-specific about the system timer, so move it to
the CPU file.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c       |   18 ------------------
 arch/arm/mach-ux500/cpu-u8500.c          |   20 ++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/setup.h |    3 +++
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 803aec1..c2b4a35 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -17,11 +17,9 @@
 #include <linux/amba/pl022.h>
 #include <linux/spi/spi.h>
 
-#include <asm/localtimer.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/mtu.h>
 #include <plat/i2c.h>
 
 #include <mach/hardware.h>
@@ -201,22 +199,6 @@ static struct platform_device *platform_devs[] __initdata = {
 	&i2c_controller3,
 };
 
-static void __init u8500_timer_init(void)
-{
-#ifdef CONFIG_LOCAL_TIMERS
-	/* Setup the local timer base */
-	twd_base = __io_address(U8500_TWD_BASE);
-#endif
-	/* Setup the MTU base */
-	mtu_base = __io_address(U8500_MTU0_BASE);
-
-	nmdk_timer_init();
-}
-
-static struct sys_timer u8500_timer = {
-	.init	= u8500_timer_init,
-};
-
 static void __init u8500_init_machine(void)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 397bc1f..588b059 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -14,10 +14,14 @@
 #include <linux/amba/bus.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
+#include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
+#include <plat/mtu.h>
 #include <mach/hardware.h>
+#include <mach/setup.h>
 
 /* add any platform devices here - TODO */
 static struct platform_device *platform_devs[] __initdata = {
@@ -63,3 +67,19 @@ void __init u8500_init_devices(void)
 
 	return ;
 }
+
+static void __init u8500_timer_init(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	/* Setup the local timer base */
+	twd_base = __io_address(U8500_TWD_BASE);
+#endif
+	/* Setup the MTU base */
+	mtu_base = __io_address(U8500_MTU0_BASE);
+
+	nmdk_timer_init();
+}
+
+struct sys_timer u8500_timer = {
+	.init	= u8500_timer_init,
+};
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index cf0ce16..65112bf 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -20,4 +20,7 @@ extern void u8500_init_irq(void);
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
+struct sys_timer;
+extern struct sys_timer u8500_timer;
+
 #endif /*  __ASM_ARCH_SETUP_H */
-- 
1.7.0
