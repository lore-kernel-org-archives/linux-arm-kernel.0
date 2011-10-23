From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 12:59:38 +0100
Subject: [PATCH v7 13/16] ARM: LPAE: Add identity mapping support for
	the 3-level page table format
In-Reply-To: <1312988619-16804-14-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-14-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111023115938.GC17912@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:36PM +0100, Catalin Marinas wrote:
> The pmd_addr_end() definition has been removed and the
> generic one used instead.

NAK - it helps to read code comments.

commit c0ba10b512eb2e2a3888b6e6cc0e089f5e7a191b
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Nov 21 14:42:47 2010 +0000

    ARM: improve compiler's ability to optimize page tables
    
    Allow the compiler to better optimize the page table walking code
    by avoiding over-complex pmd_addr_end() calculations.  These
    calculations prevent the compiler spotting that we'll never iterate
    over the PMD table, causing it to create double nested loops where
    a single loop will do.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index b155414..53d1d5d 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -374,6 +374,9 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 
 #define pmd_page(pmd)          pfn_to_page(__phys_to_pfn(pmd_val(pmd)))
 
+/* we don't need complex calculations here as the pmd is folded into the pgd */
+#define pmd_addr_end(addr,end) (end)
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
