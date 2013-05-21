From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:30 +0200
Subject: [PATCH 5/9] arm: mvebu: avoid hardcoded virtual address in coherency
 code
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the coherency_get_cpu_count() function no longer requires a
very early mapping of the coherency unit registers, we can avoid the
hardcoded virtual address in coherency.c. However, the coherency
features are still used quite early, so we need to do the of_iomap()
early enough, at the ->init_timer() level, so we have the call of
coherency_init() at this point.

Unfortunately, at ->init_timer() time, it is not possible to register
a bus notifier, so we add a separate coherency_late_init() function
that gets called as as postcore_initcall(), when bus notifiers are
available.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |    2 +-
 arch/arm/mach-mvebu/coherency.c     |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index bfe337d..3af5628 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -47,6 +47,7 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 {
 	mvebu_clocks_init();
 	armada_370_xp_timer_init();
+	coherency_init();
 }
 
 static void __init armada_370_xp_init_early(void)
@@ -83,7 +84,6 @@ static void __init armada_370_xp_init_early(void)
 static void __init armada_370_xp_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	coherency_init();
 }
 
 static const char * const armada_370_xp_dt_compat[] = {
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 46d66c0..d74794a 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -27,14 +27,7 @@
 #include <asm/smp_plat.h>
 #include "armada-370-xp.h"
 
-/*
- * Some functions in this file are called very early during SMP
- * initialization. At that time the device tree framework is not yet
- * ready, and it is not possible to get the register address to
- * ioremap it. That's why the pointer below is given with an initial
- * value matching its virtual mapping
- */
-static void __iomem *coherency_base = ARMADA_370_XP_REGS_VIRT_BASE + 0x20200;
+static void __iomem *coherency_base;
 static void __iomem *coherency_cpu_base;
 
 /* Coherency fabric registers */
@@ -135,9 +128,16 @@ int __init coherency_init(void)
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
 		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
-		bus_register_notifier(&platform_bus_type,
-					&mvebu_hwcc_platform_nb);
 	}
 
 	return 0;
 }
+
+static int __init coherency_late_init(void)
+{
+	bus_register_notifier(&platform_bus_type,
+			      &mvebu_hwcc_platform_nb);
+	return 0;
+}
+
+postcore_initcall(coherency_late_init);
-- 
1.7.9.5
