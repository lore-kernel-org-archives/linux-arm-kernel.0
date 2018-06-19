From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 13:48:13 +0100
Subject: [PATCH 1/3] arm64: Avoid flush_icache_range() in alternatives
 patching code
In-Reply-To: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
Message-ID: <1529412495-17525-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of flush_icache_range() includes instruction sequences
which are themselves patched at runtime, so it is not safe to call from
the patching framework.

This patch reworks the alternatives cache-flushing code so that it rolls
its own internal D-cache maintenance using DC CIVAC before invalidating
the entire I-cache after all alternatives have been applied at boot.
Modules don't cause any issues, since flush_icache_range() is safe to
call by the time they are loaded.

Reported-by: Rohit Khanna <rokhanna@nvidia.com>
Cc: Alexander Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/alternative.h |  7 +++++-
 arch/arm64/kernel/alternative.c      | 46 ++++++++++++++++++++++++++++++------
 arch/arm64/kernel/module.c           |  5 ++--
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index a91933b1e2e6..4b650ec1d7dd 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -28,7 +28,12 @@ typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
 void __init apply_alternatives_all(void);
-void apply_alternatives(void *start, size_t length);
+
+#ifdef CONFIG_MODULES
+void apply_alternatives_module(void *start, size_t length);
+#else
+static inline void apply_alternatives_module(void *start, size_t length) { }
+#endif
 
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4ac381..4f3dcc15a5b2 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,7 +122,25 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }
 
-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+static void clean_dcache_range_nopatch(u64 start, u64 end)
+{
+	u64 cur, d_size, ctr_el0;
+
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	d_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+							   CTR_DMINLINE_SHIFT);
+	cur = start & ~(d_size - 1);
+	do {
+		/*
+		 * We must clean+invalidate to the PoC in order to avoid
+		 * Cortex-A53 errata 826319, 827319, 824069 and 819472
+		 * (this corresponds to ARM64_WORKAROUND_CLEAN_CACHE)
+		 */
+		asm volatile("dc civac, %0" : : "r" (cur) : "memory");
+	} while (cur += d_size, cur < end);
+}
+
+static void __apply_alternatives(void *alt_region, bool is_module)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -145,7 +163,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 		pr_info_once("patching kernel code\n");
 
 		origptr = ALT_ORIG_PTR(alt);
-		updptr = use_linear_alias ? lm_alias(origptr) : origptr;
+		updptr = is_module ? origptr : lm_alias(origptr);
 		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
 		if (alt->cpufeature < ARM64_CB_PATCH)
@@ -155,8 +173,20 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-		flush_icache_range((uintptr_t)origptr,
-				   (uintptr_t)(origptr + nr_inst));
+		if (!is_module) {
+			clean_dcache_range_nopatch((u64)origptr,
+						   (u64)(origptr + nr_inst));
+		}
+	}
+
+	/*
+	 * The core module code takes care of cache maintenance in
+	 * flush_module_icache().
+	 */
+	if (!is_module) {
+		dsb(ish);
+		__flush_icache_all();
+		isb();
 	}
 }
 
@@ -178,7 +208,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(alternatives_applied);
-		__apply_alternatives(&region, true);
+		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(alternatives_applied, 1);
 	}
@@ -192,12 +222,14 @@ void __init apply_alternatives_all(void)
 	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
 }
 
-void apply_alternatives(void *start, size_t length)
+#ifdef CONFIG_MODULES
+void apply_alternatives_module(void *start, size_t length)
 {
 	struct alt_region region = {
 		.begin	= start,
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region, false);
+	__apply_alternatives(&region, true);
 }
+#endif
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 155fd91e78f4..f0f27aeefb73 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -448,9 +448,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
-		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0) {
-			apply_alternatives((void *)s->sh_addr, s->sh_size);
-		}
+		if (strcmp(".altinstructions", secstrs + s->sh_name) == 0)
+			apply_alternatives_module((void *)s->sh_addr, s->sh_size);
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
-- 
2.1.4
