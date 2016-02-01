From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Feb 2016 14:56:25 +0000
Subject: [PATCH v5sub1 2/8] arm64: add support for ioremap() block mappings
In-Reply-To: <20160201141004.GI674@leverpostej>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-3-git-send-email-ard.biesheuvel@linaro.org>
 <20160201141004.GI674@leverpostej>
Message-ID: <20160201145624.GF15514@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 02:10:04PM +0000, Mark Rutland wrote:
> On Mon, Feb 01, 2016 at 11:54:47AM +0100, Ard Biesheuvel wrote:
> > This wires up the existing generic huge-vmap feature, which allows
> > ioremap() to use PMD or PUD sized block mappings. It also adds support
> > to the unmap path for dealing with block mappings, which will allow us
> > to unmap the __init region using unmap_kernel_range() in a subsequent
> > patch.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> I was a little bit worried about this potentially not matching the
> granularity we used when creating mappings, but seeing how
> p?d_clear_huge are called by unmap_kernel_range, I think this is fine.

I tried the warnings below and they didn't trigger. Anyway, if we ever
unmapped more, I guess we would have quickly triggered a kernel fault.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fb42a5bffe47..40362d62d1e1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -77,8 +77,10 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_clear_huge(pmd))
+		if (pmd_clear_huge(pmd)) {
+			WARN_ON(next < addr + PMD_SIZE);
 			continue;
+		}
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		vunmap_pte_range(pmd, addr, next);
@@ -93,8 +95,10 @@ static void vunmap_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end)
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_clear_huge(pud))
+		if (pud_clear_huge(pud)) {
+			WARN_ON(next < addr + PUD_SIZE);
 			continue;
+		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		vunmap_pmd_range(pud, addr, next);

-- 
Catalin
