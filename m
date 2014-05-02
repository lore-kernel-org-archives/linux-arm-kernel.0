From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  2 May 2014 16:55:32 +0100
Subject: [PATCH] arm64: Implement cache_line_size() based on CTR_EL0.CWG
Message-ID: <1399046132-5760-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware provides the maximum cache line size in the system via the
CTR_EL0.CWG bits. This patch implements the cache_line_size() function
to read such information, together with a sanity check if the statically
defined L1_CACHE_BYTES is smaller than the hardware value.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                 |  3 +++
 arch/arm64/include/asm/cache.h     | 13 ++++++++++++-
 arch/arm64/include/asm/cachetype.h | 11 +++++++++++
 arch/arm64/kernel/setup.c          | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e759af5d7098..9a5b5fea86ba 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -242,6 +242,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
 
+config ARCH_HAS_CACHE_LINE_SIZE
+	def_bool y
+
 source "mm/Kconfig"
 
 config XEN_DOM0
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 390308a67f0d..88cc05b5f3ac 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_CACHE_H
 #define __ASM_CACHE_H
 
+#include <asm/cachetype.h>
+
 #define L1_CACHE_SHIFT		6
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
@@ -27,6 +29,15 @@
  * the CPU.
  */
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
-#define ARCH_SLAB_MINALIGN	8
+
+#ifndef __ASSEMBLY__
+
+static inline int cache_line_size(void)
+{
+	u32 cwg = cache_type_cwg();
+	return cwg ? 4 << cwg : L1_CACHE_BYTES;
+}
+
+#endif	/* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 85f5f511352a..4b23e758d5e0 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -20,12 +20,16 @@
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
+#define CTR_CWG_SHIFT		24
+#define CTR_CWG_MASK		15
 
 #define ICACHE_POLICY_RESERVED	0
 #define ICACHE_POLICY_AIVIVT	1
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
+#ifndef __ASSEMBLY__
+
 static inline u32 icache_policy(void)
 {
 	return (read_cpuid_cachetype() >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK;
@@ -45,4 +49,11 @@ static inline int icache_is_aivivt(void)
 	return icache_policy() == ICACHE_POLICY_AIVIVT;
 }
 
+static inline u32 cache_type_cwg(void)
+{
+	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
+}
+
+#endif	/* __ASSEMBLY__ */
+
 #endif	/* __ASM_CACHETYPE_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7ec784653b29..5b9e046d580e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/utsname.h>
 #include <linux/initrd.h>
 #include <linux/console.h>
+#include <linux/cache.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/screen_info.h>
@@ -198,6 +199,8 @@ static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
 	u64 features, block;
+	u32 cwg;
+	int cls;
 
 	cpu_info = lookup_processor_type(read_cpuid_id());
 	if (!cpu_info) {
@@ -215,6 +218,18 @@ static void __init setup_processor(void)
 	elf_hwcap = 0;
 
 	/*
+	 * Check for sane CTR_EL0.CWG value.
+	 */
+	cwg = cache_type_cwg();
+	cls = cache_line_size();
+	if (!cwg)
+		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
+			cls);
+	if (L1_CACHE_BYTES < cls)
+		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
+			L1_CACHE_BYTES, cls);
+
+	/*
 	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
 	 * The blocks we test below represent incremental functionality
 	 * for non-negative values. Negative values are reserved.
