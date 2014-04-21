From: dave.long@linaro.org (David Long)
Date: Mon, 21 Apr 2014 12:16:42 -0400
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416222548.GL24070@n2100.arm.linux.org.uk>
References: <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
 <534EE6F2.3050005@linaro.org>
 <20140416.172153.646525167994615191.davem@davemloft.net>
 <20140416222548.GL24070@n2100.arm.linux.org.uk>
Message-ID: <5355446A.9080302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/14 18:25, Russell King - ARM Linux wrote:

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

It doesn't feel to me like we yet have a clear consensus on the appropriate
near or long-term fix for this problem.  I'm worried time is short to get a
fix in for v3.15.  I'm not sure how elegant that fix needs to be.  I've gotten
good test runs using a modified/simplified version of Victor's arch callback
and a slight variation of Russell's sequence of operations from above:

void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
			const void *src, int len)
{
	void *kaddr = kmap_atomic(page);

#ifdef CONFIG_SMP
	preempt_disable();
#endif
	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
	clean_dcache_area(kaddr, len);
	flush_cache_user_range(vaddr, vaddr + len);
#ifdef CONFIG_SMP
	preempt_enable();
#endif
	kunmap_atomic(kaddr);
}


I have to say using clean_dcache_area() to write back the two words that changed
(and rest of the cache line of course) seems more appropriate than flushing a
whole page.  Are there implications in doing that which makes this a bad idea
though?

At any rate, for v3.15 do we want to persue the more complex solutions with
"congruent" mappings and use of copy_to_user(), or just something like the above
(plus the rest of Victors v3 patch)?  I'm sure Oleg is even less happy than me
about yet another arch_ callback but we can hold out the hope that a more elegant
solution can follow in the next release.  One that might introduce risk we can't
accept in v3.15 right now (e.g.: mapping the xol area writeable for all
architectures).

I have also tested (somewhat) both Victor's unmodified v3 and v4 patches on
exynos 5250 and found them to work.

Thanks,
-dl
