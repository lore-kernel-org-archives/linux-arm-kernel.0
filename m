From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:24:21 +0000
Subject: [PATCH 16/22] ARM: SMP: get rid of references to poke_milo and Milo
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcB3-0007s1-IH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Milo is an old boot loader, which is no longer relevant for these
platforms.  References to it are misleading.  Move the code out
of poke_milo(), and remove references to milo in comments.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/platsmp.c |   44 ++++++++++---------------------------
 arch/arm/mach-tegra/platsmp.c    |    7 ------
 2 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 6595e87..ef3cc86 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -99,14 +99,9 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	flush_cache_all();
 
 	/*
-	 * XXX
-	 *
-	 * This is a later addition to the booting protocol: the
-	 * bootMonitor now puts secondary cores into WFI, so
-	 * poke_milo() no longer gets the cores moving; we need
-	 * to send a soft interrupt to wake the secondary core.
-	 * Use smp_cross_call() for this, since there's little
-	 * point duplicating the code here
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
 	 */
 	smp_cross_call(cpumask_of(cpu), 1);
 
@@ -128,22 +123,6 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return pen_release != -1 ? -ENOSYS : 0;
 }
 
-static void __init poke_milo(void)
-{
-	/* nobody is to be released from the pen yet */
-	pen_release = -1;
-
-	/*
-	 * Write the address of secondary startup into the system-wide flags
-	 * register. The BootMonitor waits for this register to become
-	 * non-zero.
-	 */
-	__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
-		     __io_address(REALVIEW_SYS_FLAGSSET));
-
-	mb();
-}
-
 /*
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
@@ -189,13 +168,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start. Note that, on modern versions of
-	 * MILO, the "poke" doesn't actually do anything until each
-	 * individual core is sent a soft interrupt to get it out of
-	 * WFI
-	 */
 	if (max_cpus > 1) {
 		/*
 		 * Enable the local timer or broadcast device for the
@@ -204,6 +176,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		percpu_timer_setup();
 
 		scu_enable(scu_base_addr());
-		poke_milo();
+
+		/*
+		 * Write the address of secondary startup into the
+		 * system-wide flags register. The BootMonitor waits
+		 * until it receives a soft interrupt, and then the
+		 * secondary CPU branches to this address.
+		 */
+		__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
+			     __io_address(REALVIEW_SYS_FLAGSSET));
 	}
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 5b194dd..66d0634 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -148,13 +148,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
 
-	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start. Note that, on modern versions of
-	 * MILO, the "poke" doesn't actually do anything until each
-	 * individual core is sent a soft interrupt to get it out of
-	 * WFI
-	 */
 	if (max_cpus > 1) {
 		percpu_timer_setup();
 		scu_enable(scu_base);
-- 
1.6.2.5
