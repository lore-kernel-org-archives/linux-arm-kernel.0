From: matthew.leach@arm.com (Matthew Leach)
Date: Wed,  5 Sep 2012 12:35:34 +0100
Subject: [PATCH] ARM: decompressor: reset SCTLR.TRE for VMSA ARMv7 cores
Message-ID: <1346844934-30518-1-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch zeroes the SCTLR.TRE prior to setting the mapping as
cacheable for ARMv7 cores in the decompressor, ensuring that the
memory region attributes are obtained from the C and B bits, not from
the page tables.

Cc: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm/boot/compressed/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 81769c1..e8d3f7f 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -653,6 +653,7 @@ __armv7_mmu_cache_on:
 		mcrne	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
 #endif
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
+		bic	r0, r0, #1 << 28	@ clear the SCTLR.TRE
 		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
 		orr	r0, r0, #0x003c		@ write buffer
 #ifdef CONFIG_MMU
-- 
1.7.12
