From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  9 Oct 2013 00:34:39 +0200
Subject: [PATCH 23/23] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1381271679-27804-24-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

In order for ASID macro to be used as expression passed to
inline asm as 'r' operand it needs to give 32 bit unsigned result,
not unsigned 64bit expression.

Otherwise when 64bit ASID is passed to inline assembler statement
as 'r' operand (32bit) compiler behavior is not well specified.
For example when __flush_tlb_mm function compiled in big endian
case, and ASID is passed to tlb_op macro directly, 0 will be passed
as 'mcr	15, 0, r4, cr8, cr3, {2}' argument in r4, unless ASID
macro changed to produce 32 bit result.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 6f18da0..64fd151 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -16,7 +16,7 @@ typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 #define ASID_BITS	8
 #define ASID_MASK	((~0ULL) << ASID_BITS)
-#define ASID(mm)	((mm)->context.id.counter & ~ASID_MASK)
+#define ASID(mm)	((unsigned int)((mm)->context.id.counter & ~ASID_MASK))
 #else
 #define ASID(mm)	(0)
 #endif
-- 
1.8.4.rc3
