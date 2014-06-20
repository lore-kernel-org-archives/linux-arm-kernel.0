From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 20 Jun 2014 14:23:48 +0100
Subject: [PATCH V4 2/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <20140620092135.GK25104@arm.com>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
 <1402929159-11028-3-git-send-email-steve.capper@linaro.org>
 <20140620092135.GK25104@arm.com>
Message-ID: <20140620132347.GA8038@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:21:35AM +0100, Will Deacon wrote:
> On Mon, Jun 16, 2014 at 03:32:39PM +0100, Steve Capper wrote:
> > For LPAE, we have the following means for encoding writable or dirty
> > ptes:
> >                               L_PTE_DIRTY       L_PTE_RDONLY
> >     !pte_dirty && !pte_write        0               1
> >     !pte_dirty && pte_write         0               1
> >     pte_dirty && !pte_write         1               1
> >     pte_dirty && pte_write          1               0
> > 
> > So we can't distinguish between writable clean ptes and read only
> > ptes. This can cause problems with ptes being incorrectly flagged as
> > read only when they are writable but not dirty.
> > 
> > This patch re-introduces the L_PTE_WRITE bit for both short descriptors
> > and long descriptors, by reverting
> >   36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
> > 
> > For short descriptors the L_PTE_RDONLY bit is renamed to L_PTE_WRITE
> > and the pertinent logic changed. For long descriptors, L_PTE_WRITE is
> > implemented as a new software bit.
> > 
> > HugeTLB pages will use the L_PTE_WRITE semantics automatically.
> > 
> > We need to add some logic to Transparent HugePages to ensure that they
> > correctly interpret the revised pgprot permissions.
> 
> I think this look alright, but it certainly needs some stress testing. Have
> you given it a good hammering? If so, this could use some exposure in -next.

Thanks, I have given this a good going over on an Arndale board with
LPAE and classic MMU. The ltp mm tests pass as do libhugetlbfs and a
THP PROT_NONE test (for LPAE).

At Linaro we have this patch running through CI tests with big endian,
and it appears to be behaving itself.

I would certainly feel more comfortable giving this a good run in next,
to maximise its exposure.

If the first patch in the series is found to be reasonable, should I
put this into Russell's system to go in next?

> 
>   Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks.

> 
> Will
