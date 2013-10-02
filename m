From: iamjoonsoo.kim@lge.com (=?ks_c_5601-1987?B?sejB2Lz2?=)
Date: Wed, 2 Oct 2013 14:05:03 +0900
Subject: Why does unmap_area_sections() depend on !CONFIG_SMP?
In-Reply-To: <alpine.LFD.2.03.1310011337450.21228@syhkavp.arg>
References: <20131001095955.GA22859@lge.com>
 <alpine.LFD.2.03.1310011337450.21228@syhkavp.arg>
Message-ID: <018a01cebf2c$f44175c0$dcc46140$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nicolas Pitre [mailto:nicolas.pitre at linaro.org]
> Sent: Wednesday, October 02, 2013 3:24 AM
> To: Joonsoo Kim
> Cc: Russell King; linux-arm-kernel at lists.infradead.org
> Subject: Re: Why does unmap_area_sections() depend on !CONFIG_SMP?
> 
> On Tue, 1 Oct 2013, Joonsoo Kim wrote:
> 
> > Hello, Russell.
> >
> > I looked at ioremap code in arm tree and found that
> > unmap_area_sections() is enabled only if !CONFIG_SMP. I can't
> > understand the comments above this function and it comes from you.
> > Could you elaborate more on this?
> >
> > I guess that flush_cache_vunmap() before clearing page table and
> > flush_tlb_kernel_range() after clearing page table is safe enough to
> > cache consistency regardless CONFIG_SMP configuration. I think that 4K
> > vunmap() also depends on this flushing logic.
> >
> > Please let me know what I am missing here.
> 
> This is all related to the page table level involved.
> 
> Each entry in the first level page table may refer to a second level page
> table covering 1MB worth of virtual space, or it may be a direct mapping
> corresponding to 1MB of contiguous physical memory.
> 
> In Linux, all tasks, including kernel threads, have their own first level
> page table.  On process creation, the top entries covering TASK_SIZE and
> above in the first level page table is copied from init_mm into the new
> page table as the kernel address space is meant to be identical across all
> tasks.
> 
> This is however not always the case though.  Consider one call to
> ioremap() which does create a new entry in the kernel virtual space.
> In order to ensure that the kernel virtual space is indeed the same across
> all tasks, the ioremap code would have to walk the entire task list just
> to update their own copy of the kernel virtual mapping.  So what we do
> instead is to create the new page table entry in init_mm only, and lazily
> update the other task's page table when they fault on access due to their
> own page table being incomplete.
> 
> What about iounmap() then.  When a mapping is removed, we don't want it to
> be accessible through some random task's page table.  Well, in the normal
> ioremap() case, the actual mapping is created into a second level page
> table which happens to be common to all tasks.  Hence the first level page
> table entry being created is actually a pointer to that second level page
> table, and when a mapping is removed it is only removed from that second
> level page table.  The second level table itself remains in memory
forever,
> ready to be reused for any other call to ioremap().  Therefore there is no
> need to update each task's first level table again.
> 
> So far so good.
> 
> Now comes the section mapping for ioremap().  Since this is handled into
> the first level page table only with no common second level table, we
> needed a mechanism to ensure that any mapping removal gets propagated to
> all first level tables in the system.  This is accomplished with a
> sequence counter namely vmalloc_seq which is incremented whenever such a
> change occurs.  Upon every task switch, this counter is checked against
> the master copy to detect when the next task to be scheduled has its first
> level page table out of date, and if so it is updated before the new
> memory context is instated.
> 
> But... this works only if not SMP.  On SMP, different tasks might be
> running on the other CPUs and incrementing vmalloc_seq won't have any
> effect on them.  This is why section mappings for ioremap() is not
> available if SMP.
> 
> This could probably be fixed by sending an IPI to the other processors,
> forcing them to resync their page table right after clearing the mapping
> from the master table.  But no one implemented it so far.

Hello, Nicolas.

Really thanks for kind explanation.
Now, I totally understand why it is not available if SMP.
I will investigate more on this and try to implement that section mapping
for ioremap() works on SMP.

Thanks.
