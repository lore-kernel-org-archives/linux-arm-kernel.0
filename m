From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sun, 22 Jan 2017 08:50:50 +0530
Subject: [PATCH v2 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170122032050.13344-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No-MMU dynamic exception base address configuration on CP15
processors. In the case of low vectors, decision based on whether
security extensions are enabled & whether remap vectors to RAM
CONFIG option is selected.

For no-MMU without CP15, current default value of 0x0 is retained.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2:
 Use existing helpers to detect security extensions
 Rewrite a CPP step to C for readability

 arch/arm/mm/nommu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2740967727e2..20ac52579952 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -22,6 +23,8 @@
 
 #include "mm.h"
 
+unsigned long vectors_base;
+
 #ifdef CONFIG_ARM_MPU
 struct mpu_rgn_info mpu_rgn_info;
 
@@ -278,15 +281,60 @@ static void sanity_check_meminfo_mpu(void) {}
 static void __init mpu_setup(void) {}
 #endif /* CONFIG_ARM_MPU */
 
+#ifdef CONFIG_CPU_CP15
+#ifdef CONFIG_CPU_HIGH_VECTOR
+static unsigned long __init setup_vectors_base(void)
+{
+	unsigned long reg = get_cr();
+
+	set_cr(reg | CR_V);
+	return 0xffff0000;
+}
+#else /* CONFIG_CPU_HIGH_VECTOR */
+/* Write exception base address to VBAR */
+static inline void set_vbar(unsigned long val)
+{
+	asm("mcr p15, 0, %0, c12, c0, 0" : : "r" (val) : "cc");
+}
+
+/*
+ * Security extensions, bits[7:4], permitted values,
+ * 0b0000 - not implemented, 0b0001/0b0010 - implemented
+ */
+static inline bool security_extensions_enabled(void)
+{
+	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+}
+
+static unsigned long __init setup_vectors_base(void)
+{
+	unsigned long base = 0, reg = get_cr();
+
+	set_cr(reg & ~CR_V);
+	if (security_extensions_enabled()) {
+		if (IS_ENABLED(CONFIG_REMAP_VECTORS_TO_RAM))
+			base = CONFIG_DRAM_BASE;
+		set_vbar(base);
+	} else if (IS_ENABLED(CONFIG_REMAP_VECTORS_TO_RAM)) {
+		if (CONFIG_DRAM_BASE != 0)
+			pr_err("Security extensions not enabled, vectors cannot be remapped to RAM, vectors base will be 0x00000000\n");
+	}
+
+	return base;
+}
+#endif /* CONFIG_CPU_HIGH_VECTOR */
+#endif /* CONFIG_CPU_CP15 */
+
 void __init arm_mm_memblock_reserve(void)
 {
 #ifndef CONFIG_CPU_V7M
+	vectors_base = IS_ENABLED(CONFIG_CPU_CP15) ? setup_vectors_base() : 0;
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
@@ -310,7 +358,7 @@ void __init sanity_check_meminfo(void)
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
