From: rokhanna@nvidia.com (Rohit Khanna)
Date: Tue, 29 May 2018 11:11:28 -0700
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
Message-ID: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current implementation,  __apply_alternatives patches
flush_icache_range and then executes it without invalidating the icache.
Thus, icache can contain some of the old instructions for
flush_icache_range. This can cause unpredictable behavior as during
execution we can get a mix of old and new instructions for
flush_icache_range.

This patch :
1. Adds a new function flush_cache_kernel_range for flushing kernel
memory range. This function uses non hot-patched code and can be
safely used to flush cache during code patching.

2. Modifies __apply_alternatives so that it uses
flush_cache_kernel_range to flush the cache range after patching code.

Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
---
 arch/arm64/kernel/alternative.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4ac381..e93cfd26a314 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,6 +122,33 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }
 
+/* This is used for flushing kernel memory range after
+ * __apply_alternatives has patched kernel code
+ */
+static void flush_cache_kernel_range(void *start, void *end)
+{
+	u64 d_start, i_start, d_size, i_size;
+
+	/* use sanitized value of ctr_el0 rather than raw value from CPU */
+	d_size = 4 << ((arm64_ftr_reg_ctrel0.sys_val >> 0x10) & 0xF); /* bytes */
+	i_size = 4 << (arm64_ftr_reg_ctrel0.sys_val & 0xF); /* bytes */
+
+	d_start = (u64)start & ~(d_size - 1);
+	while (d_start <= (u64)end) {
+		asm volatile("dc civac, %0" : : "r" (d_start));
+		d_start += d_size;
+	}
+	dsb(ish);
+
+	i_start = (u64)start & ~(i_size - 1);
+	while (i_start <= (u64)end) {
+		asm volatile("ic ivau, %0" : : "r" (i_start));
+		i_start += i_size;
+	}
+	dsb(ish);
+	isb();
+}
+
 static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 {
 	struct alt_instr *alt;
@@ -155,8 +182,8 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-		flush_icache_range((uintptr_t)origptr,
-				   (uintptr_t)(origptr + nr_inst));
+		flush_cache_kernel_range((void *)origptr,
+				(void *)(origptr + nr_inst));
 	}
 }
 
-- 
2.1.4
