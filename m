From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jan 2015 16:37:32 +0000
Subject: [PATCH] arm/mm: fix compiler warning in pmdp_invalidate() (in -next)
In-Reply-To: <20150130100620.GL2395@suse.de>
References: <20150130100620.GL2395@suse.de>
Message-ID: <1422635852-21569-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ff61d185f4e7 ("mm: convert p[te|md]_mknonnuma and remaining
page table manipulations") removed a check in
mm/pgtable-generic.c:pmdp_invalidate(), which leaves the
pmd_mknotpresent macro the only user of the entry variable.
For ARM/LPAE we use a constant 0 without referencing the argument to
mark this condition, so the entry variable is no longer used here:

mm/pgtable-generic.c: In function 'pmdp_invalidate':
mm/pgtable-generic.c:195:8: warning: unused variable 'entry' [-Wunused-variable]
  pmd_t entry = *pmdp;
        ^

Replace the ARM macro implementation with a static inline function to
get rid of this warning.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi Andrew,

Mel mentioned that I should send that simple fix below to you to
merge it with his original mmotm patch:
mm-convert-p_mknonnuma-and-remaining-page-table-manipulations.patch
The commit message above contains the mmotm-reference to this patch,
which will break when it hits mainline.

Can you consider this? Given that's only a warning fix I am also
happy with resending it after -rc1, if you reckon that this arch/arm
change should not go via mmotm.


On 30/01/15 10:06, Mel Gorman wrote:
> Patch looks fine to me but this is against a mmotm patch that is
> included in mmotm. The commit ID is not going to last. This should be
> sent to Andrew Morton with a note saying it's a fix to the mmotm patch
> mm-convert-p_mknonnuma-and-remaining-page-table-manipulations.patch .
> He'll then fold your fix into the original patch so that bisection works
> correctly when merged to mainline. Do you mind doing that please?

Cheers,
Andre

 arch/arm/include/asm/pgtable-3level.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 370684d..0e51fbe 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -259,7 +259,10 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 /* represent a notpresent pmd by zero, this is used by pmdp_invalidate */
-#define pmd_mknotpresent(pmd)	(__pmd(0))
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	return 0;
+}
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-- 
1.7.9.5
