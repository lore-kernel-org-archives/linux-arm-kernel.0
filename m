From: saaguirre@ti.com (Aguirre, Sergio)
Date: Thu, 20 Jan 2011 15:06:30 -0600
Subject: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
Message-ID: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

WARNING: Linux MM newbie here. Please bare with me a bit.

While debugging a new v4l2 driver that makes use of the OMAP4 Tiler allocators in mmap calls, I found out that
remap_pfn_range was getting completely stalled.

And while debugging further, i realized that the point of stall was in mm/memory.c, function:

static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
			unsigned long addr, unsigned long end,
			unsigned long pfn, pgprot_t prot)
{
	pte_t *pte;
	spinlock_t *ptl;

	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
	if (!pte)
		return -ENOMEM;
	arch_enter_lazy_mmu_mode();
	do {


		BUG_ON(!pte_none(*pte)); <---******* HERE


		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
		pfn++;
	} while (pte++, addr += PAGE_SIZE, addr != end);
	arch_leave_lazy_mmu_mode();
	pte_unmap_unlock(pte - 1, ptl);
	return 0;
}

This is in 2.6.35.6 kernel + TI Android kernel changes. [1]

How should i interpret this? Does this mean something specific?

Any pointers will be appreciated.

Regards,
Sergio

---

[1] http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-android-omap-2.6.35
