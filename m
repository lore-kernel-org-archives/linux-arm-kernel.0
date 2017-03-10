From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:32:22 +0000
Subject: [PATCH 3/6] arm64: cache: Remove support for ASID-tagged VIVT I-caches
In-Reply-To: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
Message-ID: <1489177945-8590-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a recent change to ARMv8, ASID-tagged VIVT I-caches are removed
retrospectively from the architecture. Consequently, we don't need to
support them in Linux either.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cachetype.h | 8 --------
 arch/arm64/include/asm/kvm_mmu.h   | 2 +-
 arch/arm64/kernel/cpufeature.c     | 4 ++--
 arch/arm64/kernel/cpuinfo.c        | 9 +++------
 arch/arm64/mm/context.c            | 3 ---
 arch/arm64/mm/flush.c              | 2 --
 6 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 212a0f3d4ecb..fbab37c669a0 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -23,8 +23,6 @@
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
 
-#define ICACHE_POLICY_RESERVED	0
-#define ICACHE_POLICY_AIVIVT	1
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
@@ -35,7 +33,6 @@
 #define CTR_L1IP(ctr)	(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
 #define ICACHEF_ALIASING	0
-#define ICACHEF_AIVIVT		1
 
 extern unsigned long __icache_flags;
 
@@ -48,11 +45,6 @@ static inline int icache_is_aliasing(void)
 	return test_bit(ICACHEF_ALIASING, &__icache_flags);
 }
 
-static inline int icache_is_aivivt(void)
-{
-	return test_bit(ICACHEF_AIVIVT, &__icache_flags);
-}
-
 static inline u32 cache_type_cwg(void)
 {
 	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ed1246014901..4be5773d4606 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -245,7 +245,7 @@ static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
 	if (!icache_is_aliasing()) {		/* PIPT */
 		flush_icache_range((unsigned long)va,
 				   (unsigned long)va + size);
-	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
+	} else {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e861865..073a6c641730 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -153,9 +153,9 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine.
-	 * If we have differing I-cache policies, report it as the weakest - AIVIVT.
+	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
 };
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 155ddd8ad56a..efe74ecc9738 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -43,10 +43,9 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 
 static char *icache_policy_str[] = {
-	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
-	[ICACHE_POLICY_AIVIVT] = "AIVIVT",
-	[ICACHE_POLICY_VIPT] = "VIPT",
-	[ICACHE_POLICY_PIPT] = "PIPT",
+	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_VIPT]		= "VIPT",
+	[ICACHE_POLICY_PIPT]		= "PIPT",
 };
 
 unsigned long __icache_flags;
@@ -293,8 +292,6 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	case ICACHE_POLICY_PIPT:
 		break;
 	default:
-	case ICACHE_POLICY_AIVIVT:
-		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 		/* Fallthrough */
 	case ICACHE_POLICY_VIPT:
 		/* Assume aliasing */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 68634c630cdd..ab9f5f0fb2c7 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -119,9 +119,6 @@ static void flush_context(unsigned int cpu)
 
 	/* Queue a TLB invalidate and flush the I-cache if necessary. */
 	cpumask_setall(&tlb_flush_pending);
-
-	if (icache_is_aivivt())
-		__flush_icache_all();
 }
 
 static bool check_update_reserved_asid(u64 asid, u64 newasid)
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 554a2558c12e..1e968222a544 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -65,8 +65,6 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
 		sync_icache_aliases(page_address(page),
 				    PAGE_SIZE << compound_order(page));
-	else if (icache_is_aivivt())
-		__flush_icache_all();
 }
 
 /*
-- 
2.1.4
