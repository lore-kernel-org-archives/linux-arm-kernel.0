From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:23 +0100
Subject: [PATCH 13/13] ARM: at91: pm: Allow PM even if SRAM allocation failed
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-14-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No that C functions are used, we can always enabled PM, putting the SDRAM
in self refresh but not disabling the main clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 12 +++++++-----
 arch/arm/mach-at91/pm.h |  3 +++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1992ad8b1c3d..a4d9f3f76ca4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -128,7 +128,7 @@ static void at91_pm_suspend(suspend_state_t state)
 	flush_cache_all();
 	outer_disable();
 
-	if (state == PM_SUSPEND_MEM)
+	if ((state == PM_SUSPEND_MEM) && (pm_data.states & AT91_PM_SLOW_CLOCK))
 		at91_suspend_sram_fn(&pm_data);
 	else
 		pm_data.standby();
@@ -466,10 +466,12 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 
 	at91_pm_sram_init();
 
-	if (at91_suspend_sram_fn)
-		suspend_set_ops(&at91_pm_ops);
-	else
-		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
+	if (at91_suspend_sram_fn) {
+		pm_data.states |= AT91_PM_SLOW_CLOCK;
+		pr_info("AT91: PM: Slow clock mode enabled\n");
+	}
+
+	suspend_set_ops(&at91_pm_ops);
 }
 
 void __init at91rm9200_pm_init(void)
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 2317e39248b7..2f5ec4da3416 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -21,6 +21,8 @@
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
 
+#define AT91_PM_SLOW_CLOCK	BIT(0)
+
 #ifndef __ASSEMBLY__
 struct at91_pm_data {
 	void __iomem *pmc;
@@ -28,6 +30,7 @@ struct at91_pm_data {
 	unsigned long uhp_udp_mask;
 	unsigned int memctrl;
 	void (*standby)(void);
+	unsigned int states;
 };
 #endif
 
-- 
2.11.0
