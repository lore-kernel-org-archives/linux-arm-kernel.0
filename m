From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 16 Sep 2010 10:23:35 +0200
Subject: [PATCH] ARM: remove legacy LEDS support from RealView and Versatile
Message-ID: <1284625415-8363-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have merged proper support for the NEW_LEDS and LEDS_CLASS in
the RealView and Versatile family in plat-versatile, including the
heartbeat feature that was provided for these platforms so scrap
this old LEDS stuff from these platforms.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/Kconfig                         |    4 +-
 arch/arm/mach-realview/core.c            |   39 ---------------------------
 arch/arm/mach-realview/core.h            |    2 -
 arch/arm/mach-realview/realview_eb.c     |    4 ---
 arch/arm/mach-realview/realview_pb1176.c |    4 ---
 arch/arm/mach-realview/realview_pb11mp.c |    4 ---
 arch/arm/mach-realview/realview_pba8.c   |    4 ---
 arch/arm/mach-realview/realview_pbx.c    |    4 ---
 arch/arm/mach-versatile/core.c           |   42 ------------------------------
 9 files changed, 2 insertions(+), 105 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 948435b..14b367e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1375,9 +1375,9 @@ config LEDS
 		   ARCH_EBSA285 || ARCH_INTEGRATOR || \
 		   ARCH_LUBBOCK || MACH_MAINSTONE || ARCH_NETWINDER || \
 		   ARCH_OMAP || ARCH_P720T || ARCH_PXA_IDP || \
-		   ARCH_SA1100 || ARCH_SHARK || ARCH_VERSATILE || \
+		   ARCH_SA1100 || ARCH_SHARK || \
 		   ARCH_AT91 || ARCH_DAVINCI || \
-		   ARCH_KS8695 || MACH_RD88F5182 || ARCH_REALVIEW
+		   ARCH_KS8695 || MACH_RD88F5182
 	help
 	  If you say Y here, the LEDs on your machine will be used
 	  to provide useful information about your current system status.
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 07c0815..cdeaa6a 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -35,7 +35,6 @@
 #include <asm/system.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
@@ -619,44 +618,6 @@ struct clcd_board clcd_plat_data = {
 	.remove		= realview_clcd_remove,
 };
 
-#ifdef CONFIG_LEDS
-#define VA_LEDS_BASE (__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LED_OFFSET)
-
-void realview_leds_event(led_event_t ledevt)
-{
-	unsigned long flags;
-	u32 val;
-	u32 led = 1 << smp_processor_id();
-
-	local_irq_save(flags);
-	val = readl(VA_LEDS_BASE);
-
-	switch (ledevt) {
-	case led_idle_start:
-		val = val & ~led;
-		break;
-
-	case led_idle_end:
-		val = val | led;
-		break;
-
-	case led_timer:
-		val = val ^ REALVIEW_SYS_LED7;
-		break;
-
-	case led_halted:
-		val = 0;
-		break;
-
-	default:
-		break;
-	}
-
-	writel(val, VA_LEDS_BASE);
-	local_irq_restore(flags);
-}
-#endif	/* CONFIG_LEDS */
-
 /*
  * Where is the timer (VA)?
  */
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 781bca6..2f34492 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 
 #include <asm/setup.h>
-#include <asm/leds.h>
 
 #define AMBA_DEVICE(name,busid,base,plat)			\
 static struct amba_device name##_device = {			\
@@ -59,7 +58,6 @@ extern void __iomem *timer1_va_base;
 extern void __iomem *timer2_va_base;
 extern void __iomem *timer3_va_base;
 
-extern void realview_leds_event(led_event_t ledevt);
 extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
 extern int realview_eth_register(const char *name, struct resource *res);
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 991c1f8..ad0f06b 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/pgtable.h>
@@ -478,9 +477,6 @@ static void __init realview_eb_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
-#ifdef CONFIG_LEDS
-	leds_event = realview_leds_event;
-#endif
 	realview_reset = realview_eb_reset;
 }
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index d2be12e..a7ceea8 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/pgtable.h>
@@ -370,9 +369,6 @@ static void __init realview_pb1176_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
-#ifdef CONFIG_LEDS
-	leds_event = realview_leds_event;
-#endif
 	realview_reset = realview_pb1176_reset;
 }
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index d591bc0..689b76d 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/pgtable.h>
@@ -373,9 +372,6 @@ static void __init realview_pb11mp_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
-#ifdef CONFIG_LEDS
-	leds_event = realview_leds_event;
-#endif
 	realview_reset = realview_pb11mp_reset;
 }
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 6c37621..3cdab89 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -29,7 +29,6 @@
 #include <linux/io.h>
 
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/pgtable.h>
@@ -323,9 +322,6 @@ static void __init realview_pba8_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
-#ifdef CONFIG_LEDS
-	leds_event = realview_leds_event;
-#endif
 	realview_reset = realview_pba8_reset;
 }
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 9428eff..a85bee6 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -28,7 +28,6 @@
 #include <linux/io.h>
 
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/smp_twd.h>
@@ -409,9 +408,6 @@ static void __init realview_pbx_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
-#ifdef CONFIG_LEDS
-	leds_event = realview_leds_event;
-#endif
 	realview_reset = realview_pbx_reset;
 }
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..91ca481 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -35,7 +35,6 @@
 #include <asm/clkdev.h>
 #include <asm/system.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/hardware/vic.h>
@@ -825,43 +824,6 @@ static struct amba_device *amba_devs[] __initdata = {
 	&kmi1_device,
 };
 
-#ifdef CONFIG_LEDS
-#define VA_LEDS_BASE (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
-
-static void versatile_leds_event(led_event_t ledevt)
-{
-	unsigned long flags;
-	u32 val;
-
-	local_irq_save(flags);
-	val = readl(VA_LEDS_BASE);
-
-	switch (ledevt) {
-	case led_idle_start:
-		val = val & ~VERSATILE_SYS_LED0;
-		break;
-
-	case led_idle_end:
-		val = val | VERSATILE_SYS_LED0;
-		break;
-
-	case led_timer:
-		val = val ^ VERSATILE_SYS_LED1;
-		break;
-
-	case led_halted:
-		val = 0;
-		break;
-
-	default:
-		break;
-	}
-
-	writel(val, VA_LEDS_BASE);
-	local_irq_restore(flags);
-}
-#endif	/* CONFIG_LEDS */
-
 void __init versatile_init(void)
 {
 	int i;
@@ -879,10 +841,6 @@ void __init versatile_init(void)
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
 	}
-
-#ifdef CONFIG_LEDS
-	leds_event = versatile_leds_event;
-#endif
 }
 
 /*
-- 
1.7.2.2
