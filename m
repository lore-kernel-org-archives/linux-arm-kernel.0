From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Thu, 29 Oct 2015 16:20:40 -0700
Subject: [PATCH v2 2/4] Revert "arm64: don't flag non-aliasing VIPT I-caches
 as aliasing"
In-Reply-To: <1446160842-25787-1-git-send-email-avanbrunt@nvidia.com>
References: <1446160842-25787-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <1446160842-25787-2-git-send-email-avanbrunt@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 169c018de7b6d376f821f9fae0ab23dc5c7bb549.

The reverted commit attempted to use the cache geometry as reported in
CCSIDR to determine if there can be aliasing in the instruction cache. There
were two problems with this:

1. CCSIDR_EL1 does not report the actual cache geometry. The architectural
   documentation for this register says:
        The parameters NumSets, Associativity, and LineSize in these
	registers define the architecturally visible parameters that are
	required for the cache maintenance by Set/Way instructions. They are
	not guaranteed to represent the actual microarchitectural features
	of a design. You cannot make any inference about the actual sizes
	of caches based on these parameters.

2. The architectural definition of VIPT and PIPT as reported by CTR_EL0 is
   described in terms of the observable behavior rather than the inner
   workings of the cache hardware. The difference in the definition of VIPT
   and PIPT is that VIPT requires invalidating the entire instruction cache
   to avoid aliasing.

   Therefore, even if the cache geometry was known, it is not possible to
   assume that there is no aliasing.

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm64/kernel/cpuinfo.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 540177a..e0c6c8c 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -51,18 +51,8 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	unsigned int cpu = smp_processor_id();
 	u32 l1ip = CTR_L1IP(info->reg_ctr);
 
-	if (l1ip != ICACHE_POLICY_PIPT) {
-		/*
-		 * VIPT caches are non-aliasing if the VA always equals the PA
-		 * in all bit positions that are covered by the index. This is
-		 * the case if the size of a way (# of sets * line size) does
-		 * not exceed PAGE_SIZE.
-		 */
-		u32 waysize = icache_get_numsets() * icache_get_linesize();
-
-		if (l1ip != ICACHE_POLICY_VIPT || waysize > PAGE_SIZE)
-			set_bit(ICACHEF_ALIASING, &__icache_flags);
-	}
+	if (l1ip != ICACHE_POLICY_PIPT)
+		set_bit(ICACHEF_ALIASING, &__icache_flags);
 	if (l1ip == ICACHE_POLICY_AIVIVT)
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 
-- 
2.1.4
