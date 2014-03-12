From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 12 Mar 2014 18:11:26 +0100
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <20140312165510.GA9950@mudshark.cambridge.arm.com>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312163200.GJ27965@twins.programming.kicks-ass.net>
 <20140312165510.GA9950@mudshark.cambridge.arm.com>
Message-ID: <20140312171126.GK27965@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:55:11PM +0000, Will Deacon wrote:
> On Wed, Mar 12, 2014 at 04:32:00PM +0000, Peter Zijlstra wrote:
> > On Wed, Mar 12, 2014 at 01:40:20PM +0000, Steve Capper wrote:
> > > +void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
> > > +			  pmd_t *pmdp)
> > > +{
> > > +	pmd_t pmd = pmd_mksplitting(*pmdp);
> > > +	VM_BUG_ON(address & ~PMD_MASK);
> > > +	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
> > > +
> > > +	/* dummy IPI to serialise against fast_gup */
> > > +	smp_call_function(thp_splitting_flush_sync, NULL, 1);
> > > +}
> > 
> > do you really need to IPI the entire machine? Wouldn't the mm's TLB
> > invalidate mask be sufficient?
> 
> Are you thinking of using mm_cpumask(vma->vm_mm)? That's rarely cleared on
> ARM, so it tends to identify everywhere the task has ever run, regardless of
> TLB state. The reason is that the mask is also used for cache flushing
> (which is further overloaded for VIVT and VIPT w/ software maintenance
> broadcast).
> 
> I had a patch improving this a bit (below) but I didn't manage to see any
> significant improvements so I didn't pursue it further. What we probably want
> to try is nuking the mask on a h/w broadcast TLBI operation with ARMv7, but
> it will mean adding horrible checks to tlbflush.h

Ah this is because you have context tagged TLBs so your context switch
doesn't locally flush TLBs and therefore you cannot keep track of this?

Too much x86 in my head I suppose.
