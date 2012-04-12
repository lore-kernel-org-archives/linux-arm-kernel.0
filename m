From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Apr 2012 14:08:29 +0100
Subject: [RFC PATCH 1/3] ARM: mm: define cache levels for cache maintenance ops
In-Reply-To: <1334236111-28144-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1334236111-28144-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1334236111-28144-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM v7 architecture introduced the concept of cache levels and related
coherency requirements. In order to select which cache levels must be
cleaned and invalidated, a new kernel cache maintenance API must be
added to the cpu_cache_fns structure of pointers.

This patch adds flush_dcache_level(level) to the ARM kernel cache
maintenance API.

This function cleans and invalidates all data cache levels up to the one
passed as an input parameter.

The cpu_cache_fns struct reflects this change by adding a new function
pointer that is initialized by arch specific assembly files.

The preferred cached level to be cleaned/invalidated can be retrieved
using the function call:

flush_cache_level_cpu(void)

By default, this function returns -1 which causes all cache levels to
be cleaned and invalidated to main memory.

Architectures can override the cache level returned by default by
patching/defining the preferred cache level hook for the arch in
question.

By default, all existing archs do not instantiate any cache level function
pointer, and flush_dcache_level just falls back to flush_kern_all.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Colin Cross <ccross@android.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/include/asm/cacheflush.h |   22 ++++++++++++++++++++++
 arch/arm/mm/proc-macros.S         |    7 ++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 1252a26..741ae25 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -49,6 +49,10 @@
  *
  *		Unconditionally clean and invalidate the entire cache.
  *
+ *	flush_kern_dcache_level(level)
+ *
+ *		Flush data cache levels up to the level input parameter.
+ *
  *	flush_user_all()
  *
  *		Clean and invalidate all user space cache entries
@@ -97,6 +101,7 @@
 struct cpu_cache_fns {
 	void (*flush_icache_all)(void);
 	void (*flush_kern_all)(void);
+	void (*flush_kern_dcache_level)(int);
 	void (*flush_user_all)(void);
 	void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
 
@@ -199,6 +204,23 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 #define __flush_icache_preferred	__flush_icache_all_generic
 #endif
 
+#define flush_cache_level_preferred()		(-1)
+
+static inline int flush_cache_level_cpu(void)
+{
+	return flush_cache_level_preferred();
+}
+/*
+ * Flush data cache up to a certain cache level
+ * level -	upper cache level to clean
+ *		if level == -1, default to flush_kern_all
+ */
+#ifdef MULTI_CACHE
+#define flush_dcache_level(level)	cpu_cache.flush_kern_dcache_level(level)
+#else
+#define flush_dcache_level(level)	__cpuc_flush_kern_all()
+#endif
+
 static inline void __flush_icache_all(void)
 {
 	__flush_icache_preferred();
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..f193bc3 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -293,12 +293,17 @@ ENTRY(\name\()_processor_functions)
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
 .endm
 
-.macro define_cache_functions name:req
+.macro define_cache_functions name:req, cachelevel=0
 	.align 2
 	.type	\name\()_cache_fns, #object
 ENTRY(\name\()_cache_fns)
 	.long	\name\()_flush_icache_all
 	.long	\name\()_flush_kern_cache_all
+	.if \cachelevel
+	.long	\name\()_flush_kern_dcache_level
+	.else
+	.long	\name\()_flush_kern_cache_all
+	.endif
 	.long	\name\()_flush_user_cache_all
 	.long	\name\()_flush_user_cache_range
 	.long	\name\()_coherent_kern_range
-- 
1.7.9.5
