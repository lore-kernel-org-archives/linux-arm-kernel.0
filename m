From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 5 Oct 2016 18:48:05 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
Message-ID: <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/16 17:39, Fredrik Markstr?m wrote:
> The approach I suggested below with the vDSO data page will obviously
> not work on smp, so suggestions are welcome.

Well, given that it's user-writeable, is there any reason an application
which cares couldn't simply run some per-cpu threads to call getcpu()
once and cache the result in TPIDRURW themselves? That would appear to
both raise no compatibility issues and work with existing kernels.

Robin.

> /Fredrik
> 
> 
> On Wed, Oct 5, 2016 at 2:25 PM, Fredrik Markstr?m
> <fredrik.markstrom@gmail.com> wrote:
>> On Tue, Oct 4, 2016 at 7:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
>>>
>>> On Tue, Oct 04, 2016 at 05:35:33PM +0200, Fredrik Markstrom wrote:
>>>> This makes getcpu() ~1000 times faster, this is very useful when
>>>> implementing per-cpu buffers in userspace (to avoid cache line
>>>> bouncing). As an example lttng ust becomes ~30% faster.
>>>>
>>>> The patch will break applications using TPIDRURW (which is context switched
>>>> since commit 4780adeefd042482f624f5e0d577bf9cdcbb760 ("ARM: 7735/2:
>>>
>>> It looks like you dropped the leading 'a' from the commit ID. For
>>> everyone else's benefit, the full ID is:
>>>
>>>   a4780adeefd042482f624f5e0d577bf9cdcbb760
>>
>>
>> Sorry for that and thanks for fixing it.
>>
>>>
>>>
>>> Please note that arm64 has done similar for compat tasks since commit:
>>>
>>>   d00a3810c16207d2 ("arm64: context-switch user tls register tpidr_el0 for
>>>   compat tasks")
>>>
>>>> Preserve the user r/w register TPIDRURW on context switch and fork")) and
>>>> is therefore made configurable.
>>>
>>> As you note above, this is an ABI break and *will* break some existing
>>> applications. That's generally a no-go.
>>
>>
>> Ok, I wasn't sure this was considered an ABI (but I'm not entirely
>> surprised ;) ). The way I was
>> trying to defend the breakage was by reasoning that that if it was an
>> ABI we broke it both with a4780ad
>> and with 6a1c531, and since we don't break ABI:s, it can't be one.
>>
>> But hey, I'm humble here and ready to back off.
>>
>>>
>>> This also leaves arm64's compat with the existing behaviour, differing
>>> from arm.
>>>
>>> I was under the impression that other mechanisms were being considered
>>> for fast userspace access to per-cpu data structures, e.g. restartable
>>> sequences. What is the state of those? Why is this better?
>>>
>>> If getcpu() specifically is necessary, is there no other way to
>>> implement it?
>>
>> If you are referring to the user space stuff can probably be
>> implemented other ways,
>> it's just convenient since the interface is there and it will speed up
>> stuff like lttng without
>> modifications (well, except glibc). It's also already implemented as a
>> vDSO on other
>> major architectures (like x86, x86_64, ppc32 and ppc64).
>>
>> If you are referring to the implementation of the vdso call, there are
>> other possibilities, but
>> I haven't found any that doesn't introduce overhead in context switching.
>>
>> But if TPIDRURW is definitely a no go, I can work on a patch that does
>> this with a thread notifier
>> and the vdso data page. Would that be a viable option ?
>>
>>>
>>>> +notrace int __vdso_getcpu(unsigned int *cpup, unsigned int *nodep,
>>>> +                       struct getcpu_cache *tcache)
>>>> +{
>>>> +     unsigned long node_and_cpu;
>>>> +
>>>> +     asm("mrc p15, 0, %0, c13, c0, 2\n" : "=r"(node_and_cpu));
>>>> +
>>>> +     if (nodep)
>>>> +             *nodep = cpu_to_node(node_and_cpu >> 16);
>>>> +     if (cpup)
>>>> +             *cpup  = node_and_cpu & 0xffffUL;
>>>
>>> Given this is directly user-accessible, this format is a de-facto ABI,
>>> even if it's not documented as such. Is this definitely the format you
>>> want long-term?
>>
>> Yes, this (the interface) is indeed the important part and therefore I
>> tried not to invent anything
>> on my own.
>> This is the interface used by ppc32, ppc64, x86, x86_64. It's also this is
>> how the getcpu(2) system call is documented.
>>
>> /Fredrik
>>
>>
>>>
>>>
>>> Thanks,
>>> Mark.
> 
> 
> 
