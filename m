From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Tue, 14 Oct 2014 14:33:38 -0500
Subject: [PATCH v3 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <1413315219-28885-1-git-send-email-atull@opensource.altera.com>
References: <1413315219-28885-1-git-send-email-atull@opensource.altera.com>
Message-ID: <1413315219-28885-2-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Use WFI when putting CPU1 to sleep.  Don't hold CPU1 in reset
since that results in increased power consumption.

Reset CPU1 briefly during CPU1 bootup.

This has been tested for hotplug and suspend/resume and results
in no increased power consumption.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: no need to flush the caches
    clean up spacing in comments
    replace a register offset with a macro
v3: Use writel, not __raw_writel
---
 arch/arm/mach-socfpga/core.h    |    3 +++
 arch/arm/mach-socfpga/platsmp.c |   19 +++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..953a9c0 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -21,6 +21,7 @@
 #define __MACH_CORE_H
 
 #define SOCFPGA_RSTMGR_CTRL	0x04
+#define SOCFPGA_RSTMGR_MODMPURST	0x10
 #define SOCFPGA_RSTMGR_MODPERRST	0x14
 #define SOCFPGA_RSTMGR_BRGMODRST	0x1c
 
@@ -28,6 +29,8 @@
 #define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
 #define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
 
+#define RSTMGR_MPUMODRST_CPU1		0x2     /* CPU1 Reset */
+
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 5356a72..9166dd4 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -34,17 +34,21 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
 	if (cpu1start_addr) {
+		/* This will put CPU #1 into reset. */
+		writel(RSTMGR_MPUMODRST_CPU1,
+		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
+
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		__raw_writel(virt_to_phys(socfpga_secondary_startup),
-			(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
+		writel(virt_to_phys(socfpga_secondary_startup),
+		       sys_manager_base_addr + (cpu1start_addr & 0x000000ff));
 
 		flush_cache_all();
 		smp_wmb();
 		outer_clean_range(0, trampoline_size);
 
-		/* This will release CPU #1 out of reset.*/
-		__raw_writel(0, rst_manager_base_addr + 0x10);
+		/* This will release CPU #1 out of reset. */
+		writel(0, rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 	}
 
 	return 0;
@@ -86,10 +90,9 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
  */
 static void socfpga_cpu_die(unsigned int cpu)
 {
-	cpu_do_idle();
-
-	/* We should have never returned from idle */
-	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+	/* Do WFI. If we wake up early, go back into WFI */
+	while (1)
+		cpu_do_idle();
 }
 
 struct smp_operations socfpga_smp_ops __initdata = {
-- 
1.7.9.5
