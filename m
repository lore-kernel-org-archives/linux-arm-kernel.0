From: bryan.wu@canonical.com (Bryan Wu)
Date: Sun, 26 Jun 2011 06:10:04 +0800
Subject: [PATCH 4/4] mach-versatile: retire custom LED code
In-Reply-To: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
References: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1309039804-659-5-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The CPU activity LED is now handled by the trigger in the leds
subsystem, retire this old CONFIG_LEDS-based code.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-versatile/core.c |   42 ----------------------------------------
 1 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 0c99cf0..b9ff8ff 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -36,7 +36,6 @@
 
 #include <asm/system.h>
 #include <asm/irq.h>
-#include <asm/leds.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/hardware/vic.h>
@@ -646,43 +645,6 @@ static struct amba_device *amba_devs[] __initdata = {
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
 /* Early initializations */
 void __init versatile_init_early(void)
 {
@@ -707,10 +669,6 @@ void __init versatile_init(void)
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
1.7.4.1
