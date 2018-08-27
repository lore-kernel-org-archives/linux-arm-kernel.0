From: npiggin@gmail.com (Nicholas Piggin)
Date: Mon, 27 Aug 2018 14:44:57 +1000
Subject: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
In-Reply-To: <1535125966-7666-9-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-9-git-send-email-will.deacon@arm.com>
Message-ID: <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Aug 2018 16:52:43 +0100
Will Deacon <will.deacon@arm.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Some architectures require different TLB invalidation instructions
> depending on whether it is only the last-level of page table being
> changed, or whether there are also changes to the intermediate
> (directory) entries higher up the tree.
> 
> Add a new bit to the flags bitfield in struct mmu_gather so that the
> architecture code can operate accordingly if it's the intermediate
> levels being invalidated.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

powerpc should be able to move right over to using this rather
than keeping the bit in need_flush_all.

powerpc may be able to use the unmap granule thing to improve
its page size dependent flushes, but it might prefer to go
a different way and track start-end for different page sizes.
I wonder how much of that stuff should go into generic code,
and whether it should instead go into a struct arch_mmu_gather.

Thanks,
Nick
