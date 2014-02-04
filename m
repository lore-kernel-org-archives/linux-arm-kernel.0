From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 12:28:22 +0000
Subject: [PATCH] ARM: mm: ensure TLB invalidation is complete before enabling
 MMU
Message-ID: <1391516902-14413-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During __v{6,7}_setup, we invalidate the TLBs since we are about to
enable the MMU on return to head.S. Unfortunately, without a subsequent
dsb instruction, the invalidation is not guaranteed to have completed by
the time we write to the sctlr, potentially exposing us to junk/stale
translations cached in the TLB.

This patch reworks the init functions so that the dsb used to ensure
completion of cache/predictor maintenance is also used to ensure
completion of the TLB invalidation.

Cc: <stable@vger.kernel.org>
Reported-by: Albin Tonnerre <Albin.Tonnerre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v6.S | 3 ++-
 arch/arm/mm/proc-v7.S | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 45dc29f85d56..32b3558321c4 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -208,7 +208,6 @@ __v6_setup:
 	mcr	p15, 0, r0, c7, c14, 0		@ clean+invalidate D cache
 	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
 	mcr	p15, 0, r0, c7, c15, 0		@ clean+invalidate cache
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r0, c2, c0, 2		@ TTB control register
@@ -218,6 +217,8 @@ __v6_setup:
 	ALT_UP(orr	r8, r8, #TTB_FLAGS_UP)
 	mcr	p15, 0, r8, c2, c0, 1		@ load TTB1
 #endif /* CONFIG_MMU */
+	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer and
+						@ complete invalidations
 	adr	r5, v6_crval
 	ldmia	r5, {r5, r6}
  ARM_BE8(orr	r6, r6, #1 << 25)		@ big-endian page tables
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index bd1781979a39..74f6033e76dd 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -351,7 +351,6 @@ __v7_setup:
 
 4:	mov	r10, #0
 	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
-	dsb
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
 	v7_ttb_setup r10, r4, r8, r5		@ TTBCR, TTBRx setup
@@ -360,6 +359,7 @@ __v7_setup:
 	mcr	p15, 0, r5, c10, c2, 0		@ write PRRR
 	mcr	p15, 0, r6, c10, c2, 1		@ write NMRR
 #endif
+	dsb					@ Complete invalidations
 #ifndef CONFIG_ARM_THUMBEE
 	mrc	p15, 0, r0, c0, c1, 0		@ read ID_PFR0 for ThumbEE
 	and	r0, r0, #(0xf << 12)		@ ThumbEE enabled field
-- 
1.8.2.2
