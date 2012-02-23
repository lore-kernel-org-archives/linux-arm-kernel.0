From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Feb 2012 22:13:43 +0000
Subject: [PATCH] ARM: LPAE: Invalidate the TLB for module addresses
 during translation fault
In-Reply-To: <20120223195003.GD22562@n2100.arm.linux.org.uk>
References: <1330019981-18743-1-git-send-email-catalin.marinas@arm.com>
 <20120223195003.GD22562@n2100.arm.linux.org.uk>
Message-ID: <20120223221343.GA27761@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 07:50:03PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 23, 2012 at 05:59:41PM +0000, Catalin Marinas wrote:
> > During the free_pgtables() call all user and modules/pkmap entries are
> > removed.
> 
> Err, no.  free_pgtables() should only ever touch up to TASK_SIZE, which
> is the maximum size of userspace.  Moreover, because TASK_SIZE does not
> cover an entire pud, free_pgtables() should not be removing the pud
> table.

Are you sure? exit_mmap() calls free_pgtables() with ceiling == 0.  If
free_pmd_range() is called for a range in the top 1GB of the task
address space (which includes modules), it also calls pud_clear()
because ceiling is 0.

> > There is a small window between pud_clear() and pmd_free_tlb() in
> > free_pmd_range() where the pud entry was cleared but the TLB has not
> > been invalidated yet and the CPU may have cached the original (valid)
> > pud entry in the TLB. A scenario like below would get stuck in
> > continuous prefetch abort:
> > 
> > 1. Current process exiting. The modules pmd entries not populated
> > 2. exit_mmap() -> ... -> pmd_free_tlb()
> > 3. pud_clear() for the 1GB pud containing user stack and modules (no TLB
> >    invalidation yet)
> 
> This is where things are wrong.  Because the request should not be
> requesting that the entire pud is being cleared, it should not be
> removed from the pgd.

Actually the pgd and pud are the same. free_pgtables() removes the whole
pmd (in free_pmd_range()) and clears the higher pud entry that includes
the modules mapping.

-- 
Catalin
