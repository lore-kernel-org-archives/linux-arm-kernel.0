From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Mar 2015 11:02:22 -0700
Subject: [PATCH 2/5] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <20150317172930.GY8399@arm.com>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
 <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
 <20150317172930.GY8399@arm.com>
Message-ID: <55086C2E.3030700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/15 10:29, Will Deacon wrote:
> On Sat, Mar 07, 2015 at 12:54:50AM +0000, Florian Fainelli wrote:
>> This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
>> controller. This cache controller sits between the L2 and the memory bus
>> and its purpose is to provide a friendler burst size towards the DDR
>> interface than the native cache line size.
>>
>> The readahead cache is mostly transparent, except for
>> flush_kern_cache_all, flush_kern_cache_louis and flush_icache_all, which
>> is precisely what we are overriding here.
> 
> I'm struggling to understand why you care about flush_kern_cache_louis
> and flush_icache_all for a cache that sits the other side of the L2.
> 
> Can you explain why we need to do anything in these cases, please?

Let's try, as you may have read in the comment, all MVA-based cache
maintenance operations are snooped by the RAC, so they are effectively
"transparent" to software, all others are not.

flush_kern_cache_louis() and flush_icache_all() both use ICALLIUS in the
SMP case and ICIALLU in the UP case which were flagged as not being
transparently handled.

The concern is that, if you perform a L1 cache (data or instruction)
flush (essentially an invalidate), this will also flush (invalidate)
corresponding L2 cache lines, but the RAC has no way to be signaled that
is should also invalidate its own RAC cache lines pertaining to that
data, and RAC holds per-CPU "super" cache lines.

In arch/arm/kernel/smp.c, all uses of flush_cache_louis() are for
writing-back data, so the RAC is not an issue. In
arch/arm/kernel/suspend.c, flush_cache_louis() is known not to guarantee
a "clean" all the way to main memory, so __cpu_flush_dcache_area is used
in conjunction. In arch/arm/mm/idmap.c and mmu.c, the use of
flush_cache_louis() seems to be meant to see fresh data, not write-back,
so not transparent to the RAC, is that right?

It may very well be that we are super cautious here and that the only
case to take care of is essentially flush_cache_all(), and nothing more.

Would you suggestions on how to instrument/exercise whether we really
need to deal with flush_cache_louis() and flush_icache_all()?

Thanks!
-- 
Florian
