From: bill4carson@gmail.com (bill4carson)
Date: Tue, 07 Feb 2012 10:00:25 +0800
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <20120206170709.GJ26538@arm.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
 <20120206170709.GJ26538@arm.com>
Message-ID: <4F3085B9.9070205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?07? 01:07, Catalin Marinas wrote:
> On Mon, Jan 30, 2012 at 07:57:12AM +0000, bill4carson at gmail.com wrote:
>> +static inline void set_hugepte_section(struct mm_struct *mm, unsigned long addr,
>> +                                  pte_t *ptep, pte_t pte)
>> +{
>> +       pgd_t *pgd;
>> +       pud_t *pud;
>> +       pmd_t *pmd;
>> +
>> +       int col, row;
>> +       pte_t **huge_linuxpte =&mm->huge_2m_pte[0];
>> +
>> +       row = HUGEPAGE_2M_PTE_ARRAY_ROW(addr);
>> +       col = HUGEPAGE_2M_PTE_ARRAY_COL(addr);
>> +
>> +       /* an valid pte pointer is expected */
>> +       BUG_ON(huge_linuxpte[row] == 0);
>> +       BUG_ON(ptep !=&huge_linuxpte[row][col]);
>> +
>> +       /* set linux pte first */
>> +       huge_linuxpte[row][col] = pte;
>> +
>> +       /* set hardware pte */
>> +       pgd = pgd_offset(mm, addr);
>> +       pud = pud_offset(pgd, addr);
>> +       pmd = pmd_offset(pud, addr);
>> +
>> +       set_hugepte_at(mm, addr, pmd, pte);
>> +}
>
> I haven't followed the whole structure of your patches but do we need to
> walk the page tables here? Isn't the ptep the same as the pmd when
> passed to this function (at least it was with my LPAE implementation).
>

Here, ptep is not the same as pmd, mm layer always manages linux pte.
For normal page, linux pte and hardware pte is just an 2048 bytes offset
away and cpu_v7_set_pte_ext can set both linux/hardware pte easily.


For huge page, linux pte is stored somewhere else,far away from hardware
pte table, in set_hugepte_section, "ptep" is the huge page based linux
pte address, first set linux pte value "pte" in there; and hardware pmd
address could only be derived from "addr" by a page table walk, then
setting hardware pmd value in set_hugepte_at, which
cpu_v7_set_hugepte_ext does the whole job.




-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
