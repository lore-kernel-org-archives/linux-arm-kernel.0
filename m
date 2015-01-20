From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 20 Jan 2015 16:16:59 +0800
Subject: [PATCH 06/12] pm: at91: remove the config item CONFIG_AT91_SLOW_CLOCK
In-Reply-To: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1421741825-18226-7-git-send-email-wenyou.yang@atmel.com>
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
 arch/arm/mach-at91/pm.c     |    7 +------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7d5e201..2aed68f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -127,19 +127,6 @@ menu "Atmel AT91 common options"
 
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
index fe30e7e..9c755d9 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SOC_SAMA5)		+= board-dt-sama5.o
 
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
+obj-$(CONFIG_PM)		+= pm_slowclock.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 609a4f8..691e6db 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -141,11 +141,9 @@ EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 static void (*slow_clock)(void __iomem *pmc, void __iomem *ramc0,
 			  void __iomem *ramc1, int memctrl);
 
-#ifdef CONFIG_AT91_SLOW_CLOCK
 extern void at91_slow_clock(void __iomem *pmc, void __iomem *ramc0,
 			    void __iomem *ramc1, int memctrl);
 extern u32 at91_slow_clock_sz;
-#endif
 
 static int at91_pm_enter(suspend_state_t state)
 {
@@ -240,7 +238,6 @@ void at91_pm_set_standby(void (*at91_standby)(void))
 	}
 }
 
-#ifdef CONFIG_AT91_SLOW_CLOCK
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
@@ -282,7 +279,6 @@ static void __init at91_pm_sram_init(void)
 put_node:
 	of_node_put(node);
 }
-#endif
 
 static struct of_device_id ramc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
@@ -324,9 +320,8 @@ static void at91_dt_ramc(void)
 static void __init at91_pm_init(void)
 {
 	at91_dt_ramc();
-#ifdef CONFIG_AT91_SLOW_CLOCK
+
 	at91_pm_sram_init();
-#endif
 
 	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
 
-- 
1.7.9.5
