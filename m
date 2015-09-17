From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:18 +0100
Subject: [PATCH 09/10] arm64: tlb: remove redundant barrier from
 __flush_tlb_pgtable
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__flush_tlb_pgtable is used to invalidate intermediate page table
entries after they have been cleared and are about to be freed. Since
pXd_clear imply memory barriers, we don't need the extra one here.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 93e9f964805c..b460ae28e346 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -163,7 +163,6 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 {
 	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
-	dsb(ishst);
 	asm("tlbi	vae1is, %0" : : "r" (addr));
 	dsb(ish);
 }
-- 
2.1.4
