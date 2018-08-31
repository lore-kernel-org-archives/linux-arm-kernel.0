From: npiggin@gmail.com (Nicholas Piggin)
Date: Fri, 31 Aug 2018 11:23:48 +1000
Subject: [PATCH 09/12] asm-generic/tlb: Track which levels of the page
 tables have been cleared
In-Reply-To: <1535645747-9823-10-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <1535645747-9823-10-git-send-email-will.deacon@arm.com>
Message-ID: <20180831112348.55d3d2ec@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 17:15:43 +0100
Will Deacon <will.deacon@arm.com> wrote:

> It is common for architectures with hugepage support to require only a
> single TLB invalidation operation per hugepage during unmap(), rather than
> iterating through the mapping at a PAGE_SIZE increment. Currently,
> however, the level in the page table where the unmap() operation occurs
> is not stored in the mmu_gather structure, therefore forcing
> architectures to issue additional TLB invalidation operations or to give
> up and over-invalidate by e.g. invalidating the entire TLB.
> 
> Ideally, we could add an interval rbtree to the mmu_gather structure,
> which would allow us to associate the correct mapping granule with the
> various sub-mappings within the range being invalidated. However, this
> is costly in terms of book-keeping and memory management, so instead we
> approximate by keeping track of the page table levels that are cleared
> and provide a means to query the smallest granule required for invalidation.

Actually the generic patches are pretty simple, and they look okay to
me. powerpc *should* be able to switch to Peter's patch with a few
lines of code with unchanged functionality as far as I can see.

These flags we may use as well, but even if not if x86 and arm64 are
using it, it seems reasonable to go in generic code for now. For the
3 generic patches,

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
