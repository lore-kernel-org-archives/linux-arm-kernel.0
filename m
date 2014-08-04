From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Aug 2014 10:16:56 +0200
Subject: [PATCH 3/3] arm64: don't flag non-aliasing VIPT I-caches as aliasing
In-Reply-To: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1407140216-22747-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VIPT caches are non-aliasing if the index is derived from address bits that
are always equal between VA and PA. Classifying these as aliasing results in
unnecessary flushing which may hurt performance.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cpuinfo.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 744fad2ff418..b780acc201ad 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -47,7 +47,13 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
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
 	if (l1ip == ICACHE_POLICY_AIVIVT)
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
-- 
1.8.3.2
