From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:06 +0200
Subject: [PATCH 2/6] ARM: omap: allow building omap44xx without SMP
In-Reply-To: <1345648390-4234-1-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
Message-ID: <1345648390-4234-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new omap4 cpuidle implementation currently requires
ARCH_NEEDS_CPU_IDLE_COUPLED, which only works on SMP.

This patch makes it possible to build a non-SMP kernel
for that platform. This is not normally desired for
end-users but can be useful for testing.

Without this patch, building rand-0y2jSKT results in:

drivers/cpuidle/coupled.c: In function 'cpuidle_coupled_poke':
drivers/cpuidle/coupled.c:317:3: error: implicit declaration of function '__smp_call_function_single' [-Werror=implicit-function-declaration]

It's not clear if this patch is the best solution for
the problem at hand. I have made sure that we can now
build the kernel in all configurations, but that does
not mean it will actually work on an OMAP44xx.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig       |    2 +-
 arch/arm/mach-omap2/cpuidle44xx.c |    3 ++-
 include/linux/cpuidle.h           |    4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dd2db02..66a8be3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -62,7 +62,7 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
-	select ARCH_NEEDS_CPU_IDLE_COUPLED
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 
 config SOC_OMAP5
 	bool "TI OMAP5"
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index ee05e19..288bee6 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -238,8 +238,9 @@ int __init omap4_idle_init(void)
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		dev->coupled_cpus = *cpu_online_mask;
-
+#endif
 		cpuidle_register_driver(&omap4_idle_driver);
 
 		if (cpuidle_register_device(dev)) {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 040b13b..279b1ea 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -194,6 +194,10 @@ static inline int cpuidle_play_dead(void) {return -ENODEV; }
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomic_t *a);
+#else
+static inline void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev, atomic_t *a)
+{
+}
 #endif
 
 /******************************
-- 
1.7.10
