From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sun,  6 Oct 2013 23:47:38 -0700
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for BE
 correct operation
In-Reply-To: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
References: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__flush_tlb_mm function need to use intermediate 'int' type 'asid'
variable int tlb_op macro call. Direct use of ASID macro produces
64 bit unsigned long long type passed to inline assembler statement
as 'r' operand (32bit), and resulting behavior is not well specified.
It works in little endian case, but is broken in big endian case. In
big endian case gcc generate such code that 0 is passed to
'mcr	15, 0, r4, cr8, cr3, {2}' operation.

Note other functions like __local_flush_tlb_mm, and local_flush_tlb_mm
already use intermediate 'asid' variable in similar code.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 3896026..b4d70ad 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -399,6 +399,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 
 static inline void __flush_tlb_mm(struct mm_struct *mm)
 {
+	const int asid = ASID(mm);
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
@@ -408,7 +409,7 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 #ifdef CONFIG_ARM_ERRATA_720789
 	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", 0);
 #else
-	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", ASID(mm));
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", asid);
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
-- 
1.8.1.4
