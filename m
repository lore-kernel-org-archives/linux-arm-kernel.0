From: dave.long@linaro.org (David Long)
Date: Wed, 16 Apr 2014 19:19:44 -0400
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416222548.GL24070@n2100.arm.linux.org.uk>
References: <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
 <534EE6F2.3050005@linaro.org>
 <20140416.172153.646525167994615191.davem@davemloft.net>
 <20140416222548.GL24070@n2100.arm.linux.org.uk>
Message-ID: <534F1010.8080605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/14 18:25, Russell King - ARM Linux wrote:
> On Wed, Apr 16, 2014 at 05:21:53PM -0400, David Miller wrote:
>> Weird, if we store to the kernel side it should be just a matter of
>> clearing the I-cache out.  There should be no D-cache aliasing
>> whatsoever.  Maybe you could print out area->vaddr and
>> page_to_virt(area->page) so we can see if area->vaddr is choosen
>> correctly?
>>
>> Although I notice that flush_cache_user_range() on ARM flushes both D
>> and I caches.  And I think that's what userspace ends up triggering
>> when it uses the system call that exists to support self-modifying and
>> JIT code generators.
>>
>> An ARM expert will have to chime in...
> 
> So, David's patch is against the existing kernel (I checked the blob ID
> in the patch.)

Sorry, that patch was against my uprobes-v7 branch which means it was v3.14-rc5
plus the uprobes work you pulled from me for v3.15.  Thanks for reminding me
it's time to update my repo.

> It looks like David just replaced flush_dcache_page() with
> flush_icache_all() as a hack. So my question is... between
> flush_dcache_page() and flush_icache_all(), what was the intermediary
> (if any) that was attempted?

The other combinations I tried were: 1) existing dcache flush followed by
flush_icache_all, which works;  2) existing dcache flush followed by:

	flush_icache_range(xol_vaddr, sizeof uprobe->arch.ixol);

...which also worked (xol_vaddr is the beginning of the two instruction
out-of-line sequence, and the sizeof works out to be 8).

I didn't bother trying flush_icache_user_range() because that is #define'd
to be just flush_dcache_page() on ARM, which I don't understand at all.

> 
> Now, I'm going to fill in some details for DaveM.  The type of the I/D
> L1 caches found on any particular architecture version of CPU can be:
> 
> Arch	D-cache			I-cache
> ARMv7	VIPT nonaliasing	VIVT ASID tagged
> 				PIPT
> -------------------------------------------------
> ARMv6	VIPT nonalising		VIPT nonaliasing
> 	VIPT aliasing		VIPT aliasing
> -------------------------------------------------
> ARMv5	VIVT			VIVT
> &older
> 
> (For ARMv6, each can be either/or, though practically, there's no point
> to I-aliasing and D-nonaliasing since it implies the I-cache is bigger
> than the D-cache.)
> 
> Our I-caches don't snoop/see the D-cache at all - so writes need to be
> pushed out to what we call the "point of unification" where the I and D
> streams meet.  For anything we care about, that's normally the L2 cache -
> L1 cache is harvard, L2 cache is unified.
> 
> Hence, we don't care which D-alias (if any) the data is written, so long
> as it's pushed out of the L1 data cache so that it's visible to the L1
> instruction cache.
> 
> If we're writing via a different mapping to that which is being executed,
> I think the safest thing to do is to flush it out of the L1 D-cache at
> the address it was written, and then flush any stale line from the L1
> I-cache using the user address.  This is quite a unique requirement, and
> we don't have anything which covers it.  The closest you could get is
> to that using existing calls is:
> 
> 1. write the new instruction
> 2. flush_dcache_page()
> 3. flush_cache_user_range() using the user address
> 
> and I think that should be safe on all the above cache types.
> 

OK, still needing the dcache flush makes sense to me.  I thought I was
reading from (the other) David that it shouldn't be necessary, but I
could not understand why.

-dl
