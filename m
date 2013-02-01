From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 20:23:43 +0530
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130201144913.GQ23505@n2100.arm.linux.org.uk>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com>
 <20130201121137.GC23869@e102568-lin.cambridge.arm.com>
 <20130201125417.GL23505@n2100.arm.linux.org.uk>
 <20130201141052.GA25172@e102568-lin.cambridge.arm.com>
 <20130201141914.GO23505@n2100.arm.linux.org.uk>
 <20130201143136.GP23505@n2100.arm.linux.org.uk> <510BD496.6080305@ti.com>
 <20130201144913.GQ23505@n2100.arm.linux.org.uk>
Message-ID: <510BD6F7.9070706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013 08:19 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 08:13:34PM +0530, Santosh Shilimkar wrote:
>> On Friday 01 February 2013 08:01 PM, Russell King - ARM Linux wrote:
>>> Just to further provide some insight into the reasoning:
>>>
>>> Invalidating data out of a working cache risks data corruption; maybe
>>> the data being invalidated is filesystem metadata which was about to
>>> be cleaned and written back to storage.  That risks filesystem
>>> corruption.
>>>
>>> Invalidating fewer levels than are actually required is different: we
>>> may leave dirty cache lines behind which may be evicted, but there's
>>> also the chance that the CPU will end up _reading_ from its
>>> uninitialized caches and may crash before that happens.
>>>
>>> So, the risks are:
>>> 1. invalidate more levels than are necessary and risk discarding data
>>>      which other CPUs are using, which may be important data.
>>> 2. invalidate less levels than are necessary and risk writing out
>>>      data from the CPU cache, which may or may not happen _before_ the
>>>      CPU crashes due to reading invalid data.
>>>
>>> Out of those two, (2) sounds to me to be the safer approach.
>>>
>>> Plus, I can't think of a reason why you'd want to put on a SMP system
>>> more than one layer of CPU local caches... to do so would seem to me to
>>> be an exercise in coherency complexity...  So, I suspect that in the
>>> real world, we will _never_ see any system which has more than one
>>> layer of caches local to the CPU.  But we may see a system with a
>>> cache architecture similar to the one I drew in my email to Santosh.
>>>
>> I still scratching my head on why you would even have a CPU design
>> with two L2 shared caches for a 4 CPU system.
>>
>> If you ever design such a system, you need to ensure that
>>
>> 1. Both L2 are used in exclusive mode
>> 2. Both L2 cache has coherency hardware connected to keep them in sync
>> for shared data.
>>
>> For 1, one would just increase the size of L2 and have only 1 memory.
>>
>> 2 Doesn't bring much advantage unless and until your L3 is too far
>> away for access in terms of CPU access cycles.
>
> I don't think you quite understood my diagram.  There aren't two separate
> L2 data caches (CL1I and CL1D).  I'm showing the L2 cache as having a
> harvard structure (separate instruction and data) with no coherency
> between them - and because they're harvard structured, that means the
> unification level must be _below_ that point.
>
Now I get it. Yes I missed the I and D separation in the diagram.
Thanks a lot for drawing.

Regards,
Santosh
