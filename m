From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  8 Aug 2014 13:51:40 +0200
Subject: [PATCH v4 2/2] arm64: don't flag non-aliasing VIPT I-caches as
 aliasing
In-Reply-To: <1407498700-10164-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407498700-10164-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1407498700-10164-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VIPT caches are non-aliasing if the index is derived from address bits that
are always equal between VA and PA. Classifying these as aliasing results in
unnecessary flushing which may hurt performance.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
v4: de-obfuscate, add Will's ack
v2, v3: no changes

 arch/arm64/kernel/cpuinfo.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d8c5a59a5687..504fdaa8367e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -49,8 +49,18 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	unsigned int cpu = smp_processor_id();
 	u32 l1ip = CTR_L1IP(info->reg_ctr);
 
-	if (l1ip != ICACHE_POLICY_PIPT)
-		set_bit(ICACHEF_ALIASING, &__icache_flags);
+	if (l1ip != ICACHE_POLICY_PIPT) {
+		/*
+		 * VIPT caches are non-aliasing if the VA always equals the PA
+		 * in all bit positions that are covered by the index. This is
+		 * the case if the size of a way (# of sets * line size) does
+		 * not exceed PAGE_SIZE.
+		 */
+		u32 waysize = icache_get_numsets() * icache_get_linesize();
+
+		if (l1ip != ICACHE_POLICY_VIPT || waysize > PAGE_SIZE)
+			set_bit(ICACHEF_ALIASING, &__icache_flags);
+	}
 	if (l1ip == ICACHE_POLICY_AIVIVT)
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 
-- 
1.8.3.2
