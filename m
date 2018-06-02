From: rokhanna@nvidia.com (Rohit Khanna)
Date: Fri, 1 Jun 2018 17:41:11 -0700
Subject: [PATCH V5] arm64: alternative:flush cache with unpatched code
Message-ID: <1527900071-10372-1-git-send-email-rokhanna@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current implementation,  __apply_alternatives patches
flush_icache_range and then executes it without invalidating the icache.
Thus, icache can contain some of the old instructions for
flush_icache_range. This can cause unpredictable behavior as during
execution we can get a mix of old and new instructions for
flush_icache_range.

This patch :

1. Adds a new function clean_dcache_range_nopatch for flushing kernel
   memory range. This function uses non hot-patched code and can be
   safely used to flush cache during code patching.

2. Modifies __apply_alternatives so that it uses
   clean_dcache_range_nopatch to flush the cache range after patching code.

Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
---
 arch/arm64/include/asm/cache.h  |  1 +
 arch/arm64/kernel/alternative.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5df5cfe1c143..9211ecd85b15 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -21,6 +21,7 @@
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
 #define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIT	0
 #define CTR_ERG_SHIFT		20
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4ac381..da5815807aeb 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,6 +122,41 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }
 
+/* This is used for flushing kernel memory range after
+ * __apply_alternatives has patched kernel code
+ */
+static void clean_dcache_range_nopatch(void *start, void *end)
+{
+	u64 cur, d_size, i_size, ctr_el0;
+
+	/* use sanitised value of ctr_el0 rather than raw value from CPU */
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	/* size in bytes */
+	d_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+			CTR_DMINLINE_SHIFT);
+	i_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+			CTR_IMINLINE_SHIT);
+
+	cur = (u64)start & ~(d_size - 1);
+	/* Ensure compiler doesn't reorder this against patching code */
+	barrier();
+	do {
+		/* Use civac instead of cvau. This is required
+		 * due to ARM errata 826319, 827319, 824069,
+		 * 819472 on A53
+		 */
+		asm volatile("dc civac, %0" : : "r" (cur));
+	} while (cur += d_size, cur < (u64)end);
+	dsb(ish);
+
+	cur = (u64)start & ~(i_size - 1);
+	do {
+		asm volatile("ic ivau, %0" : : "r" (cur));
+	} while (cur += i_size, cur < (u64)end);
+	dsb(ish);
+	isb();
+}
+
 static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 {
 	struct alt_instr *alt;
@@ -155,7 +190,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-		flush_icache_range((uintptr_t)origptr,
+		clean_dcache_range_nopatch((uintptr_t)origptr,
 				   (uintptr_t)(origptr + nr_inst));
 	}
 }
-- 
2.1.4
