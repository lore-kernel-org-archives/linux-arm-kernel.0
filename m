From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 27 Jan 2015 13:57:27 +0800
Subject: [PATCH v3 07/13] pm: at91: remove the config item
 CONFIG_AT91_SLOW_CLOCK
In-Reply-To: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422338247-5945-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The slow clock always exists, for the suspend to memory mode,
the master clock always switch to the slow clock.

To simplify the PM config, remove this config item, remove
the definition code as well.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig  |   13 -------------
 arch/arm/mach-at91/Makefile |    2 +-
 arch/arm/mach-at91/pm.c     |    7 -------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index cbaf0c8..0af6744 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -160,19 +160,6 @@ endif # SOC_SAM_V4_V5
 
 comment "AT91 Feature Selections"
 
-config AT91_SLOW_CLOCK
-	bool "Suspend-to-RAM disables main oscillator"
-	depends on SUSPEND
-	help
-	  Select this if you want Suspend-to-RAM to save the most power
-	  possible (without powering off the CPU) by disabling the PLLs
-	  and main oscillator so that only the 32 KiHz clock is available.
-
-	  When only that slow-clock is available, some peripherals lose
-	  functionality.  Many can't issue wakeup events unless faster
-	  clocks are available.  Some lose their operating state and
-	  need to be completely re-initialized.
-
 config AT91_TIMER_HZ
        int "Kernel HZ (jiffies per second)"
        range 32 1024
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 8ef7d9a..13dd3e6 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_SOC_SAMA5)		+= board-dt-sama5.o
 
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
+obj-$(CONFIG_PM)		+= pm_slowclock.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 6b08098..0377c0d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -133,11 +133,9 @@ EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 static void (*slow_clock)(void __iomem *pmc, void __iomem *ramc0,
 			  void __iomem *ramc1, int memctrl);
 
-#ifdef CONFIG_AT91_SLOW_CLOCK
 extern void at91_slow_clock(void __iomem *pmc, void __iomem *ramc0,
 			    void __iomem *ramc1, int memctrl);
 extern u32 at91_slow_clock_sz;
-#endif
 
 static int at91_pm_enter(suspend_state_t state)
 {
@@ -232,7 +230,6 @@ void at91_pm_set_standby(void (*at91_standby)(void))
 	}
 }
 
-#ifdef CONFIG_AT91_SLOW_CLOCK
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
@@ -274,14 +271,10 @@ static void __init at91_pm_sram_init(void)
 put_node:
 	of_node_put(node);
 }
-#endif
-
 
 static void __init at91_pm_init(void)
 {
-#ifdef CONFIG_AT91_SLOW_CLOCK
 	at91_pm_sram_init();
-#endif
 
 	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
 
-- 
1.7.9.5
