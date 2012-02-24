From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Feb 2012 09:58:06 +0000
Subject: [PATCH] ARM: LPAE: Invalidate the TLB for module addresses
 during translation fault
In-Reply-To: <20120223221343.GA27761@arm.com>
References: <1330019981-18743-1-git-send-email-catalin.marinas@arm.com>
 <20120223195003.GD22562@n2100.arm.linux.org.uk>
 <20120223221343.GA27761@arm.com>
Message-ID: <20120224095806.GA13117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 10:13:43PM +0000, Catalin Marinas wrote:
> On Thu, Feb 23, 2012 at 07:50:03PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 23, 2012 at 05:59:41PM +0000, Catalin Marinas wrote:
> > > During the free_pgtables() call all user and modules/pkmap entries are
> > > removed.
> > 
> > Err, no.  free_pgtables() should only ever touch up to TASK_SIZE, which
> > is the maximum size of userspace.  Moreover, because TASK_SIZE does not
> > cover an entire pud, free_pgtables() should not be removing the pud
> > table.
> 
> Are you sure? exit_mmap() calls free_pgtables() with ceiling == 0.  If
> free_pmd_range() is called for a range in the top 1GB of the task
> address space (which includes modules), it also calls pud_clear()
> because ceiling is 0.

BTW, an alternative patch but which needs wider acknowledgement as it
touches generic code (I can post it to linux-mm):

diff --git a/mm/mmap.c b/mm/mmap.c
index 3f758c7..5e5c8a8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1866,7 +1866,7 @@ static void unmap_region(struct mm_struct *mm,
 	unmap_vmas(&tlb, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : 0);
+				 next ? next->vm_start : TASK_SIZE);
 	tlb_finish_mmu(&tlb, start, end);
 }
 
@@ -2241,7 +2241,7 @@ void exit_mmap(struct mm_struct *mm)
 	end = unmap_vmas(&tlb, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
+	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, TASK_SIZE);
 	tlb_finish_mmu(&tlb, 0, end);
 
 	/*

-- 
Catalin
