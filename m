From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 17:37:40 +0100
Subject: [PATCH 2/2] ARM: mm: Fix definition of pmd_mknotpresent
In-Reply-To: <1464712660-25177-1-git-send-email-catalin.marinas@arm.com>
References: <1464712660-25177-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1464712660-25177-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

Currently pmd_mknotpresent will use a zero entry to respresent an
invalidated pmd.

Unfortunately this definition clashes with pmd_none, thus it is
possible for a race condition to occur if zap_pmd_range sees pmd_none
whilst __split_huge_pmd_locked is running too with pmdp_invalidate
just called.

This patch fixes the race condition by modifying pmd_mknotpresent to
create non-zero faulting entries (as is done in other architectures),
removing the ambiguity with pmd_none.

Fixes: 8d9625070073 ("ARM: mm: Transparent huge page support for LPAE systems.")
Cc: <stable@vger.kernel.org> # 3.11+
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Steve Capper <steve.capper@arm.com>
[catalin.marinas at arm.com: using L_PMD_SECT_VALID instead of PMD_TYPE_SECT]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 4dce1580bc15..2a029bceaf2f 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -250,10 +250,10 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 #define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
-/* represent a notpresent pmd by zero, this is used by pmdp_invalidate */
+/* represent a notpresent pmd by faulting entry, this is used by pmdp_invalidate */
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	return __pmd(0);
+	return __pmd(pmd_val(pmd) & ~L_PMD_SECT_VALID);
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
