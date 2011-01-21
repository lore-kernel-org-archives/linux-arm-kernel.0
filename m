From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:30:05 +0000
Subject: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
In-Reply-To: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
Message-ID: <20110121103005.GA14142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 03:06:30PM -0600, Aguirre, Sergio wrote:
> And while debugging further, i realized that the point of stall was
> in mm/memory.c, function:
> 
> static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
> 			unsigned long addr, unsigned long end,
> 			unsigned long pfn, pgprot_t prot)
> {
> 	pte_t *pte;
> 	spinlock_t *ptl;
> 
> 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
> 	if (!pte)
> 		return -ENOMEM;
> 	arch_enter_lazy_mmu_mode();
> 	do {
> 
> 
> 		BUG_ON(!pte_none(*pte)); <---******* HERE
> 
> 
> 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
> 		pfn++;
> 	} while (pte++, addr += PAGE_SIZE, addr != end);
> 	arch_leave_lazy_mmu_mode();
> 	pte_unmap_unlock(pte - 1, ptl);
> 	return 0;
> }
> 
> This is in 2.6.35.6 kernel + TI Android kernel changes. [1]
> 
> How should i interpret this? Does this mean something specific?

It is asserting that the pte we are about to overwrite was empty.  In
other words, there is no existing mapping in place at that virtual
address.

If there was a pre-existing mapping, you're doing something wrong
because you're potentially overwriting something else.
