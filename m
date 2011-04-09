From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 9 Apr 2011 11:57:57 +0300
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in for
	device accesses
In-Reply-To: <BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
Message-ID: <BANLkTi=37p-BWpzF2KT4J8PO+xEWrRjDfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 7 April 2011 10:07, Ming Lei <tom.leiming@gmail.com> wrote:
> 2011/3/29 Catalin Marinas <catalin.marinas@arm.com>:
>> On Tue, 2011-03-29 at 16:02 +0100, Martin Furmanski wrote:
>>> Do you have a reference on this?
>>
>> Usually the ARM ARM but a document with examples is this:
>>
>> http://infocenter.arm.com/help/topic/com.arm.doc.genc007826/Barrier_Litmus_Tests_and_Cookbook_A08.pdf
>
> After glancing over the above, I find DSB is only applied in the WFE/WFI
> example in section 6, but all other examples in this section do use DMB.
>
> So could you point out which example is the reference for the mandatory DSB
> wrt. read memory barrier?

Probably the above document isn't comprehensive enough. It mainly
targets memory ordering between processors. I think another example
that mentions DSB is the mailbox scenario.

Anyway, my patch is based on the discussions I had with the person
that wrote the above document (and the ARM ARM).

>>> I have been under the impression that DMB is a barrier for all memory
>>> accesses. I find no support in ARMv7, for the hypothesis that DSB is
>>> needed to order between Device and Normal.
>>
>> The key point is that DMB only ensures the *observability* of memory
>> accesses by the processors and not arrival to the device or block of
>
> How could you conclude that the memory accesses order is different with
> the order of memory requests observed on the same type of memory?

I don't fully understand your question. But I'll give an example where
the DMB fails.

Let's assume we have a device that performs the two steps below:

1. Writes data to RAM
2. Updates its status register

A driver running on the CPU has some code as below:

    LDR [Device]    @ read the device status
    DMB               @ current barrier that we have in readl
    TST                 @ check whether the DMA transfer is ready
    BEQ out
    LDR [Normal]    @ read the DMA buffer
    ...
out:

With the code above, the CPU may do the following steps:

1. Issue read from the device. Note that it does not wait for the read
to complete.
2. DMB - ensures that no subsequent memory accesses happen before the
previous ones.
3. Issues read from normal memory speculatively. This is allowed
because the TST/BEQ are only flow control dependency. In case the
condition fails, the read is discarded.
4. The read from Normal memory (DMA buffer) completes. This could
happen before the I/O read at point 1 depending on the bus speeds.
5. The Device read completes. This can happen after the Normal read
because of different bus speeds.
6. TST clears CPSR.Z
7. BEQ not executed.
8. Normal read data moved to register.

So, even if the CPU issues the read from Device and Normal memory in
order (steps 1, 3), they can happen at the device and RAM level out of
order (steps 4, 5) and the CPU could read data not yet written by the
device.

The solution is to use a DSB which ensures the completion of the
Device read before issuing the Normal memory read.

Note that if the device would update the ready state in some
memory-mapped register via the same port as the CPU, a DMB would be
enough (IOW, ordering ensured only for accesses initiated by bus
masters).

Hope this helps.

-- 
Catalin
