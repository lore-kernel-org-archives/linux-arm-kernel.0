From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Sep 2018 18:45:47 +0100
Subject: [GIT PULL] arm64: fix for -rc3
In-Reply-To: <CA+55aFw97E=pUTRejXDAVYbK90cgF=1R3MPxE3t9fDoKctOGNA@mail.gmail.com>
References: <20180907154516.GG12788@arm.com>
 <CA+55aFw97E=pUTRejXDAVYbK90cgF=1R3MPxE3t9fDoKctOGNA@mail.gmail.com>
Message-ID: <20180910174547.GD19027@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Sep 07, 2018 at 10:51:19AM -0700, Linus Torvalds wrote:
> On Fri, Sep 7, 2018 at 8:45 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Just one small fix here, preventing a VM_WARN_ON when a !present PMD/PUD
> > is "freed" as part of a huge ioremap() operation. The correct behaviour
> > is to skip the free silently in this case, which is a little weird (the
> > function is a bit of a misnomer), but it follows the x86 implementation.
> 
> Hmm. I've obviously pulled it, but it does strike me that maybe the
> confusing semantics could be fixed?
> 
> There's only one call site, and only two implementations (x86 and arm64).
> 
> Maybe the whole "read pmd, check for present" could just be in the
> caller, avoiding that oddity wrt name-vs-behavior.
> 
> I'm not entirely sure why that code has that special case to begin
> with. I guess this is the only case of a kernel mapping of a hugepage,
> and people wanted to avoid polluting the generic code with stuff that
> was only relevant for architectures that implemented it? But we
> already have that ioremap_pmd_enabled() guard, so architectures that
> don't do this wouldn't actually have any extra code.
> 
> Anyway, I'll let it be, but I think it could be a good idea to simply
> change the semantics, and in the process also make it a lot clearer
> what that thing actually is expected to do.

Yeah, I agree, and it's better to fix it before it grows lots of other
users. I had a hack at it (see below), but note:

  * I ended up reworking the phys_addr calculations to avoid the misnomer
    there as well (namely that phys_addr isn't a physical address!).

  * The huge p4d code is only half implemented in mainline and unused by
    any architecture. I've added some of the missing bits, or we could
    just rip it out.

  * The shape of the code is duplicated, but I couldn't figure out a
    cleaner way to do it and maintain the type-checking for the different
    levels.

Happy to send as a proper patch if you think this is the right sort of
idea.

Will

--->8

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8080c9f489c3..58776b90dd2a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -985,10 +985,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 
 	pmd = READ_ONCE(*pmdp);
 
-	if (!pmd_present(pmd))
-		return 1;
 	if (!pmd_table(pmd)) {
-		VM_WARN_ON(!pmd_table(pmd));
+		VM_WARN_ON(1);
 		return 1;
 	}
 
@@ -1008,10 +1006,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 
 	pud = READ_ONCE(*pudp);
 
-	if (!pud_present(pud))
-		return 1;
 	if (!pud_table(pud)) {
-		VM_WARN_ON(!pud_table(pud));
+		VM_WARN_ON(1);
 		return 1;
 	}
 
@@ -1028,3 +1024,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pmd_free(NULL, table);
 	return 1;
 }
+
+int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+{
+	return 0;	/* Don't attempt a block mapping */
+}
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ae394552fb94..c6094997d060 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -779,6 +779,14 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+/*
+ * Until we support 512GB pages, skip them in the vmap area.
+ */
+int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
+{
+	return 0;
+}
+
 #ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
@@ -796,9 +804,6 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pte_t *pte;
 	int i;
 
-	if (pud_none(*pud))
-		return 1;
-
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
@@ -840,9 +845,6 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return 1;
-
 	pte = (pte_t *)pmd_page_vaddr(*pmd);
 	pmd_clear(pmd);
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc6102c7c..9ac982ea6c4a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1019,6 +1019,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
+int p4d_free_pud_page(p4d_t *pmd, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
@@ -1046,6 +1047,10 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
+static inline int p4d_free_pud_page(p4d_t *pmd, unsigned long addr)
+{
+	return 0;
+}
 static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 517f5853ffed..3d04f0e1d79d 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -76,83 +76,123 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
+				unsigned long end, phys_addr_t phys_addr,
+				pgprot_t prot)
+{
+	if (!ioremap_pmd_enabled())
+		return 0;
+
+	if ((end - addr) != PMD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
+		return 0;
+
+	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+		return 0;
+
+	return pmd_set_huge(pmd, phys_addr, prot);
+}
+
 static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pmd_t *pmd;
 	unsigned long next;
 
-	phys_addr -= addr;
 	pmd = pmd_alloc(&init_mm, pud, addr);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (ioremap_pmd_enabled() &&
-		    ((next - addr) == PMD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd, addr)) {
-			if (pmd_set_huge(pmd, phys_addr + addr, prot))
-				continue;
-		}
+		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
+			continue;
 
-		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
+		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
+	} while (pmd++, addr = next, phys_addr += PMD_SIZE, addr != end);
 	return 0;
 }
 
+static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
+				unsigned long end, phys_addr_t phys_addr,
+				pgprot_t prot)
+{
+	if (!ioremap_pud_enabled())
+		return 0;
+
+	if ((end - addr) != PUD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
+		return 0;
+
+	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+		return 0;
+
+	return pud_set_huge(pud, phys_addr, prot);
+}
+
 static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pud_t *pud;
 	unsigned long next;
 
-	phys_addr -= addr;
 	pud = pud_alloc(&init_mm, p4d, addr);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
 
-		if (ioremap_pud_enabled() &&
-		    ((next - addr) == PUD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud, addr)) {
-			if (pud_set_huge(pud, phys_addr + addr, prot))
-				continue;
-		}
+		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot))
+			continue;
 
-		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
+		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
+	} while (pud++, addr = next, phys_addr += PUD_SIZE, addr != end);
 	return 0;
 }
 
+static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
+				unsigned long end, phys_addr_t phys_addr,
+				pgprot_t prot)
+{
+	if (!ioremap_p4d_enabled())
+		return 0;
+
+	if ((end - addr) != P4D_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
+		return 0;
+
+	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+		return 0;
+
+	return p4d_set_huge(p4d, phys_addr, prot);
+}
+
 static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	p4d_t *p4d;
 	unsigned long next;
 
-	phys_addr -= addr;
 	p4d = p4d_alloc(&init_mm, pgd, addr);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
 
-		if (ioremap_p4d_enabled() &&
-		    ((next - addr) == P4D_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, P4D_SIZE)) {
-			if (p4d_set_huge(p4d, phys_addr + addr, prot))
-				continue;
-		}
+		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot))
+			continue;
 
-		if (ioremap_pud_range(p4d, addr, next, phys_addr + addr, prot))
+		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
 			return -ENOMEM;
-	} while (p4d++, addr = next, addr != end);
+	} while (p4d++, addr = next, phys_addr += P4D_SIZE, addr != end);
 	return 0;
 }
 
@@ -168,14 +208,13 @@ int ioremap_page_range(unsigned long addr,
 	BUG_ON(addr >= end);
 
 	start = addr;
-	phys_addr -= addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr+addr, prot);
+		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot);
 		if (err)
 			break;
-	} while (pgd++, addr = next, addr != end);
+	} while (pgd++, addr = next, phys_addr += addr, addr != end);
 
 	flush_cache_vmap(start, end);
 
