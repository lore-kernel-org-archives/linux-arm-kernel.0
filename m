From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Tue,  8 Sep 2015 22:25:49 +0200
Subject: [PATCH] ARM,
 ARM64: Un-inlined and exported symbols of is_hyp_mode_available() and
 related functions
Message-ID: <1441743949-24480-1-git-send-email-ralf@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hypervisors may be available as modules, but need to check if
HYP mode is enabled. Functions are provided for these means, but
are not exported to modules; in particular since __boot_cpu_mode
is not accessible.

Instead of exporting symbol __boot_cpu_mode, un-inline
is_hyp_mode_available() and related functions. This has no negative
impact since they are never called in hot paths.

Though all modified files are licensed under GPLv2, for ARM we use
EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL to be consistent with the
rest of the exports in arch/arm/kernel/setup.c.

Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
---
 arch/arm/include/asm/virt.h   | 21 +++------------------
 arch/arm/kernel/setup.c       | 29 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/virt.h | 11 ++---------
 arch/arm64/kernel/setup.c     | 14 ++++++++++++++
 4 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 4371f45..37d970d 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -42,15 +42,7 @@
  */
 extern int __boot_cpu_mode;
 
-static inline void sync_boot_mode(void)
-{
-	/*
-	 * As secondaries write to __boot_cpu_mode with caches disabled, we
-	 * must flush the corresponding cache entries to ensure the visibility
-	 * of their writes.
-	 */
-	sync_cache_r(&__boot_cpu_mode);
-}
+void sync_boot_mode(void);
 
 void __hyp_set_vectors(unsigned long phys_vector_base);
 unsigned long __hyp_get_vectors(void);
@@ -63,17 +55,10 @@ unsigned long __hyp_get_vectors(void);
 void hyp_mode_check(void);
 
 /* Reports the availability of HYP mode */
-static inline bool is_hyp_mode_available(void)
-{
-	return ((__boot_cpu_mode & MODE_MASK) == HYP_MODE &&
-		!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH));
-}
+bool is_hyp_mode_available(void);
 
 /* Check if the bootloader has booted CPUs in different modes */
-static inline bool is_hyp_mode_mismatched(void)
-{
-	return !!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH);
-}
+bool is_hyp_mode_mismatched(void);
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd34..c2c39f1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -915,6 +915,35 @@ static void __init reserve_crashkernel(void)
 static inline void reserve_crashkernel(void) {}
 #endif /* CONFIG_KEXEC */
 
+#ifdef CONFIG_ARM_VIRT_EXT
+void sync_boot_mode(void)
+{
+	/*
+	* As secondaries write to __boot_cpu_mode with caches disabled, we
+	* must flush the corresponding cache entries to ensure the visibility
+	* of their writes.
+	*/
+	sync_cache_r(&__boot_cpu_mode);
+}
+#endif
+
+#ifndef ZIMAGE
+/* Reports the availability of HYP mode */
+bool is_hyp_mode_available(void)
+{
+	return ((__boot_cpu_mode & MODE_MASK) == HYP_MODE &&
+		!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH));
+}
+EXPORT_SYMBOL(is_hyp_mode_available);
+
+/* Check if the bootloader has booted CPUs in different modes */
+bool is_hyp_mode_mismatched(void)
+{
+	return !!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH);
+}
+EXPORT_SYMBOL(is_hyp_mode_mismatched);
+#endif
+
 void __init hyp_mode_check(void)
 {
 #ifdef CONFIG_ARM_VIRT_EXT
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7a5df52..48c6170 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -38,17 +38,10 @@ void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);
 
 /* Reports the availability of HYP mode */
-static inline bool is_hyp_mode_available(void)
-{
-	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
-		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
-}
+bool is_hyp_mode_available(void);
 
 /* Check if the bootloader has booted CPUs in different modes */
-static inline bool is_hyp_mode_mismatched(void)
-{
-	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
-}
+bool is_hyp_mode_mismatched(void);
 
 /* The section containing the hypervisor text */
 extern char __hyp_text_start[];
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 8884788..cd29b34 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -62,6 +62,7 @@
 #include <asm/traps.h>
 #include <asm/memblock.h>
 #include <asm/efi.h>
+#include <asm/virt.h>
 #include <asm/xen/hypervisor.h>
 
 unsigned long elf_hwcap __read_mostly;
@@ -195,6 +196,19 @@ static void __init smp_build_mpidr_hash(void)
 	__flush_dcache_area(&mpidr_hash, sizeof(struct mpidr_hash));
 }
 
+bool is_hyp_mode_available(void)
+{
+	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
+		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
+}
+EXPORT_SYMBOL_GPL(is_hyp_mode_available);
+
+bool is_hyp_mode_mismatched(void)
+{
+	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
+}
+EXPORT_SYMBOL_GPL(is_hyp_mode_mismatched);
+
 static void __init setup_processor(void)
 {
 	u64 features;
-- 
2.5.1
