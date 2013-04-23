From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Apr 2013 17:03:06 -0400 (EDT)
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <20130423200429.GF5316@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <20130423200429.GF5316@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304231657150.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:

> What I suggest for the time being is to provide new inline function(s)
> in arch/arm/include/cacheflush.h which are purposed for your application,
> document them in that file, and call the implementation you're currently
> using.  That means if we do have to change it in the future (for example,
> we don't need to do anything in the dcache flushing stuff) we don't have
> to hunt through all the code to find _your_ different use of that function
> and fix it - we can just fix it in one place and we have the reference
> there for what your code expects.

What about the patch below?  Once you tell me it is fine to you I'll 
adapt the MCPM series to it.

----- >8
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Tue, 23 Apr 2013 16:45:40 -0400
Subject: [PATCH] ARM: cacheflush: add synchronization helpers for mixed cache state accesses

Algorithms used by the MCPM layer rely on state variables which are
accessed while the cache is either active or inactive, depending
on the code path and the active state.

This patch introduces generic cache maintenance helpers to provide the
necessary cache synchronization for such state variables to always hit
main memory in a ordered way.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index e1489c54cd..bff71388e7 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -363,4 +363,79 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 		flush_cache_all();
 }
 
+/*
+ * Memory synchronization helpers for mixed cached vs non cached accesses.
+ *
+ * Some synchronization algorithms have to set states in memory with the
+ * cache enabled or disabled depending on the code path.  It is crucial
+ * to always ensure proper cache maintenance to update main memory right
+ * away in that case.
+ *
+ * Any cached write must be followed by a cache clean operation.
+ * Any cached read must be preceded by a cache invalidate operation.
+ * Yet, in the read case, a cache flush i.e. atomic clean+invalidate
+ * operation is needed to avoid discarding possible concurrent writes to the
+ * accessed memory.
+ *
+ * Also, in order to prevent a cached writer from interfering with an
+ * adjacent non-cached writer, each state variable must be located to
+ * a separate cache line.
+ */
+
+/*
+ * This needs to be >= the max cache writeback size of all
+ * supported platforms included in the current kernel configuration.
+ * This is used to align state variables to their own cache lines.
+ */
+#define __CACHE_WRITEBACK_ORDER 6  /* guessed from existing platforms */
+#define __CACHE_WRITEBACK_GRANULE (1 << __CACHE_WRITEBACK_ORDER)
+
+/*
+ * There is no __cpuc_clean_dcache_area but we use it anyway for
+ * code intent clarity, and alias it to __cpuc_flush_dcache_area.
+ */
+#define __cpuc_clean_dcache_area __cpuc_flush_dcache_area
+
+/*
+ * Ensure preceding writes to *p by this CPU are visible to
+ * subsequent reads by other CPUs:
+ */
+static inline void __sync_cache_range_w(volatile void *p, size_t size)
+{
+	char *_p = (char *)p;
+
+	__cpuc_clean_dcache_area(_p, size);
+	outer_clean_range(__pa(_p), __pa(_p + size));
+}
+
+/*
+ * Ensure preceding writes to *p by other CPUs are visible to
+ * subsequent reads by this CPU.  We must be careful not to
+ * discard data simultaneously written by another CPU, hence the
+ * usage of flush rather than invalidate operations.
+ */
+static inline void __sync_cache_range_r(volatile void *p, size_t size)
+{
+	char *_p = (char *)p;
+
+#ifdef CONFIG_OUTER_CACHE
+	if (outer_cache.flush_range) {
+		/*
+		 * Ensure dirty data migrated from other CPUs into our cache
+		 * are cleaned out safely before the outer cache is cleaned:
+		 */
+		__cpuc_clean_dcache_area(_p, size);
+
+		/* Clean and invalidate stale data for *p from outer ... */
+		outer_flush_range(__pa(_p), __pa(_p + size));
+	}
+#endif
+
+	/* ... and inner cache: */
+	__cpuc_flush_dcache_area(_p, size);
+}
+
+#define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
+#define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
+
 #endif
