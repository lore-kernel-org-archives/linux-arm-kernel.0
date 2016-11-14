From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:08 +0530
Subject: [PATCH 13/16] ARM: zynq: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-14-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

At the same time this patch cleans up mach-zynq platform files by
removing static mapping of SCU and dropping zynq_scu_map_io and zynq_map_io
functions.

CC: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-zynq/common.c  | 32 +-------------------------------
 arch/arm/mach-zynq/common.h  |  2 --
 arch/arm/mach-zynq/platsmp.c |  2 ++
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index d12002c..3986b2b 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -38,7 +38,6 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/smp_scu.h>
 #include <asm/system_info.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -48,8 +47,6 @@
 #define ZYNQ_DEVCFG_PS_VERSION_SHIFT	28
 #define ZYNQ_DEVCFG_PS_VERSION_MASK	0xF
 
-void __iomem *zynq_scu_base;
-
 /**
  * zynq_memory_init - Initialize special memory
  *
@@ -153,33 +150,6 @@ static void __init zynq_timer_init(void)
 	clocksource_probe();
 }
 
-static struct map_desc zynq_cortex_a9_scu_map __initdata = {
-	.length	= SZ_256,
-	.type	= MT_DEVICE,
-};
-
-static void __init zynq_scu_map_io(void)
-{
-	unsigned long base;
-
-	base = scu_a9_get_base();
-	zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
-	/* Expected address is in vmalloc area that's why simple assign here */
-	zynq_cortex_a9_scu_map.virtual = base;
-	iotable_init(&zynq_cortex_a9_scu_map, 1);
-	zynq_scu_base = (void __iomem *)base;
-	BUG_ON(!zynq_scu_base);
-}
-
-/**
- * zynq_map_io - Create memory mappings needed for early I/O.
- */
-static void __init zynq_map_io(void)
-{
-	debug_ll_io_init();
-	zynq_scu_map_io();
-}
-
 static void __init zynq_irq_init(void)
 {
 	zynq_early_slcr_init();
@@ -196,7 +166,7 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.l2c_aux_val    = 0x00400000,
 	.l2c_aux_mask	= 0xffbfffff,
 	.smp		= smp_ops(zynq_smp_ops),
-	.map_io		= zynq_map_io,
+	.map_io		= debug_ll_io_init,
 	.init_irq	= zynq_irq_init,
 	.init_machine	= zynq_init_machine,
 	.init_late	= zynq_init_late,
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index e771933..7c2f008 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -33,8 +33,6 @@ extern int zynq_cpun_start(u32 address, int cpu);
 extern const struct smp_operations zynq_smp_ops;
 #endif
 
-extern void __iomem *zynq_scu_base;
-
 void zynq_pm_late_init(void);
 
 static inline void zynq_core_pm_init(void)
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 7cd9865..2d09119 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -33,6 +33,7 @@
  * be called from zynq_cpun_start() because it is not in __init section.
  */
 static int ncores;
+static void __iomem *zynq_scu_base;
 
 int zynq_cpun_start(u32 address, int cpu)
 {
@@ -108,6 +109,7 @@ static void __init zynq_smp_init_cpus(void)
 
 static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
 {
+	zynq_scu_base = of_scu_get_base();
 	scu_enable(zynq_scu_base);
 }
 
-- 
2.7.4
