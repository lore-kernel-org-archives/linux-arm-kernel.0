From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2012 16:31:06 +0000
Subject: [PATCH] ARM: proc-v7.S: remove HARVARD_CACHE preprocessor guards
Message-ID: <1326990666-10159-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On v7, we use the same cache maintenance instructions for data lines
as for unified lines. This was not the case for v6, where HARVARD_CACHE
was defined to indicate the L1 cache topology.

This patch removes the erroneous compile-time check for HARVARD_CACHE in
proc-v7.S, ensuring that we perform I-side invalidation at boot.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Catalin Marinas <Catalin.Marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This is based on the original patch from Shawn posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/079235.html

However, it seems like that thread died so I've picked it up.

 arch/arm/mm/proc-v7.S |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b155974..0404ccb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -148,10 +148,6 @@ ENDPROC(cpu_v7_do_resume)
  *	Initialise TLB, Caches, and MMU state ready to switch the MMU
  *	on.  Return in r0 the new CP15 C1 control register setting.
  *
- *	We automatically detect if we have a Harvard cache, and use the
- *	Harvard cache control instructions insead of the unified cache
- *	control instructions.
- *
  *	This should be able to cover all ARMv7 cores.
  *
  *	It is assumed that:
@@ -251,9 +247,7 @@ __v7_setup:
 #endif
 
 3:	mov	r10, #0
-#ifdef HARVARD_CACHE
 	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
-#endif
 	dsb
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
-- 
1.7.4.1
