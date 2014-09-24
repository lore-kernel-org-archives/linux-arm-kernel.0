From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Wed, 24 Sep 2014 15:27:28 -0500
Subject: [PATCH 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
Message-ID: <1411590449-9794-2-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Use WFI when putting CPU1 to sleep.  Don't hold CPU1 in reset
since that results in increased power consumption.

Reset CPU1 briefly during CPU1 bootup.

This has been tested for hotplug and suspend/resume and results
in no increased power consumption.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 arch/arm/mach-socfpga/core.h    |    2 ++
 arch/arm/mach-socfpga/platsmp.c |   12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..c4a0929 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -28,6 +28,8 @@
 #define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
 #define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
 
+#define RSTMGR_MPUMODRST_CPU1		0x2     /*CPU1 Reset*/
+
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 5356a72..1d5f8ad 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -34,6 +34,10 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
 	if (cpu1start_addr) {
+		/* This will put CPU #1 into reset.*/
+		__raw_writel(RSTMGR_MPUMODRST_CPU1,
+			     rst_manager_base_addr + 0x10);
+
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
 		__raw_writel(virt_to_phys(socfpga_secondary_startup),
@@ -86,10 +90,12 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
  */
 static void socfpga_cpu_die(unsigned int cpu)
 {
-	cpu_do_idle();
+	/* Flush the L1 data cache. */
+	flush_cache_all();
 
-	/* We should have never returned from idle */
-	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+	/* Do WFI. If we wake up early, go back into WFI */
+	while (1)
+		cpu_do_idle();
 }
 
 struct smp_operations socfpga_smp_ops __initdata = {
-- 
1.7.9.5
