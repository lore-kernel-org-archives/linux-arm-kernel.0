From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sat,  7 Jan 2017 22:50:42 +0530
Subject: [PATCH WIP 1/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <20170107171339.GA5044@afzalpc>
References: <20170107171339.GA5044@afzalpc>
Message-ID: <20170107172042.6288-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No-MMU dynamic exception base address configuration on processors
with CP15.

TODO: Handle MMU case as well as ARM_MPU scenario dynamically

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/mm/nommu.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 681cec879caf..e82056df0635 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -23,6 +24,8 @@
 
 #include "mm.h"
 
+unsigned long vectors_base;
+
 #ifdef CONFIG_ARM_MPU
 struct mpu_rgn_info mpu_rgn_info;
 
@@ -279,15 +282,70 @@ static void sanity_check_meminfo_mpu(void) {}
 static void __init mpu_setup(void) {}
 #endif /* CONFIG_ARM_MPU */
 
+#ifdef CONFIG_CPU_CP15
+/*
+ * ID_PRF1 bits (CP#15 ID_PFR1)
+ */
+#define ID_PFR1_SE (0x3 << 4)	/* Security extension enable bits */
+
+#ifndef CONFIG_CPU_HIGH_VECTOR
+static inline unsigned long get_id_pfr1(void)
+{
+	unsigned long val;
+	asm("mrc p15, 0, %0, c0, c1, 1" : "=r" (val) : : "cc");
+	return val;
+}
+
+static inline void set_vbar(unsigned long val)
+{
+	asm("mcr p15, 0, %0, c12, c0, 0" : : "r" (val) : "cc");
+}
+
+static bool __init security_extensions_enabled(void)
+{
+	return !!(get_id_pfr1() & ID_PFR1_SE);
+}
+#endif
+
+static unsigned long __init setup_vector_base(void)
+{
+	unsigned long reg, base;
+
+	reg = get_cr();
+
+#ifdef CONFIG_CPU_HIGH_VECTOR
+	set_cr(reg | CR_V);
+	base = 0xFFFF0000;
+#else
+	set_cr(reg & ~CR_V);
+	base = 0;
+	if (security_extensions_enabled()) {
+#ifdef CONFIG_REMAP_VECTORS_TO_RAM
+		base = CONFIG_DRAM_BASE;
+#endif
+		set_vbar(base);
+	}
+#endif /* CONFIG_CPU_HIGH_VECTOR */
+
+	return base;
+}
+#endif /* CONFIG_CPU_CP15 */
+
 void __init arm_mm_memblock_reserve(void)
 {
 #ifndef CONFIG_CPU_V7M
+
+#ifdef CONFIG_CPU_CP15
+	vectors_base = setup_vector_base();
+#else
+	vectors_base = CONFIG_VECTORS_BASE;
+#endif
 	/*
 	 * Register the exception vector page.
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
-	memblock_reserve(CONFIG_VECTORS_BASE, 2 * PAGE_SIZE);
+	memblock_reserve(vectors_base, 2 * PAGE_SIZE);
 #else /* ifndef CONFIG_CPU_V7M */
 	/*
 	 * There is no dedicated vector page on V7-M. So nothing needs to be
@@ -311,7 +369,7 @@ void __init sanity_check_meminfo(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	early_trap_init((void *)CONFIG_VECTORS_BASE);
+	early_trap_init((void *)vectors_base);
 	mpu_setup();
 	bootmem_init();
 }
-- 
2.11.0
