From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 16 Jan 2013 17:41:00 +0530
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to
 architectural requirements
In-Reply-To: <20130116114912.GB1963@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
 <50F64DC7.6040707@ti.com> <20130116114912.GB1963@linaro.org>
Message-ID: <50F698D4.2050702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 January 2013 05:19 PM, Dave Martin wrote:
> On Wed, Jan 16, 2013 at 12:20:47PM +0530, Santosh Shilimkar wrote:
>> + Catalin, RMK
>>
>> Dave,
>>
>> On Tuesday 15 January 2013 10:18 PM, Dave Martin wrote:
>>> For architectural correctness even Strongly-Ordered memory accesses
>>> require barriers in order to guarantee that multiple CPUs have a
>>> coherent view of the ordering of memory accesses.
>>>
>>> Virtually everything done by this early code is done via explicit
>>> memory access only, so DSBs are seldom required.  Existing barriers
>>> are demoted to DMB, except where a DSB is needed to synchronise
>>> non-memory signalling (i.e., before a SEV).  If a particular
>>> platform performs cache maintenance in its power_up_setup function,
>>> it should force it to complete explicitly including a DSB, instead
>>> of relying on the bL_head framework code to do it.
>>>
>>> Some additional DMBs are added to ensure all the memory ordering
>>> properties required by the race avoidance algorithm.  DMBs are also
>>> moved out of loops, and for clarity some are moved so that most
>>> directly follow the memory operation which needs to be
>>> synchronised.
>>>
>>> The setting of a CPU's bL_entry_vectors[] entry is also required to
>>> act as a synchronisation point, so a DMB is added after checking
>>> that entry to ensure that other CPUs do not observe gated
>>> operations leaking across the opening of the gate.
>>>
>>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>>> ---
>>
>> Sorry to pick on this again but I am not able to understand why
>> the strongly ordered access needs barriers. At least from the
>> ARM point of view, a strongly ordered write will be more of blocking
>> write and the further interconnect also is suppose to respect that
>
> This is what I originally assumed (hence the absence of barriers in
> the initial patch).
>
>> rule. SO read writes are like adding barrier after every load store
>
> This assumption turns out to be wrong, unfortunately, although in
> a uniprocessor scenario is makes no difference.  A SO memory access
> does block the CPU making the access, but explicitly does not
> block the interconnect.
>
I suspected the interconnect part when you described the barrier
need for SO memory region.

> In a typical boot scenario for example, all secondary CPUs are
> quiescent or powered down, so there's no problem.  But we can't make
> the same assumptions when we're trying to coordinate between
> multiple active CPUs.
>
>> so adding explicit barriers doesn't make sense. Is this a side
>> effect of some "write early response" kind of optimizations at
>> interconnect level ?
>
> Strongly-Ordered accesses are always non-shareable, so there is
> no explicit guarantee of coherency between multiple masters.
>
This is where probably issue then. My understanding is exactly
opposite here and hence I wasn't worried about multi-master
CPU scenario since sharable attributes would be taking care of it
considering the same page tables being used in SMP system.

ARM documentation says -
------------
Shareability and the S bit, with TEX remap
The memory type of a region, as indicated in the Memory type column of 
Table B3-12 on page B3-1350, provides
the first level of control of whether the region is shareable:
? If the memory type is Strongly-ordered then the region is Shareable
------------------------------------------------------------

> If there is only one master, it makes no difference, but if there
> are multiple masters, there is no guarantee that they are conntected
> to a slave device (DRAM controller in this case) via a single
> slave port.
>
See above. We are talking about multiple CPUs here and not
the DSP or other co-processors. In either case we are discussing
code which is getting execute on ARM CPUs so we can safely limit
it to the multi-master ARM CPU.

> The architecture only guarantees global serialisation when there is a
> single slave device, but provides no way to know whether two accesses
> from different masters will reach the same slave port.  This is in the
> realms of "implementation defined."
>
> Unfortunately, a high-performance component like a DRAM controller
> is exactly the kind of component which may implement multiple
> master ports, so you can't guarantee that accesses are serialised
> in the same order from the perspective of all masters.  There may
> be some pipelining and caching between each master port and the actual
> memory, for example.  This is allowed, because there is no requirement
> for the DMC to look like a single slave device from the perspective
> of multiple masters.
>
> A multi-ported slave might provide transparent coherency between master
> ports, but it is only required to guarantee this when the accesses
> are shareable (SO is always non-shared), or when explicit barriers
> are used to force synchronisation between the device's master ports.
>
> Of course, a given platform may have a DMC with only one slave
> port, in which case the barriers should not be needed.  But I wanted
> this code to be generic enough to be reusable -- hence the
> addition of the barriers.  The CPU does not need to wait for a DMB
> to "complete" in any sense, so this does not necessarily have a
> meaningful impact on performance.
>
> This is my understanding anyway.
>
>> Will you be able to point to specs or documents which puts
>> this requirement ?
>
> Unfortunately, this is one of this things which we require not because
> there is a statement in the ARM ARM to say that we need it -- rather,
> there is no statement in the ARM ARM to say that we don't.
>
Thanks a lot for elaborate answer. It helps to understand the rationale
at least.

Regards
Santosh
