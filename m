From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  6 Aug 2014 17:46:06 +0200
Subject: [PATCH v3 2/2] arm64: don't flag non-aliasing VIPT I-caches as
 aliasing
In-Reply-To: <1407339966-29351-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407339966-29351-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1407339966-29351-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VIPT caches are non-aliasing if the index is derived from address bits that
are always equal between VA and PA. Classifying these as aliasing results in
unnecessary flushing which may hurt performance.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2, v3: no changes

 arch/arm64/kernel/cpuinfo.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 319255ff536d..a5b6dce48094 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -49,7 +49,13 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	unsigned int cpu = smp_processor_id();
 	u32 l1ip = CTR_L1IP(info->reg_ctr);
 
-	if (l1ip != ICACHE_POLICY_PIPT)
+	/*
+	 * VIPT caches are non-aliasing if the VA always equals the PA in all
+	 * bit positions that are covered by the index, i.e., if num_sets_shift
+	 * is less than or equal to PAGE_SHIFT minus line_size_shift.
+	 */
+	if (l1ip != ICACHE_POLICY_PIPT && !(l1ip == ICACHE_POLICY_VIPT &&
+	    icache_get_linesize() * icache_get_numsets() <= PAGE_SIZE))
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
 	if (l1ip == ICACHE_POLICY_AIVIVT);
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
-- 
1.8.3.2
