From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:36 +0100
Subject: [RFC PATCH 01/11] arm64: tlb: Use last-level invalidation in
 flush_tlb_kernel_range()
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_tlb_kernel_range() is only ever used to invalidate last-level
entries, so we can restrict the scope of the TLB invalidation
instruction.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a4a1901140ee..7e2a35424ca4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -199,7 +199,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
-		__tlbi(vaae1is, addr);
+		__tlbi(vaale1is, addr);
 	dsb(ish);
 	isb();
 }
-- 
2.1.4
