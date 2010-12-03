From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:24:41 +0000
Subject: [PATCH 17/22] ARM: SMP: consolidate the common parts of
	smp_prepare_cpus()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcBN-0007s5-M9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a certain amount of smp_prepare_cpus() which doesn't belong
in the platform support code - that is, code which is invariant to the
SMP implementation.  Move this code into arch/arm/kernel/smp.c, and
add a platform_ prefix to the original function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp.h       |    9 ++++---
 arch/arm/kernel/smp.c            |   49 +++++++++++++++++++++++++++++--------
 arch/arm/mach-omap2/omap-smp.c   |   33 +++++--------------------
 arch/arm/mach-realview/platsmp.c |   41 ++++++++-----------------------
 arch/arm/mach-s5pv310/platsmp.c  |   35 +++++---------------------
 arch/arm/mach-tegra/platsmp.c    |   18 +------------
 arch/arm/mach-ux500/platsmp.c    |   24 ++----------------
 arch/arm/mach-vexpress/platsmp.c |   43 +++++++-------------------------
 8 files changed, 83 insertions(+), 169 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index f93d0a6..96ed521 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -45,10 +45,6 @@ asmlinkage void do_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-/*
- * Move global data into per-processor storage.
- */
-extern void smp_store_cpu_info(unsigned int cpuid);
 
 /*
  * Raise an IPI cross call on CPUs in callmap.
@@ -73,6 +69,11 @@ asmlinkage void secondary_start_kernel(void);
 extern void platform_secondary_init(unsigned int cpu);
 
 /*
+ * Initialize cpu_possible map, and enable coherency
+ */
+extern void platform_smp_prepare_cpus(unsigned int);
+
+/*
  * Initial data for bringing up a secondary CPU.
  */
 struct secondary_data {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48bccf3..d50e612 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -282,6 +282,17 @@ void __ref cpu_die(void)
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /*
+ * Called by both boot and secondaries to move global data into
+ * per-processor storage.
+ */
+static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
+{
+	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
+
+	cpu_info->loops_per_jiffy = loops_per_jiffy;
+}
+
+/*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
@@ -339,17 +350,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	cpu_idle();
 }
 
-/*
- * Called by both boot and secondaries to move global data into
- * per-processor storage.
- */
-void __cpuinit smp_store_cpu_info(unsigned int cpuid)
-{
-	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
-
-	cpu_info->loops_per_jiffy = loops_per_jiffy;
-}
-
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	int cpu;
@@ -372,6 +372,33 @@ void __init smp_prepare_boot_cpu(void)
 	per_cpu(cpu_data, cpu).idle = current;
 }
 
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = num_possible_cpus();
+
+	smp_store_cpu_info(smp_processor_id());
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		/*
+		 * Initialise the SCU if there are more than one CPU
+		 * and let them know where to start.
+		 */
+		platform_smp_prepare_cpus(max_cpus);
+	}
+}
+
 static void send_ipi_message(const struct cpumask *mask, enum ipi_msg_type msg)
 {
 	/*
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 405a8fc..3c3d679 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -123,20 +122,10 @@ void __init smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -144,18 +133,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		/*
-		 * Initialise the SCU and wake up the secondary core using
-		 * wakeup_secondary().
-		 */
-		scu_enable(scu_base);
-		wakeup_secondary();
-	}
+	/*
+	 * Initialise the SCU and wake up the secondary core using
+	 * wakeup_secondary().
+	 */
+	scu_enable(scu_base);
+	wakeup_secondary();
 }
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index ef3cc86..380562c 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -19,7 +19,6 @@
 #include <asm/cacheflush.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/localtimer.h>
 #include <asm/unified.h>
 
 #include <mach/board-eb.h>
@@ -147,20 +146,10 @@ void __init smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -168,22 +157,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		scu_enable(scu_base_addr());
-
-		/*
-		 * Write the address of secondary startup into the
-		 * system-wide flags register. The BootMonitor waits
-		 * until it receives a soft interrupt, and then the
-		 * secondary CPU branches to this address.
-		 */
-		__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
-			     __io_address(REALVIEW_SYS_FLAGSSET));
-	}
+	scu_enable(scu_base_addr());
+
+	/*
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The BootMonitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
+	 */
+	__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
+		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index 560ada8..51c44d4 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
@@ -142,18 +141,10 @@ void __init smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/* are we trying to boot more cores than exist? */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -161,25 +152,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
+	scu_enable(scu_base_addr());
+
 	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start.
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The boot monitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
 	 */
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		scu_enable(scu_base_addr());
-
-		/*
-		 * Write the address of secondary startup into the
-		 * system-wide flags register. The boot monitor waits
-		 * until it receives a soft interrupt, and then the
-		 * secondary CPU branches to this address.
-		 */
 	__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)), S5P_VA_SYSRAM);
-	}
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 66d0634..b66a0c2 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -22,7 +22,6 @@
 #include <asm/cacheflush.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 
 #include <mach/iomap.h>
@@ -127,20 +126,10 @@ void __init smp_init_cpus(void)
 		cpu_set(i, cpu_possible_map);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = scu_get_core_count(scu_base);
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -148,8 +137,5 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	if (max_cpus > 1) {
-		percpu_timer_setup();
-		scu_enable(scu_base);
-	}
+	scu_enable(scu_base);
 }
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index fd40fa1..458a288 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 
@@ -138,20 +137,10 @@ void __init smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -159,13 +148,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-		scu_enable(__io_address(UX500_SCU_BASE));
-		wakeup_secondary();
-	}
+	scu_enable(__io_address(UX500_SCU_BASE));
+	wakeup_secondary();
 }
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index b5a7586..a0341d1 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
@@ -136,20 +135,10 @@ void __init smp_init_cpus(void)
 		set_cpu_possible(i, true);
 }
 
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
 	int i;
 
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
@@ -157,27 +146,15 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
+	scu_enable(scu_base_addr());
+
 	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start.
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The boot monitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
 	 */
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		scu_enable(scu_base_addr());
-
-		/*
-		 * Write the address of secondary startup into the
-		 * system-wide flags register. The boot monitor waits
-		 * until it receives a soft interrupt, and then the
-		 * secondary CPU branches to this address.
-		 */
-		writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-		writel(BSYM(virt_to_phys(vexpress_secondary_startup)),
-			MMIO_P2V(V2M_SYS_FLAGSSET));
-	}
+	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
+	writel(BSYM(virt_to_phys(vexpress_secondary_startup)),
+		MMIO_P2V(V2M_SYS_FLAGSSET));
 }
-- 
1.6.2.5
