From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 17:41:24 +0100
Subject: [PATCH v2 1/3] arm64: mm: print out correct page table entries
In-Reply-To: <20170609163328.GA10371@arm.com>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
 <20170609160407.GK10665@leverpostej>
 <20170609163328.GA10371@arm.com>
Message-ID: <20170609164124.GA3043@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 05:33:29PM +0100, Will Deacon wrote:
> On Fri, Jun 09, 2017 at 05:04:07PM +0100, Mark Rutland wrote:
> > On Fri, Jun 09, 2017 at 04:35:52PM +0100, Kristina Martsenko wrote:
> > >  /*
> > > - * Dump out the page tables associated with 'addr' in mm 'mm'.
> > > + * Dump out the page tables associated with 'addr' in the currently active mm.
> > >   */
> > > -void show_pte(struct mm_struct *mm, unsigned long addr)
> > > +void show_pte(unsigned long addr)
> > >  {
> > > +	struct mm_struct *mm;
> > >  	pgd_t *pgd;
> > >  
> > > -	if (!mm)
> > > +	if (addr < TASK_SIZE) {
> > > +		/* TTBR0 */
> > > +		mm = current->active_mm;
> > 
> > Can we log something for the active_mm == &init_mm case?
> > 
> > e.g.
> > 
> > 	if (addr < TASK_SIZE) {
> > 		if (current->active_mm == &init_mm)
> > 			pr_alert("[%016lx] address in unknown TTBR0 range\n",
> > 				addr);
> 
> I don't understand the case you're trying to highlight here, nor which
> table you want to walk.

On some threads, current->active_mm is the init_mm, and this doesn't
represent TTBR0.

In this case, TTBR0 is typically the zero page (or the idmap).

If we don't explicitly handle the init_mm case, we'd walk the kernel's
TTBR1 page table when reporting such faults, which would be misleading.

The easiest thing to do is to bail out, rather than trying to read TTBR0
and walk whatever it points to, since that could have an unusual VA
size.

Thanks,
Mark.
