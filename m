From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Mar 2011 11:15:45 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110311192455.GA23109@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
	<20110215121437.GG4152@n2100.arm.linux.org.uk>
	<AANLkTindKihW3Hv4gdWakPcBAfFCrnd5wzSXN7K=Ac0h@mail.gmail.com>
	<20110309183507.GB11273@n2100.arm.linux.org.uk>
	<1299864778.7239.57.camel@e102109-lin.cambridge.arm.com>
	<20110311192455.GA23109@n2100.arm.linux.org.uk>
Message-ID: <1300101345.3907.4.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-11 at 19:24 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 11, 2011 at 05:32:58PM +0000, Catalin Marinas wrote:
> > On Wed, 2011-03-09 at 18:35 +0000, Russell King - ARM Linux wrote:
> > > On Wed, Mar 09, 2011 at 03:40:05PM +0000, Catalin Marinas wrote:
> > > > The above call to tlb_add_flush() would only add a PAGE_SIZE. But
> > > > since we free an entire PTE, shouldn't the range cover addr ..
> > > > addr+PTRS_PER_PTE*PAGE_SIZE?
> > >
> > > Why do we need to?  We're not flushing away the individual PTE entries
> > > when we remove an entire page table - we will have already walked the
> > > page table removing those entries, which will already have been added.
> >
> > Ah, I missed the fact that tlb_flush() invalidates the whole TLB when
> > there is no tlb->vma (the shift_arg_pages case). We could optimise this
> > to add the range covered by the PTE page and avoid the !tlb->vma check
> > (and a flush_tlb_mm), though not sure it's worth.
> 
> If we're removing pte entries then tlb->vma is non-NULL.  Please look at
> the comments - I've documented the three modes of use there along with
> how things are setup for each of those modes, and what we do with each.

Yes, I read them (they are useful) and I was only referring to point 3
in the comments, shift_arg_pages(). In this case tlb->vma is NULL and we
flush the full mm in tlb_flush(). Can we have a smaller address range
since we can get the from pte_free_tlb()?

This would mean removing the !tlb->vma check in tlb_flush() and change
tlb_add_flush() to take a range rather than just an address.

-- 
Catalin
