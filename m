From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  7 Oct 2013 08:48:23 -0700
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
In-Reply-To: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1381160903-1248-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
1.8.1.4
