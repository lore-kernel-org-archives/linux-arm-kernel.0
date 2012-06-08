From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jun 2012 14:54:46 +0000
Subject: [PATCH v7 00/12] Per SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <201206081454.46422.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 June 2012, Marc Zyngier wrote:
> [As per Arnd request, I've updated this patch series, in the hope that
> it could be useful to the single zImage work]
> 
> This patch series introduces a per-soc descriptor which should, in the
> end, contain most of the SoC specific operations.
> 
> This first patch series introduces the arm_soc_desc structure, adds
> per-soc SMP and CPU hotplug operations, and converts all SMP platform
> to this new scheme.
> 
> Patches against v3.5-rc1. Tested on VExpress (Cortex A15).
> 
> Also available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git soc_desc-v3.5-rc1

With my experimental multiplatform kernel tree, it let me actually build
an allyesconfig including SMP enabled, so just for that you get an

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two comments though:

1. I needed the patch below to avoid conflicting pen_release symbols.
I was not sure if any of the platforms rely on the pen_release variable
being located in the same cache line or page as the code accessing it,
or why else it is defined in assembly. If we don't have a reason for that,
we should probably pick the simpler approach and just have a single
definition for this in common ARM SMP code.

2. Sorry for having to bring it up yet again, but it still feels silly
to have the split data structures when nothing in the code actually
checks whether the functions are __init or __cpuinit, which was the
intention for splitting the struct in the first place according to
Nico. If people still like the split, I'll just shut up, but I would
prefer if this could be converted (back) into a single 'struct smp_ops'
with function pointers and no "name" field or the ambition to add
stuff other than SMP callbacks.

	Arnd

8<----
fixup: Per SoC descriptor: rename pen_release variables

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index 5364d4b..3b3a9b4 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -40,4 +40,4 @@ ENDPROC(exynos4_secondary_startup)
 
 	.align 2
 1:	.long	.
-	.long	pen_release
+	.long	exynos_pen_release
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 52d7178..9855335 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -23,7 +23,7 @@
 
 #include "common.h"
 
-extern volatile int pen_release;
+extern volatile int exynos_pen_release;
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -79,7 +79,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (exynos_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 3800cba..945ae14 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -44,19 +44,19 @@ extern void exynos4_secondary_startup(void);
  * boot "holding pen"
  */
 
-volatile int pen_release = -1;
+volatile int exynos_pen_release = -1;
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
+ * Write exynos_pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
 static void write_pen_release(int val)
 {
-	pen_release = val;
+	exynos_pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	__cpuc_flush_dcache_area((void *)&exynos_pen_release, sizeof(exynos_pen_release));
+	outer_clean_range(__pa(&exynos_pen_release), __pa(&exynos_pen_release + 1));
 }
 
 static void __iomem *scu_base_addr(void)
@@ -101,9 +101,9 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting exynos_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "exynos_pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
 	write_pen_release(cpu_logical_map(cpu));
@@ -143,7 +143,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 			CPU1_BOOT_REG);
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
-		if (pen_release == -1)
+		if (exynos_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -155,7 +155,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return exynos_pen_release != -1 ? -ENOSYS : 0;
 }
 
 /*
diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
index bcd5af2..d42e457 100644
--- a/arch/arm/mach-msm/headsmp.S
+++ b/arch/arm/mach-msm/headsmp.S
@@ -38,4 +38,4 @@ ENDPROC(msm_secondary_startup)
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	msm_pen_release
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 6ba3602..39e9785 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -15,7 +15,7 @@
 
 #include "core.h"
 
-extern volatile int pen_release;
+extern volatile int msm_pen_release;
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -40,7 +40,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (msm_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 87c515f..ea675b5 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -39,7 +39,7 @@ extern void msm_secondary_startup(void);
  * control for which core is the next to come out of the secondary
  * boot "holding pen".
  */
-volatile int pen_release = -1;
+volatile int msm_pen_release = -1;
 
 static DEFINE_SPINLOCK(boot_lock);
 
