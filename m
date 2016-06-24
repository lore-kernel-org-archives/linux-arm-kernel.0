From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 11:41:26 +0200
Subject: [PATCH 1/7] ARM: ux500: move l2x0 init to .init_irq
In-Reply-To: <20160624094132.1852086-1-arnd@arndb.de>
References: <20160624094132.1852086-1-arnd@arndb.de>
Message-ID: <20160624094132.1852086-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic IRQ init function also enables the l2 cache
implicitly when the machine descriptor sets an .l2c_aux_mask.

Let's use that on ux500 and remove the ux500_l2x0_init()
along with the cpu_is_u8500_family checks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/cache-l2x0.c | 8 +-------
 arch/arm/mach-ux500/cpu-db8500.c | 3 ++-
 arch/arm/mach-ux500/cpu.c        | 1 +
 arch/arm/mach-ux500/setup.h      | 3 +++
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 780bd13cd7e3..d7abc1187769 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -51,17 +51,11 @@ static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
 	 */
 }
 
-static int __init ux500_l2x0_init(void)
+void __init ux500_l2x0_init(void)
 {
-	/* Multiplatform guard */
-	if (!((cpu_is_u8500_family() || cpu_is_ux540_family())))
-		return -ENODEV;
-
 	/* Unlock before init */
 	ux500_l2x0_unlock();
 	outer_cache.write_sec = ux500_l2c310_write_sec;
-	l2x0_of_init(0, ~0);
 
 	return 0;
 }
-early_initcall(ux500_l2x0_init);
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index bbd1b4b8d441..3874e9c236e9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -141,10 +141,11 @@ static const char * stericsson_dt_platform_compat[] = {
 };
 
 DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
+	.l2c_aux_val    = 0,
+	.l2c_aux_mask	= ~0,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.init_machine	= u8500_init_machine,
-	.init_late	= NULL,
 	.dt_compat      = stericsson_dt_platform_compat,
 	.restart        = ux500_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 82156cbc22ce..f8c2d6f2fb7e 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -65,6 +65,7 @@ void __init ux500_init_irq(void)
 	}
 	prcmu_early_init(r.start, r.end-r.start);
 	ux500_pm_init(r.start, r.end-r.start);
+	ux500_l2x0_init();
 
 	/*
 	 * Init clocks here so that they are available for system timer
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index e606847c8b58..8b44b646b191 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -14,6 +14,9 @@
 #include <asm/mach/arch.h>
 #include <linux/init.h>
 
+
+void ux500_l2x0_init(void);
+
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
 void __init ux500_setup_id(void);
-- 
2.9.0
