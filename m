From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Feb 2013 17:42:47 +0000
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses
In-Reply-To: <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
Message-ID: <20130201174246.GJ5151@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 04:40:35PM +0000, Christoffer Dall wrote:
> On Fri, Feb 1, 2013 at 11:37 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 01, 2013 at 04:32:54PM +0000, Christoffer Dall wrote:
> >> On Fri, Feb 1, 2013 at 11:26 AM, Catalin Marinas
> >> > --- a/arch/arm/mm/mmu.c
> >> > +++ b/arch/arm/mm/mmu.c
> >> > @@ -581,34 +581,19 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
> >> >                                       const struct mem_type *type)
> >> >  {
> >> >         pmd_t *pmd = pmd_offset(pud, addr);
> >> > +       unsigned long next;
> >> >
> >> > -       /*
> >> > -        * Try a section mapping - end, addr and phys must all be aligned
> >> > -        * to a section boundary.  Note that PMDs refer to the individual
> >> > -        * L1 entries, whereas PGDs refer to a group of L1 entries making
> >> > -        * up one logical pointer to an L2 table.
> >> > -        */
> >> > -       if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
> >> > -               pmd_t *p = pmd;
> >> > -
> >> > -#ifndef CONFIG_ARM_LPAE
> >> > -               if (addr & SECTION_SIZE)
> >> > -                       pmd++;
> >> > -#endif
> >> > -
> >> > -               do {
> >> > +       do {
> >> > +               next = section_addr_end(addr, end);
> >> > +               /* try section mapping first */
> >> > +               if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> >> >                         *pmd = __pmd(phys | type->prot_sect);
> >> > -                       phys += SECTION_SIZE;
> >> > -               } while (pmd++, addr += SECTION_SIZE, addr != end);
> >> > -
> >> > -               flush_pmd_entry(p);
> >> > -       } else {
> >> > -               /*
> >> > -                * No need to loop; pte's aren't interested in the
> >> > -                * individual L1 entries.
> >> > -                */
> >> > -               alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
> >> > -       }
> >> > +                       flush_pmd_entry(pmd);
> >> > +               } else {
> >> > +                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
> >>
> >> aren't you wasting memory here? The pte doesn't alloc a full page, but
> >> the memblock allocator allocates a full page right?
> >>
> >> I thought this was the rationale behind Russell's previous comments on
> >> Santosh's earlier patch version.
> >
> > You are right, it's allocating more ptes. Than we can use pmd_addr_end.
> > I'll go back to the code.
> >
> don't get me wrong, I strongly prefer keeping that loop in
> alloc_init_section, the other way it was weird to read, felt like
> shoehorning something, but you may have to keep a pointer around for
> unused part of a page for pte or something, not sure what ends up
> being nicest.

Another try. This time I kept the same logic as before but added a loop
on the outside (and indented the code). With classic MMU
pmd_addr_end(addr, end) always return end, so the logic doesn't change.
With LPAE we should get the standard looping over pmd entries. Again,
only tested on C-A9.


diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f06102..47154f3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -581,34 +581,36 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 				      const struct mem_type *type)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
+	unsigned long next;
 
-	/*
-	 * Try a section mapping - end, addr and phys must all be aligned
-	 * to a section boundary.  Note that PMDs refer to the individual
-	 * L1 entries, whereas PGDs refer to a group of L1 entries making
-	 * up one logical pointer to an L2 table.
-	 */
-	if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
-		pmd_t *p = pmd;
+	do {
+		next = pmd_addr_end(addr, end);
+
+		/*
+		 * Try a section mapping - next, addr and phys must all be
+		 * aligned to a section boundary.  Note that PMDs refer to the
+		 * individual L1 entries, whereas PGDs refer to a group of L1
+		 * entries making up one logical pointer to an L2 table.
+		 */
+		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
+			pmd_t *p = pmd;
 
 #ifndef CONFIG_ARM_LPAE
-		if (addr & SECTION_SIZE)
-			pmd++;
+			if (addr & SECTION_SIZE)
+				pmd++;
 #endif
+			do {
+				*pmd = __pmd(phys | type->prot_sect);
+				phys += SECTION_SIZE;
+			} while (pmd++, addr += SECTION_SIZE, addr != next);
 
-		do {
-			*pmd = __pmd(phys | type->prot_sect);
-			phys += SECTION_SIZE;
-		} while (pmd++, addr += SECTION_SIZE, addr != end);
-
-		flush_pmd_entry(p);
-	} else {
-		/*
-		 * No need to loop; pte's aren't interested in the
-		 * individual L1 entries.
-		 */
-		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
-	}
+			flush_pmd_entry(p);
+		} else {
+			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
+			phys += next - addr;
+			pmd++;
+		}
+	} while (addr = next, addr != end);
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
