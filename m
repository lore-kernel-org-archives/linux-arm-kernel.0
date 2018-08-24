From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:37 +0100
Subject: [RFC PATCH 02/11] arm64: tlb: Add DSB ISHST prior to TLBI in
 __flush_tlb_[kernel_]pgtable()
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__flush_tlb_[kernel_]pgtable() rely on set_pXd() having a DSB after
writing the new table entry and therefore avoid the barrier prior to the
TLBI instruction.

In preparation for delaying our walk-cache invalidation on the unmap()
path, move the DSB into the TLB invalidation routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 7e2a35424ca4..e257f8655b84 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -213,6 +213,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 {
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
 
+	dsb(ishst);
 	__tlbi(vae1is, addr);
 	__tlbi_user(vae1is, addr);
 	dsb(ish);
@@ -222,6 +223,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
 	unsigned long addr = __TLBI_VADDR(kaddr, 0);
 
+	dsb(ishst);
 	__tlbi(vaae1is, addr);
 	dsb(ish);
 }
-- 
2.1.4
