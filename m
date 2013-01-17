From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Jan 2013 12:09:29 +0530
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to
 architectural requirements
In-Reply-To: <20130116150533.GA31318@arm.com>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
 <50F64DC7.6040707@ti.com> <20130116150533.GA31318@arm.com>
Message-ID: <50F79CA1.9050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 January 2013 08:35 PM, Catalin Marinas wrote:
> Santosh,
>
> On Wed, Jan 16, 2013 at 06:50:47AM +0000, Santosh Shilimkar wrote:
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
>>
>> Sorry to pick on this again but I am not able to understand why
>> the strongly ordered access needs barriers. At least from the
>> ARM point of view, a strongly ordered write will be more of blocking
>> write and the further interconnect also is suppose to respect that
>> rule. SO read writes are like adding barrier after every load store
>> so adding explicit barriers doesn't make sense. Is this a side
>> effect of some "write early response" kind of optimizations at
>> interconnect level ?
>
> SO or Device memory accesses are *not* like putting a proper barrier
> between each access, though it may behave in some situations like having
> a barrier. The ARM ARM (A3.8.3, fig 3.5) defines how accesses must
> *arrive* at a peripheral or block of memory depending on the memory type
> and in case of Device or SO we don't need additional barriers because
> such accesses would *arrive* in order (given the minimum 1KB range
> restriction). But it does not say anything about *observability* by a
> different *master*. That's because you can't guarantee that your memory
> accesses go to the same slave port.
>
> For observability by a different master, you need an explicit DMB even
> though the memory type is Device or SO. While it may work fine in most
> cases (especially when the accesses by various masters go to the same
> slave port), you can't be sure what the memory controller or whatever
> interconnect do.
>
I agree that the interconnect behavior and no. of slave port usages
is implementation specific and we can't assume anything here. So
safer side is to have those additional barriers to not hit the corner
cases.

> As Dave said, it's more about what the ARM ARM doesn't say rather than
> what it explicitly states.
>
I understand it better now. Thanks for good discussion.

Regards,
Santosh
