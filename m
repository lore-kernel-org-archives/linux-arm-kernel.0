From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 1 Nov 2018 09:31:21 +0100
Subject: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for
 adjustment
In-Reply-To: <87h8h2rwwr.fsf@e105922-lin.cambridge.arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
 <20181001155443.23032-2-punit.agrawal@arm.com>
 <20181031143646.GE12057@e113682-lin.lund.arm.com>
 <87h8h2rwwr.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20181101083121.GG12057@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 02:52:20PM +0000, Punit Agrawal wrote:
> Christoffer Dall <christoffer.dall@arm.com> writes:
> 
> > On Mon, Oct 01, 2018 at 04:54:35PM +0100, Punit Agrawal wrote:
> >> PageTransCompoundMap() returns true for hugetlbfs and THP
> >> hugepages. This behaviour incorrectly leads to stage 2 faults for
> >> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
> >> treated as THP faults.
> >> 
> >> Tighten the check to filter out hugetlbfs pages. This also leads to
> >> consistently mapping all unsupported hugepage sizes as PTE level
> >> entries at stage 2.
> >> 
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> >> Cc: Christoffer Dall <christoffer.dall@arm.com>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: stable at vger.kernel.org # v4.13+
> >
> >
> > Hmm, this function is only actually called from user_mem_abort() if we
> > have (!hugetlb), so I'm not sure the cc stable here was actually
> > warranted, nor that this patch is strictly necessary.
> >
> > It doesn't hurt, and makes the code potentially more robust for the
> > future though.
> >
> > Am I missing something?
> 
> !hugetlb is only true for hugepage sizes supported at stage 2. The
> function also got called for unsupported hugepage size at stage 2, e.g.,
> 64k hugepage with 4k page size, which then ended up doing the wrong
> thing.
> 
> Hope that adds some context. I should've added this to the commit log.
> 

To be fair you did say that this was for unsupported hugepage sizes.

Thanks for the explanation.


    Christoffer
