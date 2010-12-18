From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 11:04:25 +0000
Subject: [PATCH] ARM: Fix subtle race in CPU pen_release hotplug code
Message-ID: <E1PTuaP-0000Fl-EF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a subtle race in the CPU hotplug code, where a CPU which has
been offlined can online itself before being requested, which results
in things going astray on the next online/offline cycle.

What happens in the normal online/offline/online cycle is:

	CPU0			CPU3
	requests boot of CPU3
	pen_release = 3
	flush cache line
				checks pen_release, reads 3
				starts boot
				pen_release = -1
	... requests CPU3 offline ...
				... dies ...
				checks pen_release, reads -1
	requests boot of CPU3
	pen_release = 3
	flush cache line
				checks pen_release, reads 3
				starts boot
				pen_release = -1

However, as the write of -1 of pen_release is not fully flushed back to
memory, and the checking of pen_release is done with caches disabled,
this allows CPU3 the opportunity to read the old value of pen_release:

	CPU0			CPU3
	requests boot of CPU3
	pen_release = 3
	flush cache line
				checks pen_release, reads 3
				starts boot
				pen_release = -1
	... requests CPU3 offline ...
				... dies ...
				checks pen_release, reads 3
				starts boot
				pen_release = -1
	requests boot of CPU3
	pen_release = 3
	flush cache line

Fix this by grouping the write of pen_release along with its cache line
flushing code to ensure that any update to pen_release is always pushed
out to physical memory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/platsmp.c |   19 +++++++++++++++----
 arch/arm/mach-s5pv310/platsmp.c  |   20 +++++++++++++++-----
 arch/arm/mach-ux500/platsmp.c    |   22 +++++++++++++++-------
 arch/arm/mach-vexpress/platsmp.c |   20 +++++++++++++++-----
 4 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 226c631..bb8d6c4 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -36,6 +36,19 @@ extern void realview_secondary_startup(void);
  */
 volatile int __cpuinitdata pen_release = -1;
 
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
 static void __iomem *scu_base_addr(void)
 {
 	if (machine_is_realview_eb_mp())
@@ -64,8 +77,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
-	smp_wmb();
+	write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -92,8 +104,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Note that "pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu;
-	flush_cache_all();
+	write_pen_release(cpu);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index 18aaf5f..98c0474 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -37,6 +37,19 @@ extern void s5pv310_secondary_startup(void);
 
 volatile int __cpuinitdata pen_release = -1;
 
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
 static void __iomem *scu_base_addr(void)
 {
 	return (void __iomem *)(S5P_VA_SCU);
@@ -57,8 +70,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
-	smp_wmb();
+	write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -85,9 +97,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Note that "pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu;
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	write_pen_release(cpu);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index ddedbc8..f71175a 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -27,6 +27,19 @@
  */
 volatile int __cpuinitdata pen_release = -1;
 
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -42,7 +55,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
+	write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -66,9 +79,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the holding pen - release it, then wait for it to flag
 	 * that it has been released by resetting pen_release.
 	 */
-	pen_release = cpu;
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release) + 1);
+	write_pen_release(cpu);
 
 	smp_cross_call(cpumask_of(cpu), 1);
 
@@ -89,9 +100,6 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init wakeup_secondary(void)
 {
-	/* nobody is to be released from the pen yet */
-	pen_release = -1;
-
 	/*
 	 * write the address of secondary startup into the backup ram register
 	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index d7e0cb9..8ce9fef 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -34,6 +34,19 @@ extern void vexpress_secondary_startup(void);
  */
 volatile int __cpuinitdata pen_release = -1;
 
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
 static void __iomem *scu_base_addr(void)
 {
 	return MMIO_P2V(A9_MPCORE_SCU);
@@ -54,8 +67,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
-	smp_wmb();
+	write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -80,9 +92,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * since we haven't sent them a soft interrupt, they shouldn't
 	 * be there.
 	 */
-	pen_release = cpu;
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	write_pen_release(cpu);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
-- 
1.6.2.5
