From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Feb 2012 11:39:12 +0000
Subject: [PATCH] ARM: LPAE: Invalidate the TLB for module addresses
 during translation fault
In-Reply-To: <20120224101200.GG22562@n2100.arm.linux.org.uk>
References: <1330019981-18743-1-git-send-email-catalin.marinas@arm.com>
 <20120223195003.GD22562@n2100.arm.linux.org.uk>
 <20120223221343.GA27761@arm.com> <20120224095806.GA13117@arm.com>
 <20120224101200.GG22562@n2100.arm.linux.org.uk>
Message-ID: <20120224113912.GC13117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:12:00AM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 24, 2012 at 09:58:06AM +0000, Catalin Marinas wrote:
> > On Thu, Feb 23, 2012 at 10:13:43PM +0000, Catalin Marinas wrote:
> > > On Thu, Feb 23, 2012 at 07:50:03PM +0000, Russell King - ARM Linux wrote:
> > > > On Thu, Feb 23, 2012 at 05:59:41PM +0000, Catalin Marinas wrote:
> > > > > During the free_pgtables() call all user and modules/pkmap entries are
> > > > > removed.
> > > > 
> > > > Err, no.  free_pgtables() should only ever touch up to TASK_SIZE, which
> > > > is the maximum size of userspace.  Moreover, because TASK_SIZE does not
> > > > cover an entire pud, free_pgtables() should not be removing the pud
> > > > table.
> > > 
> > > Are you sure? exit_mmap() calls free_pgtables() with ceiling == 0.  If
> > > free_pmd_range() is called for a range in the top 1GB of the task
> > > address space (which includes modules), it also calls pud_clear()
> > > because ceiling is 0.
> > 
> > BTW, an alternative patch but which needs wider acknowledgement as it
> > touches generic code (I can post it to linux-mm):
> 
> I think that's the right solution.

Something similar is needed in shift_arg_pages() when calling
free_pgd_range().

But my concern - are there other architectures that rely on
free_pgtables() to remove page tables corresponding to vmas beyond
TASK_SIZE (e.g. vsyscall)?

-- 
Catalin
