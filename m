From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 13 Apr 2015 12:11:44 -0700
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150408175533.GN12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
Message-ID: <552C14F0.7020006@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 10:55 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 08, 2015 at 06:36:56PM +0100, Mark Rutland wrote:
>> Hi Russell,
>>
>> On Wed, Apr 08, 2015 at 10:45:30AM +0100, Russell King wrote:
>>> -       /*
>>> -        * Ensure that the above updates are flushed out of the cache.
>>> -        * This is not strictly correct; on a system where the caches
>>> -        * are coherent with each other, but the MMU page table walks
>>> -        * may not be coherent, flush_cache_all() may be a no-op, and
>>> -        * this will fail.
>>> +        * We changing not only the virtual to physical mapping, but
>>> +        * also the physical addresses used to access memory.  We need
>>> +        * to flush all levels of cache in the system with caching
>>> +        * disabled to ensure that all data is written back.  We do this
>>> +        * with caching and write buffering disabled to ensure that
>>> +        * nothing is speculatively prefetched.
>>>           */
>>> +       cr = get_cr();
>>> +       set_cr(cr & ~(CR_I | CR_C | CR_W));
>>
>> SCTLR[3] (CR_W) is RAO/SBOP in VMSAv7. I don't think we should clear it
>> here for ARMv7.
>
> I was in two minds about that - I guess as we're expecting to only run
> this on ARMv7 CPUs, we can omit clearing the CR_W, but I'd need to add
> a comment saying that it's ARMv7 only.
>
Yep. We can do away without the CR_W change.

>> To the best of my knowledge, the page table walkers aren't affected by
>> SCTLR.C, and use the attributes in TTBR{0,1} or TTBCR when translation
>> is active (i.e. when SCTLR.M is set). So at this point they can make
>> cacheable accesses to the page tables (and allocate into the caches) in
>> the background...
>
> We had better clear those bits too then.
>
>> I think that the cache flush needs to be performed after both
>> SCTLR.{C,M} are cleared in lpae_pgtables_remap_asm, just before the page
>> table updates. So long as the relevant pieces of kernel text are
>> initially clean to the PoC, we shouldn't need to flush anything
>> beforehand.
>
> To that I say... no bloody way in hell, even once hell has frozen
> over.  It took almost a _day_ to get this much working, much of it
> was attempting to use cache flushing functions after the MMU had
> been turned off.
>
> If it was possible to make it work, I'd have done so.  It isn't, so
> please forget the idea.
>
I fully agree. I gone through the same pane while incorporating Will's
comment on similar lines last time.

>>> +ENTRY(lpae_pgtables_remap_asm)
>>> +       stmfd   sp!, {r4-r8, lr}
>>> +
>>> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
>>> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
>>> +       mcr     p15, 0, ip, c1, c0, 0
>>> +       dsb
>>> +       isb
>>
>> Shouldn't the DSB be between the STMFD and the MCR (given the SP doesn't
>> point to an idmap/physical address)?
>>
>> I don't see why we need a DSB after the write to the SCTLR.
>>
dsb can be moved up after stmfd but leaving as above should be fine
as well.

>> [...]
>>
>>> +       dsb
>>> +       isb
>>> +
>>> +       mcr     p15, 0, r8, c1, c0, 0           @ re-enable MMU
>>> +       dsb
>>> +       isb
>>
>> Similarly, isn't the last DSB redundant?
>
This dsb probably can be dropped but I leave that to Russell
to decide. That one extra instruction doesn't hurt much.

Regards,
Santosh

> I've really no idea.  All I know is that the above works.  I'm rather
> sick of trying to read the ARM ARM and not understanding exactly what
> ISB and DSB actually do.
>
