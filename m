From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 20:27:32 +0900
Subject: [PATCH 04/04] ARM: shmobile: Make r8a73a4 Arch timer optional
In-Reply-To: <20130628112655.23809.39115.sendpatchset@w520>
References: <20130628112655.23809.39115.sendpatchset@w520>
Message-ID: <20130628112732.23809.81527.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a73a4 code to allow using other
timers than Arch timer for clock event

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                |    1 -
 arch/arm/mach-shmobile/board-ape6evm.c        |    1 +
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    8 ++++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

--- 0010/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-28 19:53:49.000000000 +0900
@@ -23,7 +23,6 @@ config ARCH_R8A73A4
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 	select ARCH_HAS_CPUFREQ
--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-06-28 19:55:52.000000000 +0900
@@ -102,6 +102,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.init_early	= r8a73a4_init_delay,
 	.init_irq	= irqchip_init,
 	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-06-28 19:55:15.000000000 +0900
@@ -4,5 +4,6 @@
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
+void r8a73a4_init_delay(void);
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0011/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-06-28 19:57:29.000000000 +0900
@@ -203,6 +203,13 @@ void __init r8a73a4_add_standard_devices
 	r8a7790_register_cmt(10);
 }
 
+void __init r8a73a4_init_delay(void)
+{
+#ifndef CONFIG_ARM_ARCH_TIMER
+	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
+#endif
+}
+
 #ifdef CONFIG_USE_OF
 void __init r8a73a4_add_standard_devices_dt(void)
 {
@@ -216,6 +223,7 @@ static const char *r8a73a4_boards_compat
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
+	.init_early	= r8a73a4_init_delay,
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
