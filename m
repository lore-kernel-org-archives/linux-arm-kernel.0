From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jun 2017 11:00:51 +0100
Subject: [PATCH v2 1/3] arm64: mm: print out correct page table entries
In-Reply-To: <20170609202236.t75jejhvhksqmkw3@yury-thinkpad>
References: <1497022554-1451-1-git-send-email-kristina.martsenko@arm.com>
 <20170609202236.t75jejhvhksqmkw3@yury-thinkpad>
Message-ID: <20170615100051.GC20308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 11:22:36PM +0300, Yury Norov wrote:
> On Fri, Jun 09, 2017 at 04:35:52PM +0100, Kristina Martsenko wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index c3f2b1048f83..a9dfb37c87a2 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -80,14 +80,24 @@ static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
> >  #endif
> >  
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
> > +	} else if (addr >= VA_START) {
> > +		/* TTBR1 */
> >  		mm = &init_mm;
> > +	} else {
> > +		pr_alert("[%08lx] address between user and kernel address ranges\n",
> > +			 addr);
> > +		return;
> > +	}
> >  
> >  	pr_alert("pgd = %p\n", mm->pgd);
> >  	pgd = pgd_offset(mm, addr);
> 
> Is there any reason to change the prototype of the function?
> You say nothing about it in patch description. The show_pte()
> is implemented in several arches, and everywhere it takes mm_struct
> as 1st argument. For me, if you don't need to change the prototype,
> you'd better leave things as is. The patch will get much shorter
> and expressive with it.
> 
> If you really need to change the prototype, it would be better to do
> it in separated patch and give clear explanations - what for?

The mm is unused and this isn't a core interface. In fact, it's only
available on architectures that started off by copying from arch/arm/.

We can always add the mm back if we need it in future.

Will