@@ -65,7 +65,7 @@ static void __cpuinit msm_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
+	msm_pen_release = -1;
 	smp_wmb();
 
 	/*
@@ -114,14 +114,14 @@ static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *id
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting msm_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "msm_pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu_logical_map(cpu);
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	msm_pen_release = cpu_logical_map(cpu);
+	__cpuc_flush_dcache_area((void *)&msm_pen_release, sizeof(msm_pen_release));
+	outer_clean_range(__pa(&msm_pen_release), __pa(&msm_pen_release + 1));
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
@@ -133,7 +133,7 @@ static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *id
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (msm_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -145,7 +145,7 @@ static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *id
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return msm_pen_release != -1 ? -ENOSYS : 0;
 }
 
 /*
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index c308b85..59173ea 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -16,7 +16,7 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-extern volatile int pen_release;
+extern volatile int versatile_pen_release;
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -71,7 +71,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (versatile_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear13xx/headsmp.S
index ed85473..58d667b 100644
--- a/arch/arm/mach-spear13xx/headsmp.S
+++ b/arch/arm/mach-spear13xx/headsmp.S
@@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	spear_pen_release
 ENDPROC(spear13xx_secondary_startup)
diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
index 5c6867b..ed5092e 100644
--- a/arch/arm/mach-spear13xx/hotplug.c
+++ b/arch/arm/mach-spear13xx/hotplug.c
@@ -17,7 +17,7 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-extern volatile int pen_release;
+extern volatile int spear_pen_release;
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -61,7 +61,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	for (;;) {
 		wfi();
 
-		if (pen_release == cpu) {
+		if (spear_pen_release == cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index 49d5377..3b9703b 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -24,7 +24,7 @@
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int __cpuinitdata pen_release = -1;
+volatile int __cpuinitdata spear_pen_release = -1;
 static DEFINE_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
@@ -43,7 +43,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
+	spear_pen_release = -1;
 	smp_wmb();
 
 	/*
@@ -66,19 +66,19 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting spear_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu;
+	spear_pen_release = cpu;
 	flush_cache_all();
 	outer_flush_all();
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (spear_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -90,7 +90,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return spear_pen_release != -1 ? -ENOSYS : 0;
 }
 
 /*
diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
index 08da5589..a39f7cc 100644
--- a/arch/arm/mach-ux500/headsmp.S
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -36,4 +36,4 @@ ENDPROC(u8500_secondary_startup)
 
 	.align 2
 1:	.long	.
-	.long	pen_release
+	.long	ux500_pen_release
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 62a2b33..7862f4f 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -17,7 +17,7 @@
 
 #include <mach-ux500/setup.h>
 
-extern volatile int pen_release;
+extern volatile int ux500_pen_release;
 
 static inline void platform_do_lowpower(unsigned int cpu)
 {
@@ -27,7 +27,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	for (;;) {
 		dsb();
 		wfi();
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (ux500_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 75cc904..b0b72d9 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -31,19 +31,19 @@ extern void u8500_secondary_startup(void);
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int pen_release = -1;
+volatile int ux500_pen_release = -1;
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
+ * Write ux500_pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
 static void write_pen_release(int val)
 {
-	pen_release = val;
+	ux500_pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	__cpuc_flush_dcache_area((void *)&ux500_pen_release, sizeof(ux500_pen_release));
+	outer_clean_range(__pa(&ux500_pen_release), __pa(&ux500_pen_release + 1));
 }
 
 static void __iomem *scu_base_addr(void)
@@ -93,7 +93,7 @@ static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting ux500_pen_release.
 	 */
 	write_pen_release(cpu_logical_map(cpu));
 
@@ -101,7 +101,7 @@ static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-		if (pen_release == -1)
+		if (ux500_pen_release == -1)
 			break;
 	}
 
@@ -111,7 +111,7 @@ static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return ux500_pen_release != -1 ? -ENOSYS : 0;
 }
 
 static void __init wakeup_secondary(void)
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index 89281e3..16db50c 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -16,7 +16,7 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
-extern volatile int pen_release;
+extern volatile int versatile_pen_release;
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -66,7 +66,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	for (;;) {
 		wfi();
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (versatile_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index dd703ef..1486d95 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -37,5 +37,5 @@ pen:	ldr	r7, [r6]
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	versatile_pen_release
 ENDPROC(versatile_secondary_startup)
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 0d7e55b..ec9a403 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -23,19 +23,19 @@
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int pen_release = -1;
+volatile int versatile_pen_release = -1;
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
+ * Write versatile_pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
 static void __cpuinit write_pen_release(int val)
 {
-	pen_release = val;
+	versatile_pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	__cpuc_flush_dcache_area((void *)&versatile_pen_release, sizeof(versatile_pen_release));
+	outer_clean_range(__pa(&versatile_pen_release), __pa(&versatile_pen_release + 1));
 }
 
 static DEFINE_SPINLOCK(boot_lock);
@@ -90,7 +90,7 @@ int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idl
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (versatile_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -102,5 +102,5 @@ int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idl
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return versatile_pen_release != -1 ? -ENOSYS : 0;
 }
