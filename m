From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jun 2017 17:33:29 +0100
Subject: [PATCH v2 1/3] arm64: mm: print out correct page table entries
In-Reply-To: <20170609160407.GK10665@leverpostej>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
 <20170609160407.GK10665@leverpostej>
Message-ID: <20170609163328.GA10371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 05:04:07PM +0100, Mark Rutland wrote:
> On Fri, Jun 09, 2017 at 04:35:52PM +0100, Kristina Martsenko wrote:
> >  /*
> > - * Dump out the page tables associated with 'addr' in mm 'mm'.
> > + * Dump out the page tables associated with 'addr' in the currently active mm.
> >   */
> > -void show_pte(struct mm_struct *mm, unsigned long addr)
> > +void show_pte(unsigned long addr)
> >  {
> > +	struct mm_struct *mm;
> >  	pgd_t *pgd;
> >  
> > -	if (!mm)
> > +	if (addr < TASK_SIZE) {
> > +		/* TTBR0 */
> > +		mm = current->active_mm;
> 
> Can we log something for the active_mm == &init_mm case?
> 
> e.g.
> 
> 	if (addr < TASK_SIZE) {
> 		if (current->active_mm == &init_mm)
> 			pr_alert("[%016lx] address in unknown TTBR0 range\n",
> 				addr);

I don't understand the case you're trying to highlight here, nor which
table you want to walk.

Will
