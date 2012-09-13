From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Sep 2012 11:20:46 +0100
Subject: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache maintenance ops
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM v7 architecture introduced the concept of cache levels and related
coherency requirements. New processors like A7 and A15 embed an
L2 unified cache controller that becomes part of the cache level
hierarchy. Some operations in the kernel like cpu_suspend and __cpu_disable
does not require a flush of the entire cache hierarchy to DRAM but just the
cache levels belonging to the Level of Unification Inner Shareable (LoUIS),
which in most of ARM v7 systems correspond to L1.

The current cache flushing API used in cpu_suspend and __cpu_disable,
flush_cache_all(), ends up flushing the whole cache hierarchy since for
v7 it cleans and invalidates all cache levels up to Level of Coherency
(LoC) which cripples system performance when used in hot paths like hotplug
and cpuidle.

Therefore a new kernel cache maintenance API must be added to the
cpu_cache_fns structure of pointers to cope with latest ARM system requirements.
This patch adds flush_cache_louis() to the ARM kernel cache maintenance API.

This function cleans and invalidates all data cache levels up to the
level of unification inner shareable (LoUIS) and invalidates the instruction
cache.

The cpu_cache_fns struct reflects this change by adding a new function pointer
that is initialized by arch specific assembly files.

By default, all existing ARM archs do not instantiate any cache LoUIS function
pointer, and flush_dcache_louis just falls back to flush_kern_all.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/cacheflush.h | 17 +++++++++++++++++
 arch/arm/mm/proc-macros.S         |  7 ++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index c6e2ed9..7683316 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -50,6 +50,13 @@
  *
  *		Unconditionally clean and invalidate the entire cache.
  *
+ *     flush_kern_cache_louis()
+ *
+ *             Flush data cache levels up to the level of unification
+ *             inner shareable and invalidate the I-cache.
+ *             Only needed from v7 onwards, falls back to flush_cache_all()
+ *             for all other processor versions.
+ *
  *	flush_user_all()
  *
  *		Clean and invalidate all user space cache entries
@@ -98,6 +105,7 @@
 struct cpu_cache_fns {
 	void (*flush_icache_all)(void);
 	void (*flush_kern_all)(void);
+	void (*flush_kern_cache_louis)(void);
 	void (*flush_user_all)(void);
 	void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
 
@@ -200,6 +208,15 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 #define __flush_icache_preferred	__flush_icache_all_generic
 #endif
 
+/*
+ * Flush caches up to Level of Unification Inner Shareable
+ */
+#ifdef MULTI_CACHE
+#define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
+#else
+#define flush_cache_louis()   __cpuc_flush_kern_all()
+#endif
+
 static inline void __flush_icache_all(void)
 {
 	__flush_icache_preferred();
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..28e91f8 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -293,12 +293,17 @@ ENTRY(\name\()_processor_functions)
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
 .endm
 
-.macro define_cache_functions name:req
+.macro define_cache_functions name:req, cachelouis=0
 	.align 2
 	.type	\name\()_cache_fns, #object
 ENTRY(\name\()_cache_fns)
 	.long	\name\()_flush_icache_all
 	.long	\name\()_flush_kern_cache_all
+	.if \cachelouis
+	.long   \name\()_flush_kern_cache_louis
+	.else
+	.long   \name\()_flush_kern_cache_all
+	.endif
 	.long	\name\()_flush_user_cache_all
 	.long	\name\()_flush_user_cache_range
 	.long	\name\()_coherent_kern_range
-- 
1.7.12
