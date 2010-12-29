From: mreimer@sdgsystems.com (Matt Reimer)
Date: Wed, 29 Dec 2010 11:18:29 -0500
Subject: [PATCH] [ARM] pxa: fix page table corruption on resume
In-Reply-To: <4CF6A7F2.80206@sdgsystems.com>
References: <4CF6A7F2.80206@sdgsystems.com>
Message-ID: <1293639509-9373-1-git-send-email-mreimer@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aric D. Blumer <aric@sdgsystems.com>

Before this patch, the following error would sometimes occur after a
resume on pxa3xx:

    /path/to/mm/memory.c:144: bad pmd 8040542e.

The problem was that a temporary page table mapping was being improperly
restored.

The PXA3xx resume code creates a temporary mapping of resume_turn_on_mmu
to avoid a prefetch abort.  The pxa3xx_resume_after_mmu code requires
that the r1 register holding the address of this mapping not be
modified, however, resume_turn_on_mmu does modify it. It is mostly
correct in that r1 receives the base table address, but it may also
get other bits in 13:0.  This results in pxa3xx_resume_after_mmu
restoring the original mapping to the wrong place, corrupting memory
and leaving the temporary mapping in place.

Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
---
 arch/arm/mach-pxa/sleep.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 52c30b0..ae00811 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -353,8 +353,8 @@ resume_turn_on_mmu:
 
 	@ Let us ensure we jump to resume_after_mmu only when the mcr above
 	@ actually took effect.  They call it the "cpwait" operation.
-	mrc	p15, 0, r1, c2, c0, 0		@ queue a dependency on CP15
-	sub	pc, r2, r1, lsr #32		@ jump to virtual addr
+	mrc	p15, 0, r0, c2, c0, 0		@ queue a dependency on CP15
+	sub	pc, r2, r0, lsr #32		@ jump to virtual addr
 	nop
 	nop
 	nop
-- 
1.7.0.4
