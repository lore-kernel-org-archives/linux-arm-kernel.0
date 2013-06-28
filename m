From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 20:27:13 +0900
Subject: [PATCH 02/04] ARM: shmobile: Make r8a7790 Arch timer optional
In-Reply-To: <20130628112655.23809.39115.sendpatchset@w520>
References: <20130628112655.23809.39115.sendpatchset@w520>
Message-ID: <20130628112713.23809.67187.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7790 code to allow using other
timers than Arch timer for clock events.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                |    1 -
 arch/arm/mach-shmobile/board-lager.c          |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |    8 ++++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-28 15:30:59.000000000 +0900
@@ -61,7 +61,6 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-06-28 15:31:47.000000000 +0900
@@ -103,6 +103,7 @@ static const char *lager_boards_compat_d
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
+	.init_early	= r8a7790_init_delay,
 	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-06-28 15:31:21.000000000 +0900
@@ -4,6 +4,7 @@
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
+void r8a7790_init_delay(void);
 void r8a7790_timer_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
--- 0003/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-06-28 15:34:37.000000000 +0900
@@ -209,6 +209,13 @@ void __init r8a7790_timer_init(void)
 	shmobile_timer_init();
 }
 
+void __init r8a7790_init_delay(void)
+{
+#ifndef CONFIG_ARM_ARCH_TIMER
+	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
+#endif
+}
+
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
@@ -221,6 +228,7 @@ static const char *r8a7790_boards_compat
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.init_early	= r8a7790_init_delay,
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
