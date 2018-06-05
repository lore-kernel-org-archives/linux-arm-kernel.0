From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Jun 2018 17:55:12 +0100
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1528140881044.41145@nvidia.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
 <20180530090044.GA2452@arm.com> <1527788750049.85185@nvidia.com>
 <20180604091609.GD9482@arm.com> <1528140881044.41145@nvidia.com>
Message-ID: <20180605165511.GB2193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Mon, Jun 04, 2018 at 07:34:10PM +0000, Alexander Van Brunt wrote:
> __flush_icache_all all cache is slow in large systems. It flushes the
> instruction caches cache in the inner-shareable domain. That includes
> other NUMA nodes in multi-socket systems. The CPU issuing the invalidate
> has to wait for all of the other CPUs to complete the invalidate
> instruction. The remote CPU's responding to the request all need to slow
> down.
> 
> In contrast, flushes by range can be checked in a snoop filter to see if
> the addresses are relevant to the CPU. So, it scales to systems with more
> than two clusters much better.
> 
> The flush ignores the VMID. So, one guest OS can slow down others. That
> creates a big covert channel between guests unless the hypervisor traps
> and emulates it by invalidating an entire VMID. By flushing by VA range,
> the hardware only flushes lines associated with the VMID, ASID, and VA
> associated with the line.
> 
> Selfishly, NVIDIA's Denver CPU's are even more sensitive because the
> optimized code stored in DRAM is effectively a very large (on the order of
> 64 MB) instruction cache. "ic ialluis" can result in the entire
> optimization cache for all guests to be invalidated.
> 
> I am aware that the arguments I made apply to TLB invalidates and the
> other places that Linux calls __flush_icache_all. But, that doesn't mean I
> don't like those either. For now, I just don't want more calls to
> __flush_icache_all.

Sure, but there are only two cases to consider here:

1. Boot. This happens once, and we end up putting *all* secondary cores into
   a tight loop anyway, so I don't see that the performance of
   __flush_icache_all is relevant

2. On module load. This happens right before we start remapping the module
   areas and sending out TLB invalidation so, again, not sure I see why this
   is such a big deal. In fact, it looks like the core module loading code
   does invalidation by range, so if we remove it from __apply_alternatives
   then we can avoid doing it twice.

In other words, something like the diff below.

Will

--->8

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index a91933b1e2e6..934f99215bd4 100644
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
+void apply_alternatives_module(void *start, size_t length) { }
+#endif
 
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 9bbffc7a301f..627d62ff2ddd 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -21,6 +21,7 @@
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
 #define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIFT	0
 #define CTR_ERG_SHIFT		20
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4ac381..6c813f58824b 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,7 +122,29 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }
 
-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+static void clean_dcache_range_nopatch(u64 start, u64 end)
+{
+	u64 cur, d_size, i_size, ctr_el0;
+
+	/* use sanitised value of ctr_el0 rather than raw value from CPU */
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	/* size in bytes */
+	d_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+			CTR_DMINLINE_SHIFT);
+	i_size = 4 << cpuid_feature_extract_unsigned_field(ctr_el0,
+			CTR_IMINLINE_SHIFT);
+
+	cur = start & ~(d_size - 1);
+	do {
+		/*
+		 * We must clean+invalidate in order to avoid Cortex-A53
+		 * errata 826319, 827319, 824069 and 819472.
+		 */
+		asm volatile("dc civac, %0" : : "r" (cur) : "memory");
+	} while (cur += d_size, cur < end);
+}
+
+static void __apply_alternatives(void *alt_region, bool is_module)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -145,7 +167,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 		pr_info_once("patching kernel code\n");
 
 		origptr = ALT_ORIG_PTR(alt);
-		updptr = use_linear_alias ? lm_alias(origptr) : origptr;
+		updptr = is_module ? origptr : lm_alias(origptr);
 		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
 		if (alt->cpufeature < ARM64_CB_PATCH)
@@ -155,9 +177,23 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
-		flush_icache_range((uintptr_t)origptr,
-				   (uintptr_t)(origptr + nr_inst));
+		if (is_module)
+			continue;
+
+		clean_dcache_range_nopatch((u64)origptr,
+					   (u64)(origptr + nr_inst));
 	}
+
+	/*
+	 * The core module code takes care of cache maintenance in
+	 * flush_module_icache().
+	 */
+	if (is_module)
+		return;
+
+	dsb(ish);
+	__flush_icache_all();
+	isb();
 }
 
 /*
@@ -178,7 +214,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(alternatives_applied);
-		__apply_alternatives(&region, true);
+		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(alternatives_applied, 1);
 	}
@@ -192,12 +228,14 @@ void __init apply_alternatives_all(void)
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
