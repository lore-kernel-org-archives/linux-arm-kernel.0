From: pelcan@codeaurora.org (Philip Elcan)
Date: Wed, 21 Mar 2018 17:02:52 -0400
Subject: [PATCH] arm64: tlbflush: avoid writing RES0 bits
Message-ID: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bits [47:44] of the TLBI register operand are RES0 for instructions that
require a VA, per the ARM ARM spec, so TLBI operations should avoid writing
non-zero values to these bits.

Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
---
 arch/arm64/include/asm/tlbflush.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9e82dd7..dbd22a9 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -60,6 +60,9 @@
 		__tlbi(op, (arg) | USER_ASID_FLAG);				\
 } while (0)
 
+/* This macro masks out RES0 bits in the TLBI operand */
+#define __TLBI_VADDR(addr) (addr & ~GENMASK_ULL(47, 44))
+
 /*
  *	TLB Management
  *	==============
@@ -128,7 +131,8 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
-	unsigned long addr = uaddr >> 12 | (ASID(vma->vm_mm) << 48);
+	unsigned long addr = __TLBI_VADDR(uaddr >> 12) |
+			     (ASID(vma->vm_mm) << 48);
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
@@ -154,8 +158,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 		return;
 	}
 
-	start = asid | (start >> 12);
-	end = asid | (end >> 12);
+	start = asid | __TLBI_VADDR(start >> 12);
+	end = asid | __TLBI_VADDR(end >> 12);
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
@@ -185,8 +189,8 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 		return;
 	}
 
-	start >>= 12;
-	end >>= 12;
+	start = __TLBI_VADDR(start >> 12);
+	end = __TLBI_VADDR(end >> 12);
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
@@ -202,7 +206,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 				       unsigned long uaddr)
 {
-	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
+	unsigned long addr = __TLBI_VADDR(uaddr >> 12) | (ASID(mm) << 48);
 
 	__tlbi(vae1is, addr);
 	__tlbi_user(vae1is, addr);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
