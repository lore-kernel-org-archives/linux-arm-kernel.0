From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jan 2016 16:07:16 +0000
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <56A77D37.10107@huawei.com>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5695DA67.5080201@huawei.com> <56A77D37.10107@huawei.com>
Message-ID: <20160126160715.GB29086@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:05:43PM +0800, zhong jiang wrote:
> Hi, Mark,
> 
> I have some confuse about the tlb conflict when split from 2M block to 4K pages.
> I think if core A starts to split page table from 2M to 4K pages, with the
> operation __sync_icache_dcache to make sure flush the pte to PoU.

I don't follow why you would use __sync_icache_dcache here. This has
nothing to do with the I-cache (as the VA->PA mappings stay the same at
splitting time). 

For ARMv8 (or ARMv7 with ID_MMFR3.CohWalk > 0), the TLB walks are fully
coherent, and do not require page tables to be cleaned to the PoU in
order to be visible.

> Other core will have three kinds of situation:
> 
> 1. have the old pmd cached in tlb, so it will see the old physical address.

The presence of the old entry in the TLB does not guarantee that the new
entry cannot also be allocated. The TLB can allocate a new TLB entry at
any point in time for any active, valid page table entry (or combination
of entries).

For instance, perhaps when walking the page tables, the walker allocates
TLB entries for all valid page table entries in the same cache line, on
the assumption that future accesses are likely to be nearby in the VA
space. The TLB might handle duplicate (identical) entries by design, but
not conflicting ones. For this case, a (speculative) walk of of a nearby
page could result in allocation of a conflicting entry.

> 2. have no old pmd cached in tlb, it will see the new entry when
>  __sync_icache_dcache is over.

The TLB can fetch any valid, active entry at any time.

It could fetch the old value from memory before the write was completed,
then a subsequent fetch of the new value could occur. This devolves into
the case I describe above for (1).

> 3. have no old pmd cached in tlb, it maybe see the old entry before
> __sync_icache_dcache is over. But, if the core A finish tlbi and dsb sy, all
> the tlbs will see the new pte.

The TLB can fetch any valid, active entry at any time. It could fetch
the old entry, then the new entry, before the TLB maintenance completes.

If other asynchronous logic (e.g. speculative execution, I-cache
fetches, or page table walks) uses the results of an amalgamated
translation, the CPU may access a physical address that was not intended
to be accessed (perhaps resulting in an SError), or could allocate the
wrong data into caches or TLBs, leading to further issues.

The same problem applies as with (2), which devolves to (1).

> In my opinion, It seems that the below example will only trigger tlb conflict
> when merging to huge page.
> 
> For example, without BBM a page table update would look something like:
>  1)	str	<newpte>, [<*pte>]
>  2)	dsb	ish
>  3)	tlbi	vmalle1is
>  4)	dsb	ish
>  5)	isb
> 
> So I have no idea about how to trigger conflict when tlb conflict.
> Can you give some advice and example ?

I have explained above how this may occur, on one possible
implementation. There are many possible problems that I have not
described above, which are avoided by a Break-Before-Make seuqence.

Even in the presence of conflicting entries a CPU might not raise a TLB
conflict. It is also architecturally valid to match one entry, or to
match an amalgamation of the two. So you may not be able to trigger
problems resulting from a conflict on all implementations.

Thanks,
Mark.
