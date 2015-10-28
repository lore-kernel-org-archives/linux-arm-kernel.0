From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Wed, 28 Oct 2015 14:43:56 -0700
Subject: [PATCH 2/3] Revert "arm64: don't flag non-aliasing VIPT I-caches as
 aliasing"
In-Reply-To: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <1446068637-11509-3-git-send-email-avanbrunt@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 169c018de7b6d376f821f9fae0ab23dc5c7bb549.

Change-Id: I86627b6328b733d3bb5874832ca1a7543f75efc1
Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
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
