From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 23:28:37 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921213802.GH30821@n2100.arm.linux.org.uk>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>	<1253435940.498.15.camel@pc1117.cambridge.arm.com>	<20090920093139.GA1704@n2100.arm.linux.org.uk>	<20090920190227.GB5413@n2100.arm.linux.org.uk>	<4AB6B0AB.8040307@arm.com>
	<20090921083109.GC20006@shareable.org>	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>	<20090921085425.GC27357@n2100.arm.linux.org.uk>	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
Message-ID: <4AB7FE15.4060804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
>> On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
>>> I would still call this I-D cache coherency issue since the two caches
>>> have a different view of the RAM but I agree that the D-cache is the one
>>> holding the data (with a slight chance for the I-cache not to be in sync
>>> with main RAM, though we could treat it separately).
>>>
>>> We can sort out the D-cache issue with your approach for cleaning it in
>>> the copy_user_highpage() function, but, as I said, we affect the
>>> standard CoW mechanism for data pages quite a lot.
>> Let me restate my approach more clearly:
>>
>> 1. Remember that a VMA has been executable.
>> 2. Only do the additional handing if the VMA has been executable.
> 
> Well, there's a problem with this approach.  Any binary which executes
> with read-implies-exec (in other words, the majority of those around)
> results in any region with read permission also getting exec permission.
> 
> So, mprotect(rw) actually ends up as mprotect(rwx), which means that
> effectively _all_ VMAs have been executable.
> 
> This approach won't work as well as I'd hope, since this means every
> COW fault ends up triggering the cache flush.
> 
> However, the same problem affects Catalin's approach too - with these
> binaries, every VMA has VM_EXEC set, which means every VMA gets the
> cache flushing treatment whenever flush_cache_range() is called.

In this case, I don't have a better solution, other than optimising the 
coherent_user_range function in my patch to avoid generating page faults 
(and run some benchmarks).

Of course, we could improve the generic mm/ code but that's not easy to 
merge as it affects other architectures.

> This is a nasty problem to solve...

I agree.

-- 
Catalin
