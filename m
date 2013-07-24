From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:34:05 +0900
Subject: [PATCH 12/16] ARM: shmobile: Make r8a73a4 Arch timer optional
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <b9a30ef1d354c0bc0cc6d973bbe7ede9f00716ee.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a73a4 code to allow using other
timers than Arch timer for clock event

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                | 1 -
 arch/arm/mach-shmobile/board-ape6evm.c        | 1 +
 arch/arm/mach-shmobile/include/mach/r8a73a4.h | 1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        | 8 ++++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 406077c..dd80f21 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -23,7 +23,6 @@ config ARCH_R8A73A4
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select HAVE_ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 	select ARCH_HAS_CPUFREQ
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 1fbc39a..af6dd39 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -101,6 +101,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.init_early	= r8a73a4_init_delay,
 	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index f043103..144a85e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -4,5 +4,6 @@
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
+void r8a73a4_init_delay(void);
 
 #endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index b8dddf4..d533bd2 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -202,6 +202,13 @@ void __init r8a73a4_add_standard_devices(void)
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
@@ -215,6 +222,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
+	.init_early	= r8a73a4_init_delay,
 	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
-- 
1.8.2.1
