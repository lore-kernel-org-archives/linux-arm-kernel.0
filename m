From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Oct 2015 18:46:25 +0100
Subject: [PATCH v2 05/10] arm64: tlbflush: remove redundant ASID casts to
 (unsigned long)
In-Reply-To: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
References: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
Message-ID: <1444153590-24173-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ASID macro returns a 64-bit (long long) value, so there is no need
to cast to (unsigned long) before shifting prior to a TLBI operation.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 96f944e75dc4..93e9f964805c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -81,7 +81,7 @@ static inline void flush_tlb_all(void)
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long asid = (unsigned long)ASID(mm) << 48;
+	unsigned long asid = ASID(mm) << 48;
 
 	dsb(ishst);
 	asm("tlbi	aside1is, %0" : : "r" (asid));
@@ -91,8 +91,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
-	unsigned long addr = uaddr >> 12 |
-		((unsigned long)ASID(vma->vm_mm) << 48);
+	unsigned long addr = uaddr >> 12 | (ASID(vma->vm_mm) << 48);
 
 	dsb(ishst);
 	asm("tlbi	vale1is, %0" : : "r" (addr));
@@ -109,7 +108,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
 				     bool last_level)
 {
-	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
+	unsigned long asid = ASID(vma->vm_mm) << 48;
 	unsigned long addr;
 
 	if ((end - start) > MAX_TLB_RANGE) {
@@ -162,7 +161,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 				       unsigned long uaddr)
 {
-	unsigned long addr = uaddr >> 12 | ((unsigned long)ASID(mm) << 48);
+	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
 	dsb(ishst);
 	asm("tlbi	vae1is, %0" : : "r" (addr));
-- 
2.1.4
