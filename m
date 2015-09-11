From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Sep 2015 18:22:01 +0100
Subject: [PATCH 2/3] arm64: Fix pte_modify() to preserve the hardware dirty
 information
In-Reply-To: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
References: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1441992122-19888-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pte_modify() function with hardware AF/DBM enabled must transfer the
hardware dirty information to the software PTE_DIRTY bit. However, it
was setting this bit in newprot and the mask does not cover such bit.
This patch sets PTE_DIRTY on the original pte which will be preserved in
the returned value.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Julien Grall <julien.grall@citrix.com>
Fixes: 2f4b829c625e ("arm64: Add support for hardware updates of the access and dirty pte bits")
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 69207f016891..31df98adf005 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -503,7 +503,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 			      PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
-		newprot |= PTE_DIRTY;
+		pte = pte_mkdirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
