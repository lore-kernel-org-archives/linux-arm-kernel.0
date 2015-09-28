From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 15:49:17 +0100
Subject: [PATCH v3 6/7] clocksource/arm_arch_timer: Convert to ACPI probing
In-Reply-To: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443451758-22717-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is now absolutely trivial to convert the arch timer driver to
use ACPI probing, just like its DT counterpart.

Let's enjoy another crapectomy.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/time.c             |  6 ------
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/arm_arch_timer.c | 10 +---------
 include/linux/clocksource.h          |  6 ------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 149151f..819a105 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -71,12 +71,6 @@ void __init time_init(void)
 
 	tick_setup_hrtimer_broadcast();
 
-	/*
-	 * Since ACPI or FDT will only one be available in the system,
-	 * we can use acpi_generic_timer_init() here safely
-	 */
-	acpi_generic_timer_init();
-
 	arch_timer_rate = arch_timer_get_rate();
 	if (!arch_timer_rate)
 		panic("Unable to initialise architected timer.\n");
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index fefedf1..1a9c5dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -131,6 +131,7 @@ config CLKSRC_STM32
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
+	select CLKSRC_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
 	bool "Support for ARM architected timer event stream generation"
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d6e3e49..c64d543 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -864,13 +864,5 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	arch_timer_init();
 	return 0;
 }
-
-/* Initialize all the generic timers presented in GTDT */
-void __init acpi_generic_timer_init(void)
-{
-	if (acpi_disabled)
-		return;
-
-	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
-}
+CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 6eab6ab..116645f 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -252,12 +252,6 @@ extern void clocksource_of_init(void);
 static inline void clocksource_of_init(void) {}
 #endif
 
-#ifdef CONFIG_ACPI
-void acpi_generic_timer_init(void);
-#else
-static inline void acpi_generic_timer_init(void) { }
-#endif
-
 #define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(clksrc, name, table_id, 0, NULL, 0, fn)
 
-- 
2.1.4
