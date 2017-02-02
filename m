From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 23:01:03 +0900
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170202114437.GH31394@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
Message-ID: <20170202140102.GA22666@fireball>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 11:44:38AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 07:21:32PM +0900, AKASHI Takahiro wrote:
> > On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > > > A new function, remove_pgd_mapping(), is added.
> > > > It allows us to unmap a specific portion of kernel mapping later as far as
> > > > the mapping is made using create_pgd_mapping() and unless we try to free
> > > > a sub-set of memory range within a section mapping.
> > > 
> > > I'm not keen on adding more page table modification code. It was painful
> > > enough to ensure that those worked in all configurations.
> > > 
> > > Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> > > and use an invalid prot (i.e. 0), what is the problem?
> > 
> > As I did in v30?
> > (though my implementation in v30 should be improved.)
> 
> Something like that. I wasn't entirely sure why we needed to change
> those functions so much, so I'm clearly missing something there. I'll go
> have another look.

I would be much easier if you see my new code.

> > > I can see that we wouldn't free/reallocate the pud or pmd entries, but
> > > the "wasted" memory should be small. If anything, I'd argue that it's
> > > preferable to keep that around so that we don't have to allocate memory
> > > when we need to map the crashkernel region.
> > > 
> > > Is there another problem I'm missing?
> > 
> > If we don't need to free unused page tables, that would make things
> > much simple. There are still some minor problems on the merge, but
> > we can sort it out.
> 
> I'm not sure I follow what you mean by 'on merge' here. Could you
> elaborate?

What I had in mind is some changes needed to handle "__prot(0)" properly
in alloc_init_pxx(). For example, p[mu]d_set_huge() doesn't make
a "zeroed" entry.

-Takahiro AKASHI

> Thanks,
> Mark.
