From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:54:26 +0800
Subject: [PATCH v2.0 2/2] pm: at91: flush data cache and clean,
 invalidate and disable the L2 cache
In-Reply-To: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425873266-8192-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flush data cache, and clean, invalidate and disable the L2 cache before going to suspend.
Restore the L2 cache configuration and re-enable the L2 cache after waking up.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 9fb868d..ac947cd 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -30,6 +30,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/fncpy.h>
+#include <asm/cacheflush.h>
 
 #include <mach/cpu.h>
 #include <mach/hardware.h>
@@ -133,8 +134,13 @@ static void at91_pm_suspend(suspend_state_t state)
 	pm_data |= (state == PM_SUSPEND_MEM) ?
 				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
 
+	flush_cache_all();
+	outer_disable();
+
 	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
 				at91_ramc_base[1], pm_data);
+
+	outer_resume();
 }
 
 static int at91_pm_enter(suspend_state_t state)
-- 
1.7.9.5
