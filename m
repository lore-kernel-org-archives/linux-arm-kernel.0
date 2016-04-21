From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Apr 2016 08:53:00 +0200
Subject: [PATCH] ARM: SoCFPGA: simplify secondary trampoline
Message-ID: <1461221580-27466-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The secondary CPU startup trampoline goes through the system managers
cpu1start_addr register. This seems unnecesary, the trampoline code
can be simplified by directly loading the program counter with the
address of secondary_startup(). Taken from the Rockchip code which
does it exactly like this. While at it add a socfpga_ namespace to
the trampoline functions.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-socfpga/core.h    |  4 ++--
 arch/arm/mach-socfpga/headsmp.S | 27 +++++++---------------
 arch/arm/mach-socfpga/platsmp.c | 51 +++++++++++++++++++----------------------
 arch/arm/mach-socfpga/socfpga.c |  9 --------
 4 files changed, 33 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 575195b..2dca48b 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -46,9 +46,9 @@ extern void __iomem *sdr_ctl_base_addr;
 u32 socfpga_sdram_self_refresh(u32 sdr_base);
 extern unsigned int socfpga_sdram_self_refresh_sz;
 
-extern char secondary_trampoline, secondary_trampoline_end;
+extern char socfpga_secondary_trampoline, socfpga_secondary_trampoline_end;
 
-extern unsigned long socfpga_cpu1start_addr;
+extern unsigned long socfpga_boot_fn;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfee00000
 
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index c160fa3..f445dcf 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -15,22 +15,11 @@
 	.arch	armv7-a
 	.arm
 
-ENTRY(secondary_trampoline)
-	/* CPU1 will always fetch from 0x0 when it is brought out of reset.
-	 * Thus, we can just subtract the PAGE_OFFSET to get the physical
-	 * address of &cpu1start_addr. This would not work for platforms
-	 * where the physical memory does not start at 0x0.
-	*/
-ARM_BE8(setend	be)
-	adr	r0, 1f
-	ldmia	r0, {r1, r2}
-	sub	r2, r2, #PAGE_OFFSET
-	ldr	r3, [r2]
-	ldr	r4, [r3]
-ARM_BE8(rev	r4, r4)
-	bx	r4
-
-	.align
-1:	.long	.
-	.long	socfpga_cpu1start_addr
-ENTRY(secondary_trampoline_end)
+ENTRY(socfpga_secondary_trampoline)
+ARM_BE8(setend be)
+	ldr	pc, 1f
+ENDPROC(socfpga_secondary_trampoline)
+	.globl	socfpga_boot_fn
+socfpga_boot_fn:
+1:	.space	4
+ENTRY(socfpga_secondary_trampoline_end)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 0794574..888f750 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -31,48 +31,41 @@
 
 static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = &socfpga_secondary_trampoline_end -
+			      &socfpga_secondary_trampoline;
 
-	if (socfpga_cpu1start_addr) {
-		/* This will put CPU #1 into reset. */
-		writel(RSTMGR_MPUMODRST_CPU1,
-		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
+	/* This will put CPU #1 into reset. */
+	writel(RSTMGR_MPUMODRST_CPU1,
+	       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+	memcpy(phys_to_virt(0), &socfpga_secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(secondary_startup),
-		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
+	flush_cache_all();
+	smp_wmb();
+	outer_clean_range(0, trampoline_size);
 
-		flush_cache_all();
-		smp_wmb();
-		outer_clean_range(0, trampoline_size);
-
-		/* This will release CPU #1 out of reset. */
-		writel(0, rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
-	}
+	/* This will release CPU #1 out of reset. */
+	writel(0, rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 
 	return 0;
 }
 
 static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = &socfpga_secondary_trampoline_end -
+			      &socfpga_secondary_trampoline;
 
-	if (socfpga_cpu1start_addr) {
-		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
-		       SOCFPGA_A10_RSTMGR_MODMPURST);
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+	writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
+	       SOCFPGA_A10_RSTMGR_MODMPURST);
 
-		writel(virt_to_phys(secondary_startup),
-		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
+	memcpy(phys_to_virt(0), &socfpga_secondary_trampoline, trampoline_size);
 
-		flush_cache_all();
-		smp_wmb();
-		outer_clean_range(0, trampoline_size);
+	flush_cache_all();
+	smp_wmb();
+	outer_clean_range(0, trampoline_size);
 
-		/* This will release CPU #1 out of reset. */
-		writel(0, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_MODMPURST);
-	}
+	/* This will release CPU #1 out of reset. */
+	writel(0, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_MODMPURST);
 
 	return 0;
 }
@@ -88,6 +81,8 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 
+	socfpga_boot_fn = virt_to_phys(secondary_startup);
+
 	socfpga_scu_base_addr = of_iomap(np, 0);
 	if (!socfpga_scu_base_addr)
 		return;
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 7e0aad2..5d7079a 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -30,7 +30,6 @@
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
-unsigned long socfpga_cpu1start_addr;
 
 void __init socfpga_sysmgr_init(void)
 {
@@ -38,14 +37,6 @@ void __init socfpga_sysmgr_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
 
-	if (of_property_read_u32(np, "cpu1-start-addr",
-			(u32 *) &socfpga_cpu1start_addr))
-		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
-
-	/* Ensure that socfpga_cpu1start_addr is visible to other CPUs */
-	smp_wmb();
-	sync_cache_w(&socfpga_cpu1start_addr);
-
 	sys_manager_base_addr = of_iomap(np, 0);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
-- 
2.8.0.rc3
