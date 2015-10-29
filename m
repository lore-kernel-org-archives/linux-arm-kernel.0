From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Thu, 29 Oct 2015 16:20:41 -0700
Subject: [PATCH v2 3/4] Revert "arm64: add helper functions to read I-cache
 attributes"
In-Reply-To: <1446160842-25787-1-git-send-email-avanbrunt@nvidia.com>
References: <1446160842-25787-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <1446160842-25787-3-git-send-email-avanbrunt@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 80c517b0ff71a4c874fed9196fd990d2d9e911f3.

This reverts a patch that attempt to query the CPU for cache geometry. It
relied on NumSets and LineSize fields of CCSIDR to determine the cache geometry. However, the architectural documentation for these registers forbids
such use:
	The parameters NumSets, Associativity, and LineSize in these
	registers define the architecturally visible parameters that are
	required for the cache maintenance by Set/Way instructions. They are
	not guaranteed to represent the actual microarchitectural features
	of a design. You cannot make any inference about the actual sizes of
	caches based on these parameters.

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm64/include/asm/cachetype.h | 20 --------------------
 arch/arm64/kernel/cpuinfo.c        | 14 --------------
 2 files changed, 34 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 4c631a0..7a2e076 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,26 +39,6 @@
 
 extern unsigned long __icache_flags;
 
-#define CCSIDR_EL1_LINESIZE_MASK	0x7
-#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
-
-#define CCSIDR_EL1_NUMSETS_SHIFT	13
-#define CCSIDR_EL1_NUMSETS_MASK		(0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
-#define CCSIDR_EL1_NUMSETS(x) \
-	(((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
-
-extern u64 __attribute_const__ icache_get_ccsidr(void);
-
-static inline int icache_get_linesize(void)
-{
-	return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
-}
-
-static inline int icache_get_numsets(void)
-{
-	return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
-}
-
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index e0c6c8c..ae04ac1 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -21,10 +21,8 @@
 #include <asm/cpufeature.h>
 
 #include <linux/bitops.h>
-#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 
@@ -244,15 +242,3 @@ void __init cpuinfo_store_boot_cpu(void)
 
 	boot_cpu_data = *info;
 }
-
-u64 __attribute_const__ icache_get_ccsidr(void)
-{
-	u64 ccsidr;
-
-	WARN_ON(preemptible());
-
-	/* Select L1 I-cache and read its size ID register */
-	asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
-	    : "=r"(ccsidr) : "r"(1L));
-	return ccsidr;
-}
-- 
2.1.4
