From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Apr 2016 13:06:43 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <20160419140220.GA9503@pengutronix.de>
References: <20160419140220.GA9503@pengutronix.de>
Message-ID: <20160420110643.GI31470@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 04:02:20PM +0200, Steffen Trumtrar wrote:
> Hi!
> 
> According to kernelci.org (and validating on my own hardware), the current
> socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.
> 
> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
> 
> vs
> 
> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
> 
> Both boot successfully, but notice that the board fails to bring up CPU1 if
> thumb2 support is enabled.
> 
> Any ideas why this might be happening?

Related to this issue, does anybody have an idea why the SoCFPGA
secondary startup code goes through hoops before jumping to
secondary_startup? The following patch seems to work fine, anyone an
idea what the jump through the cpu1start_addr register is good for?

Sascha

----------------------------------8<--------------------------

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 575195b..776b960 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -48,7 +48,7 @@ extern unsigned int socfpga_sdram_self_refresh_sz;
 
 extern char secondary_trampoline, secondary_trampoline_end;
 
-extern unsigned long socfpga_cpu1start_addr;
+extern unsigned long socfpga_boot_fn;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfee00000
 
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 5d94b7a..e486670 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -9,27 +9,14 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/memory.h>
-#include <asm/assembler.h>
 
-	.arch	armv7-a
+	.arm
 
 ENTRY(secondary_trampoline)
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
+	ldr	pc, 1f
+ENDPROC(secondary_trampoline)
+	.globl	socfpga_boot_fn
+socfpga_boot_fn:
+1:	.space	4
 
-	.align
-1:	.long	.
-	.long	socfpga_cpu1start_addr
 ENTRY(secondary_trampoline_end)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 0794574..f278351 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -33,15 +33,14 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
-	if (socfpga_cpu1start_addr) {
+	if (1) {
 		/* This will put CPU #1 into reset. */
 		writel(RSTMGR_MPUMODRST_CPU1,
 		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+		socfpga_boot_fn = virt_to_phys(secondary_startup);
 
-		writel(virt_to_phys(secondary_startup),
-		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
+		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
 		flush_cache_all();
 		smp_wmb();
@@ -58,13 +57,13 @@ static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle
 {
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
-	if (socfpga_cpu1start_addr) {
+	if (1) {
 		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
 		       SOCFPGA_A10_RSTMGR_MODMPURST);
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(secondary_startup),
-		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
+		socfpga_boot_fn = virt_to_phys(secondary_startup);
+
+		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
 		flush_cache_all();
 		smp_wmb();
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
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
