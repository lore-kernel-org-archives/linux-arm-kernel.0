From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 14 Oct 2014 14:04:08 -0500
Subject: [PATCHv3] arm: socfpga: fix fetching cpu1start_addr for SMP
Message-ID: <1413313448-5835-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

When CPU1 is brought out of reset, it's MMU is not turned on yet, so it will
only be able to use physical addresses. For systems with that have the
MMU page configured for 0xC0000000, 0x80000000, or 0x40000000
"BIC 0x40000000" will work just fine, as it was just converting the
virtual address of &cpu1start_addr into a physical address, ie. 0xC0000000
became 0x80000000. So for systems where the SDRAM controller was able to do a
wrap-around access, this was working fine, as it was just dropping the MSB,
but for systems where out of bounds memory access is not allowed, this would
not allow CPU1 to correctly fetch &cpu1start_addr.

This patch fixes the secondary_trampoline code to correctly fetch the
physical address of cpu1start_addr directly. The patch will grab the
correct PAGE_OFFSET and convert &cpu1start_addr to the physical address
correctly.

While at it, change the name of cpu1start_addr to socfpga_cpu1start_addr
to avoid any future naming collisions for multiplatform image.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: Used PAGE_OFFSET to get the physical address
v2: Correctly get the physical address instead of just a BIC hack.
---
 arch/arm/mach-socfpga/core.h    |  2 +-
 arch/arm/mach-socfpga/headsmp.S | 20 ++++++++++----------
 arch/arm/mach-socfpga/platsmp.c |  5 +++--
 arch/arm/mach-socfpga/socfpga.c |  4 ++--
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..60c443d 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -40,7 +40,7 @@ extern void __iomem *rst_manager_base_addr;
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
-extern unsigned long cpu1start_addr;
+extern unsigned long socfpga_cpu1start_addr;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 95c115d..8c616e1 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -9,21 +9,21 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/memory.h>
 
 	.arch	armv7-a
 
 ENTRY(secondary_trampoline)
-	movw	r2, #:lower16:cpu1start_addr
-	movt  r2, #:upper16:cpu1start_addr
-
-	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
-		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
-	bic	r2, r2, #0x40000000
-
-	ldr	r0, [r2]
-	ldr	r1, [r0]
-	bx	r1
+	adr	r0, 1f
+	ldmia	r0, {r1, r2}
+	sub	r2, r2, #PAGE_OFFSET
+	ldr	r3, [r2]
+	ldr	r4, [r3]
+	bx	r4
 
+	.align
+1:	.long	.
+	.long	socfpga_cpu1start_addr
 ENTRY(secondary_trampoline_end)
 
 ENTRY(socfpga_secondary_startup)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 5356a72..ba84c58 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -33,11 +33,12 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
-	if (cpu1start_addr) {
+	if (socfpga_cpu1start_addr) {
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
 		__raw_writel(virt_to_phys(socfpga_secondary_startup),
-			(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
+			(sys_manager_base_addr + (socfpga_cpu1start_addr
+						  & 0x000000ff)));
 
 		flush_cache_all();
 		smp_wmb();
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index adbf383..383d61e 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -29,7 +29,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
-unsigned long cpu1start_addr;
+unsigned long socfpga_cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
@@ -70,7 +70,7 @@ void __init socfpga_sysmgr_init(void)
 	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
 
 	if (of_property_read_u32(np, "cpu1-start-addr",
-			(u32 *) &cpu1start_addr))
+			(u32 *) &socfpga_cpu1start_addr))
 		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
 
 	sys_manager_base_addr = of_iomap(np, 0);
-- 
2.0.3
