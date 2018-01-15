From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Mon, 15 Jan 2018 15:23:48 +0000
Subject: [PATCH 1/3] arm64: fix ID map extension to 52 bits
In-Reply-To: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
References: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1516029830-12326-2-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fa2a8445b1d3 added support for extending the ID map to 52 bits,
but accidentally dropped a required change to __cpu_uses_extended_idmap.
As a result, the kernel fails to boot when VA_BITS = 48 and the ID map
text is in 52-bit physical memory, because we reduce TCR.T0SZ to cover
the ID map, but then never set it back to VA_BITS.

Add back the change, and also clean up some double parentheses.

Fixes: fa2a8445b1d3 ("arm64: allow ID map to be extended to 52 bits")
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 8f80fcb49252..5aee19905556 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,8 +72,7 @@ extern u64 idmap_ptrs_per_pgd;
 
 static inline bool __cpu_uses_extended_idmap(void)
 {
-	return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
-		unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
+	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
 }
 
 /*
@@ -82,7 +81,7 @@ static inline bool __cpu_uses_extended_idmap(void)
  */
 static inline bool __cpu_uses_extended_idmap_level(void)
 {
-	return ARM64_HW_PGTABLE_LEVELS((64 - idmap_t0sz)) > CONFIG_PGTABLE_LEVELS;
+	return ARM64_HW_PGTABLE_LEVELS(64 - idmap_t0sz) > CONFIG_PGTABLE_LEVELS;
 }
 
 /*
-- 
2.1.4
