From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 13 Aug 2014 09:30:08 +0200
Subject: [PATCH v9 4/4] arm: ARMv7 dirty page logging 2nd stage page
 fault handling support
In-Reply-To: <53EABEEF.9070907@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-5-git-send-email-m.smarduch@samsung.com>
 <20140811191315.GI10550@cbox> <53E96CF1.6040806@samsung.com>
 <20140812095045.GN10550@cbox> <53EABEEF.9070907@samsung.com>
Message-ID: <20140813073008.GP10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 06:27:11PM -0700, Mario Smarduch wrote:
> On 08/12/2014 02:50 AM, Christoffer Dall wrote:
> > On Mon, Aug 11, 2014 at 06:25:05PM -0700, Mario Smarduch wrote:
> >> On 08/11/2014 12:13 PM, Christoffer Dall wrote:
> >>> On Thu, Jul 24, 2014 at 05:56:08PM -0700, Mario Smarduch wrote:

[...]

> >>>> @@ -1151,7 +1170,7 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
> >>>>  {
> >>>>  	pte_t *pte = (pte_t *)data;
> >>>>  
> >>>> -	stage2_set_pte(kvm, NULL, gpa, pte, false);
> >>>> +	stage2_set_pte(kvm, NULL, gpa, pte, false, false);
> >>>
> >>> why is logging never active if we are called from MMU notifiers?
> >>
> >> mmu notifiers update sptes, but I don't see how these updates
> >> can result in guest dirty pages. Also guest pages are marked dirty
> >> from 2nd stage page fault handlers (searching through the code).
> >>
> > Ok, then add:
> > 
> > /*
> >  * We can always call stage2_set_pte with logging_active == false,
> >  * because MMU notifiers will have unmapped a huge PMD before calling
> >  * ->change_pte() (which in turn calls kvm_set_spte_hva()) and therefore
> >  * stage2_set_pte() never needs to clear out a huge PMD through this
> >  * calling path.
> >  */
> 
> So here on permission change to primary pte's kernel first invalidates
> related s2ptes followed by ->change_pte calls to synchronize s2ptes. As
> consequence of invalidation we unmap huge PMDs, if a page falls in that
> range.
> 
> Is the comment to point out use of logging flag under various scenarios?

The comment is because when you look at this function it is not obvious
why we pass logging_active=false, despite logging may actually be
active.  This could suggest that the parameter to stage2_set_pte()
should be named differently (break_huge_pmds) or something like that,
but we can also be satisfied with the comment.

> 
> Should I add comments on flag use in other places as well?
> 

It's always a judgement call.  I didn't find it necessarry to put a
comment elsewhere because I think it's pretty obivous that we would
never care about logging writes to device regions.

However, this made me think, are we making sure that we are not marking
device mappings as read-only in the wp_range functions?  I think it's
quite bad if we mark the VCPU interface as read-only for example.

-Christoffer
