From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jun 2013 12:32:37 +0100
Subject: [PATCH 02/10] ARM: tlb: don't perform inner-shareable
 invalidation for local TLB ops
In-Reply-To: <51BA064B.7010204@arm.com>
References: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
 <1370528914-17506-3-git-send-email-will.deacon@arm.com>
 <51BA064B.7010204@arm.com>
Message-ID: <20130618113237.GC5893@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 06:50:03PM +0100, Jonathan Austin wrote:
> Hi Will,

Hi Jonny,

> On 06/06/13 15:28, Will Deacon wrote:
> > Inner-shareable TLB invalidation is typically more expensive than local
> > (non-shareable) invalidation, so performing the broadcasting for
> > local_flush_tlb_* operations is a waste of cycles and needlessly
> > clobbers entries in the TLBs of other CPUs.
> >
> > This patch introduces __flush_tlb_* versions for many of the TLB
> > invalidation functions, which only respect inner-shareable variants of
> > the invalidation instructions. This allows us to modify the v7 SMP TLB
> > flags to include *both* inner-shareable and non-shareable operations and
> > then check the relevant flags depending on whether the operation is
> > local or not.
> 
> I think this approach leaves us in trouble for some SMP_ON_UP cores as 
> the IS versions of the instructions don't exist for them.
> 
> Is there something that should be ensuring your new __flush_tlb* 
> functions don't get called for SMP_ON_UP? If not it looks like we might 
> need to do some runtime patching with the ALT_SMP/ALT_UP macros...

Well spotted. Actually, the best fix here is no honour the tlb flags we end
up with, since they get patched by the SMP_ON_UP code (which forces
indirection via MULTI_TLB). We should extract the `meat' of the local_ ops
into __local_ops, which can be inlined directly into the non-local variants
without introducing additional barriers around the invalidation operations.

> A follow on question is whether we still need to keep the *non* unified 
> TLB maintenance operations (eg DTLBIALL, ITLBIALL). As far as I can see 
> looking in to old TRMs, the last ARM CPU that didn't automatically treat 
> those I/D ops to unified ones was ARM10, so not relevant here...

My reading of the 1136 TRM is that there are separate micro-tlbs and a
unified main tlb. I don't see any implication that an operation on the
unified tlb automatically applies to both micro-tlbs, but I've not checked
the rtl (the implication holds the other way around).

Will
