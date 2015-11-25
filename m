From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2015 18:08:45 +0000
Subject: [PATCH] arm64: mm: Prevent the initial page table setup from
 creating larger blocks
In-Reply-To: <5655E274.80103@arm.com>
References: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
 <5655E274.80103@arm.com>
Message-ID: <20151125180843.GG3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 10:31:48AM -0600, Jeremy Linton wrote:
> On 11/24/2015 11:48 AM, Catalin Marinas wrote:
> >While the ARM ARM is not entirely clear, over the years we have assumed
> >that we can split a large block entry (pmd/pud) into smaller blocks
> >pointing to the same physical address with little risk of a TLB
> >conflict. However, remapping a smaller blocks range as a large one (e.g.
> >from page to sections or to contiguous pages) implies a high risk of TLB
> >conflict. Excessive TLB flushing would make the window smaller but it
> >would not remove the issue.
> 
> 	Is a requirement of this assumption, that the kernel isn't running on a
> VM'ed host with small page mappings? AKA the hypervisor is providing smaller
> page sizes than guest linear mapping?

The assumption is not even endorsed by the ARM ARM, so it can probably
be further messed by stage 2.

> 	Because I can understand the idea that the CPU won't walk PTEs for entries
> it has a larger translation for, but my understanding of how the TLB's are
> fragmented when the host has a smaller page size means that its potentially
> possible to have multiple TLB entries for different parts of a single
> cont/block range....

Another random assumption is that the TLB entry for a full VA->PA
translation covers the minimum block size between stage 1 and stage 2
(so even smaller block sizes are allowed). We risk a TLB conflict if we
switch from a smaller to a bigger block TLB entry, so under this
assumption I don't see it happening.

Anyway, too many assumptions. The proper fix is break-before-make (when
possible, though not for the kernel linear mapping) or switch to a
temporary TTBR but that's not feasible for 4.4. In the meantime, we have
two options:

1. Avoid creating contiguous PTEs since they have shown such TLB
   conflict behaviour (it doesn't mean it's only this to blame)

2. Add a TLB flush in __populate_init_pte() and hope that we will reduce
   the potential TLB conflict window (as we do for pmd/pud)

Point 2 is not really a fix and it requires more testing on different
platforms. With this patch, I tried a partial solution for point 1. If
we deem this unsafe, I would rather revert the page table setup to what
we had before 4.4 and re-enable the feature in 4.5 together with the
complete fix. AFAICT, we haven't seen any failures prior to 4.4 in this
area (though they could as well be silent). Unfortunately, this means
reverting some of your patches (not all though and the good thing is
that you can merge them again in 4.5 ;)).

-- 
Catalin
