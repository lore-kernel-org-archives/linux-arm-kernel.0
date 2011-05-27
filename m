From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2011 10:09:49 +0100
Subject: [PATCH v5 00/19] ARM: Add support for the Large Physical
	Address Extensions
In-Reply-To: <20110526214449.GK24876@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<20110523165412.GF15138@n2100.arm.linux.org.uk>
	<1306231448.19557.23.camel@e102109-lin.cambridge.arm.com>
	<BANLkTikjBm3tn4Q4T1r9qyB2ma88YydDZQ@mail.gmail.com>
	<20110526214449.GK24876@n2100.arm.linux.org.uk>
Message-ID: <20110527090948.GB21100@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 10:44:49PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 26, 2011 at 10:15:49PM +0100, Catalin Marinas wrote:
> > On 24 May 2011 11:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, 2011-05-23 at 17:54 +0100, Russell King - ARM Linux wrote:
> > >> FYI, I'm going to drop the pgt patch because the warnings are still there
> >
> > I'd like to fix those warning but I can't reproduce them (maybe
> > different compiler versions?).
> 
> They're certainly not compiler version dependent (or if they are, your
> compiler is broken).  It'll probably be because you're building for
> SMP, in which case the affected code is not built:

OK. Since the smp-on-up feature I don't check UP builds regularly.

> arch/arm/mm/ioremap.c: In function unmap_area_sections:
> arch/arm/mm/ioremap.c:86: warning: passing argument 1 of pmd_offset from
> incompatible pointer type
> arch/arm/mm/ioremap.c: In function remap_area_sections:
> arch/arm/mm/ioremap.c:136: warning: passing argument 1 of pmd_offset from
> incompatible pointer type
> arch/arm/mm/ioremap.c: In function remap_area_supersections:
> arch/arm/mm/ioremap.c:173: warning: passing argument 1 of pmd_offset from
> incompatible pointer type

The patch below fixes the warnings. Tested on VE in UP configuration.

Later we can change the loops to walking the pmd using PMD_SIZE for
consistency with the LPAE patches where we consider PMD to be the
section in both cases. There is no functional change since the pmd is
folded into pud which is folded into the pgd and PMD_SIZE == PGDIR_SIZE
with the classic page tables.


diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..0da0091 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -83,7 +83,8 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 	flush_cache_vunmap(addr, end);
 	pgd = pgd_offset_k(addr);
 	do {
-		pmd_t pmd, *pmdp = pmd_offset(pgd, addr);
+		pud_t *pud = pud_offset(pgd, addr);
+		pmd_t pmd, *pmdp = pmd_offset(pud, addr);
 
 		pmd = *pmdp;
 		if (!pmd_none(pmd)) {
@@ -133,7 +134,8 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 
 	pgd = pgd_offset_k(addr);
 	do {
-		pmd_t *pmd = pmd_offset(pgd, addr);
+		pud_t *pud = pud_offset(pgd, addr);
+		pmd_t *pmd = pmd_offset(pud, addr);
 
 		pmd[0] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
@@ -170,7 +172,8 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 		super_pmd_val |= ((pfn >> (32 - PAGE_SHIFT)) & 0xf) << 20;
 
 		for (i = 0; i < 8; i++) {
-			pmd_t *pmd = pmd_offset(pgd, addr);
+			pud_t *pud = pud_offset(pgd, addr);
+			pmd_t *pmd = pmd_offset(pud, addr);
 
 			pmd[0] = __pmd(super_pmd_val);
 			pmd[1] = __pmd(super_pmd_val);


-- 
Catalin
