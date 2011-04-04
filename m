From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 4 Apr 2011 12:48:37 +0530
Subject: [PATCH] OMAP4: Move the privately used SMP boot functions to OMAP specific header.
Message-ID: <mailman.186.1301905263.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Header files in arch/arm/*/include/mach included from
arch/arm/include/asm/*.h are there to provide necessary definitions for
either the rest of the kernel or the ARM specific parts.  They shouldn't
be polluted with *any* platform private stuff which is not absolutely
necessary to satisfy the rest of the kernel.

Hence move the OMAP specific SMP boot functions to different header
instead of keeping them in 'plat/smp.h' which gets included indirectly
by linux/smp.h

The patch is outcome of the discussion in below thread:
	http://www.spinics.net/lists/arm-kernel/msg120363.html

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 +++++++
 arch/arm/plat-omap/include/plat/smp.h           |    6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index de441c0..e4bd876 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -33,4 +33,11 @@ extern void __iomem *gic_dist_base_addr;
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
+#ifdef CONFIG_SMP
+/* Needed for secondary core boot */
+extern void omap_secondary_startup(void);
+extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
+extern void omap_auxcoreboot_addr(u32 cpu_addr);
+extern u32 omap_read_auxcoreboot0(void);
+#endif
 #endif
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index 7a10257..416e9d5 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -19,12 +19,6 @@
 
 #include <asm/hardware/gic.h>
 
-/* Needed for secondary core boot */
-extern void omap_secondary_startup(void);
-extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
-extern void omap_auxcoreboot_addr(u32 cpu_addr);
-extern u32 omap_read_auxcoreboot0(void);
-
 /*
  * We use Soft IRQ1 as the IPI
  */
-- 
1.6.0.4


--------------070909030204030705050008--
