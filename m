From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Feb 2012 17:07:09 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120206170709.GJ26538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 07:57:12AM +0000, bill4carson at gmail.com wrote:
> +static inline void set_hugepte_section(struct mm_struct *mm, unsigned long addr,
> +                                  pte_t *ptep, pte_t pte)
> +{
> +       pgd_t *pgd;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +
> +       int col, row;
> +       pte_t **huge_linuxpte = &mm->huge_2m_pte[0];
> +
> +       row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
> +       col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
> +
> +       /* an valid pte pointer is expected */
> +       BUG_ON(huge_linuxpte[row] == 0);
> +       BUG_ON(ptep != &huge_linuxpte[row][col]);
> +
> +       /* set linux pte first */
> +       huge_linuxpte[row][col] = pte;
> +
> +       /* set hardware pte */
> +       pgd = pgd_offset(mm, addr);
> +       pud = pud_offset(pgd, addr);
> +       pmd = pmd_offset(pud, addr);
> +
> +       set_hugepte_at(mm, addr, pmd, pte);
> +}

I haven't followed the whole structure of your patches but do we need to
walk the page tables here? Isn't the ptep the same as the pmd when
passed to this function (at least it was with my LPAE implementation).

-- 
Catalin
