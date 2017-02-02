From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 19:21:32 +0900
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170201160354.GF4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
Message-ID: <20170202102131.GD13549@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > A new function, remove_pgd_mapping(), is added.
> > It allows us to unmap a specific portion of kernel mapping later as far as
> > the mapping is made using create_pgd_mapping() and unless we try to free
> > a sub-set of memory range within a section mapping.
> 
> I'm not keen on adding more page table modification code. It was painful
> enough to ensure that those worked in all configurations.
> 
> Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> and use an invalid prot (i.e. 0), what is the problem?

As I did in v30?
(though my implementation in v30 should be improved.)

> I can see that we wouldn't free/reallocate the pud or pmd entries, but
> the "wasted" memory should be small. If anything, I'd argue that it's
> preferable to keep that around so that we don't have to allocate memory
> when we need to map the crashkernel region.
> 
> Is there another problem I'm missing?

If we don't need to free unused page tables, that would make things
much simple. There are still some minor problems on the merge, but
we can sort it out.

Thanks,
-Takahiro AKASHI

> > +static bool pgtable_is_cleared(void *pgtable)
> > +{
> > +	unsigned long *desc, *end;
> > +
> > +	for (desc = pgtable, end = (unsigned long *)(pgtable + PAGE_SIZE);
> > +	     desc < end; desc++)
> > +		if (*desc)
> > +			return false;
> > +
> > +	return true;
> > +}
> 
> If nothing else, we should be using the normal accessors for this, e.g.
> {pte,pmd,pud}_none().
> 
> As above, I'd very much like to reuse our existing page table routines
> if we can.
> 
> Thanks,
> Mark.
