From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:34:03 +0900
Subject: [PATCH 10/16] ARM: shmobile: Make r8a7790 Arch timer optional
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <8333d8c995169e489a81241bd632a4b9370ed7c3.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7790 code to allow using other
timers than Arch timer for clock events.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                | 1 -
 arch/arm/mach-shmobile/board-lager.c          | 1 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h | 1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        | 8 ++++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 734b3ee..406077c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -61,7 +61,6 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select HAVE_ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 1e99b17..d0da052 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -102,6 +102,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
+	.init_early	= r8a7790_init_delay,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 2e919e6..7851cc1 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -4,6 +4,7 @@
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
+void r8a7790_init_delay(void);
 void r8a7790_timer_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ece60c6..f01542e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -208,6 +208,13 @@ void __init r8a7790_timer_init(void)
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
 
 static const char *r8a7790_boards_compat_dt[] __initdata = {
@@ -216,6 +223,7 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.init_early	= r8a7790_init_delay,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
-- 
1.8.2.1
