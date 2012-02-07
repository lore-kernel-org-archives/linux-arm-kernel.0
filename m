From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Feb 2012 11:54:48 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <4F3085B9.9070205@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
 <20120206170709.GJ26538@arm.com> <4F3085B9.9070205@gmail.com>
Message-ID: <20120207115448.GE3351@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 02:00:25AM +0000, bill4carson wrote:
> On 2012?02?07? 01:07, Catalin Marinas wrote:
> > On Mon, Jan 30, 2012 at 07:57:12AM +0000, bill4carson at gmail.com wrote:
> >> +static inline void set_hugepte_section(struct mm_struct *mm, unsigned long addr,
> >> +                                  pte_t *ptep, pte_t pte)
> >> +{
> >> +       pgd_t *pgd;
> >> +       pud_t *pud;
> >> +       pmd_t *pmd;
> >> +
> >> +       int col, row;
> >> +       pte_t **huge_linuxpte =&mm->huge_2m_pte[0];
> >> +
> >> +       row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
> >> +       col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
> >> +
> >> +       /* an valid pte pointer is expected */
> >> +       BUG_ON(huge_linuxpte[row] == 0);
> >> +       BUG_ON(ptep !=&huge_linuxpte[row][col]);
> >> +
> >> +       /* set linux pte first */
> >> +       huge_linuxpte[row][col] = pte;
> >> +
> >> +       /* set hardware pte */
> >> +       pgd = pgd_offset(mm, addr);
> >> +       pud = pud_offset(pgd, addr);
> >> +       pmd = pmd_offset(pud, addr);
> >> +
> >> +       set_hugepte_at(mm, addr, pmd, pte);
> >> +}
> >
> > I haven't followed the whole structure of your patches but do we need to
> > walk the page tables here? Isn't the ptep the same as the pmd when
> > passed to this function (at least it was with my LPAE implementation).
> 
> Here, ptep is not the same as pmd, mm layer always manages linux pte.
> For normal page, linux pte and hardware pte is just an 2048 bytes offset
> away and cpu_v7_set_pte_ext can set both linux/hardware pte easily.
> 
> For huge page, linux pte is stored somewhere else,far away from hardware
> pte table, in set_hugepte_section, "ptep" is the huge page based linux
> pte address, first set linux pte value "pte" in there; and hardware pmd
> address could only be derived from "addr" by a page table walk, then
> setting hardware pmd value in set_hugepte_at, which
> cpu_v7_set_hugepte_ext does the whole job.

OK. I thought we already have some pointer in the Linux pmd for the
actual hardware pmd. Walking the page table isn't expensive in this
case, with only 2 levels. For LPAE we don't even need this since we
don't have a separate Linux pte/pmd.

-- 
Catalin
