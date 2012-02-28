From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 28 Feb 2012 08:53:28 +0800
Subject: [PATCH 3/4] ARM: perf: check that we have an event in the PMU IRQ
 handlers
In-Reply-To: <20120227193635.GC24605@mudshark.cambridge.arm.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
 <1330012696-13472-4-git-send-email-will.deacon@arm.com>
 <CACVXFVM6HOMeJCMznLqO6-jMT8owoK65Ap6c_CNCJbwWxphCBA@mail.gmail.com>
 <20120224101130.GB13504@mudshark.cambridge.arm.com>
 <20120227175646.7c39e542@tom-ThinkPad-T410>
 <20120227193635.GC24605@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNVhd_65Kr7h6KEtaOvZ6GmZhA9wz9Xe8z-O2EET=SEGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 3:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Feb 27, 2012 at 09:56:46AM +0000, Ming Lei wrote:
>> Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Feb 24, 2012 at 01:34:32AM +0000, Ming Lei wrote:
>> > >
>> > > I think we should check it via test_bit(idx, cpuc->used_mask) because
>> > > 'hw_events->events[idx] = val' is not atomic operation and it is read here
>> > > in irq context.
>> >
>> > I dunno, that code is compiled to:
>> >
>> > e5973000 ? ? ? ?ldr ? ? r3, [r7]
>> > e7834106 ? ? ? ?str ? ? r4, [r3, r6, lsl #2]
>> >
>> > so you should either see the new value or the old one - you can't see half a
>> > pointer in there since it's a single 32-bit store.
>>
>> Firstly the code above is only generated from one of many existing compile
>> options, for example, maybe storing to 32bit variable involves two instructions
>> in thumb mode, so are you sure it is always OK for all cases?
>
> I'll check with the compiler guys if the tools ever do this. It would seem a
> bit weird given that we may have things like memory type, alignment and
> endianness coming into play that would make splitting up 32-bit stores a
> really bad idea.
>
>> Secondly, I am even not sure if ARM irq handler is always triggered in instruction
>> boundary, maybe the irq handler is started during execution of the store instruction.
>> In fact, I can find the sentence below in 'B1.6.16 IRQ exception' of ARMv7 manual:
>>
>> ? ? ? This relaxation of the normal definition of a precise asynchronous exception
>> ? ? ? permits interrupts to occur during the execution of instructions that change register
>> ? ? ? or memory values, while only requiring the implementation to restore those register
>> ? ? ? values that are needed to correctly re-execute the instruction after the preferred
>> ? ? ? exception return. LDM and STM are examples of such instructions.
>
> A single 32-bit store is not interruptible in the same way as load/store
> multiple instructions are, so this isn't a problem.

In fact, I have tried to look for the similar description in ARMv7 manual, but
didn't find it unfortunately, so could you point out where it is
stated explicitly?

>
>> So suggest to take the correct way in theory, IMO.
>
> I don't like checking the used_mask, because then we have to throw in some
> barriers to ensure ordering between updates of the event arrays and the
> mask. If we do have to change something, I think putting ACCESS_ONCE around

Both used_mask and event arrays are defined as percpu variables, so are you sure
barriers are required for it?

> updates to the event array should do the trick.


thanks,
-- 
Ming Lei
