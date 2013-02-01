From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 13:20:12 +0000
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <510BBD46.9020207@ti.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com> <20130201113233.GJ23505@n2100.arm.linux.org.uk>
 <510BAA8B.1030506@ti.com> <20130201124807.GK23505@n2100.arm.linux.org.uk>
 <510BBD46.9020207@ti.com>
Message-ID: <20130201132012.GM23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 06:34:06PM +0530, Santosh Shilimkar wrote:
> On Friday 01 February 2013 06:18 PM, Russell King - ARM Linux wrote:
>> On Fri, Feb 01, 2013 at 05:14:11PM +0530, Santosh Shilimkar wrote:
>>> On Friday 01 February 2013 05:02 PM, Russell King - ARM Linux wrote:
>>>> On Fri, Feb 01, 2013 at 04:59:44PM +0530, Santosh Shilimkar wrote:
>>>>> Now since we are moving the code under common place, probably we should
>>>>> update this a function a bit so that it invalidates the CPU cache till
>>>>> line of unification. Just to be consistent with other flush API.
>>>>
>>>> Hmm.  Do you really want a CPU being brought up to do that to the PoU,
>>>> every time that it is brought up?  I thought you wanted to get rid of
>>>> that kind of stuff from the hotplug paths so that a CPU being brought
>>>> up/taken down doesn't affect the caches for the other CPUs within the
>>>> inner sharable domain.
>>>>
>>> You are right. We already git rid of the flush of all cache levels
>>> in hotplug and wakeup paths and now it is restricted till the PoU.
>>>
>>> Assuming for the current v7 machines, PoU is L2, invalidating the cache
>>> *till* PoU means only CPU local cache. So the API will in a way
>>> invalidate only local cache.
>>
>> Err, you want to _invalidate_ the caches down to the point of I/D/TLB
>> unification?  Are you really sure you want to do that on a system
>> here other CPUs are running?
>>
>> Even going down to the LoUIS, that point is the point at which the
>> _other_ CPUs may be sharing caches.
>>
>> And invalidating those caches while the other CPUs are running on
>> secondary CPU startup will be VERY VERY VERY bad.
>>
> Absolutly and my intention was never to invalidate all the cache
> levels. When I said lous, I mean till that point and not including
> that and next cache levels. May be my terminology isn't accurate.

Confused.  Can't find the term "lous" in your previous mails.  I'll
assume you mean LoUIS.  I'm saying that's totally wrong because going
down to that point _includes_ the other CPUs in the system.

What we should be doing on secondary CPU bringup for CPUs where the
caches are in an unknown state is invalidating those caches which are
local to _that_ _CPU_ _only_.  That is not "all cache levels down to
LoUIS".

Here's an example.  CPU0-3 are in the inner sharable domain.

+----------+ +----------+ +----------+ +----------+
|   CPU0   | |   CPU1   | |   CPU2   | |   CPU3   |
+----------+ +----------+ +----------+ +----------+
   |    |       |    |       |    |       |    |
+--v-+--v-+  +--v-+--v-+  +--v-+--v-+  +--v-+--v-+
|CL0I|CL0D|  |CL0I|CL0D|  |CL0I|CL0D|  |CL0I|CL0D| <-- cache level 0
+----+----+  +----+----+  +----+----+  +----+----+
   |    |       |    |       |    |       |    |
   |    |   +---+    +--+    |    |       |    +------------------+
   |    |   |           |    |    +-------|--------------+        |
   |    |   |        +-------+            |              |        |
   |    |   |        |  +-----------------|-----+        |        |
   |    |   |        |        +-----------+     |        |        |
   |    +---|--------|--------|--------+        |        |        |
+--v--------v--------v--------v--+  +--v--------v--------v--------v--+
|            CL1I                |  |            CL1D                | level 1
+--------------------------------+  +--------------------------------+
                 |                                   |            
+----------------v-----------------------------------v---------------+
|                                 CL2                                | level 2
+--------------------------------------------------------------------+

Therefore, because the point of unification for the inner sharable domain
is defined as the point at which the I, D and TLB streams (TLB not shown)
are combined, this happens@CL2, and does *not* include CL2.  CL2 is
where the two paths see the same data.

So, the LoUIS includes caches in level 0 and level 1.

However, CL1 _is_ shared between CPU0-3 - it is part of the inner sharable
domain.  If you invalidate CL1, then you're destroying data held there by
the other CPUs.  So, invalidating down to the LoUIS on secondary CPU
bringup is _wrong_.
