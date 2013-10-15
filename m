From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Oct 2013 16:06:42 +0200
Subject: [RFC v3 PATCH 0/7] ARM[64]: kernel mode NEON in atomic contexts
In-Reply-To: <CAKv+Gu-rbNmwJf09JVUYYyJjoGrJqpsrv=x_wWMJ6r-EofbYDQ@mail.gmail.com>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1310142353210.1873@syhkavp.arg>
 <CAKv+Gu-rbNmwJf09JVUYYyJjoGrJqpsrv=x_wWMJ6r-EofbYDQ@mail.gmail.com>
Message-ID: <CAKv+Gu85Vg1UZd7Vky_d7A5oTBSygXhtD5uF7R+c8cdCFdRgQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2013 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 15 October 2013 06:01, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Sun, 13 Oct 2013, Ard Biesheuvel wrote:
>>
>>> Instead of having additional separate versions of kernel_neon_begin/end, the
>>> existing ones now have been modified to always take a preallocated stack area
>>> as an argument.
>>
>> The problem with this approach is that you break git bisect by making
>> the kernel unbuildable when this series is partially applied.  Either
>> you make kernel_neon_begin/end into wrappers with no argument around the
>> new interface, or you change all users at the same time as the
>> interface.  One big principle is not to break the kernel build in the
>> middle of a patch series when altering an existing interface.
>>
>
> I see.
>
>>> The stack area is allocated by DEFINE_NEON_REGSTACK[_PARTIAL](varname), where
>>> the partial version takes an additional int num_regs indicating how many
>>> registers need to be freed up.
>>>
>>> In the !in_interrupt() case, these functions operate as before, and the regstack
>>> is defined to minimal size in this case as it will remain unused anyway. In the
>>> in_interrupt() case, 'num_regs' (or all) NEON registers are stacked/unstacked
>>> using the allocated stack region.
>>
>> Would have been nice to have the stack simply be a NULL pointer when
>> !in_interrupt() or when the number of regs is 0.  This would remove the
>> need for a runtime check on !num_regs.  I don't see an obvious way to
>> accomplish that right now though.
>>
>
> We could address both of these issues by implementing Catalin's
> suggestion to reserve per-process vfp_states[] for both irq and
> softirq context in addition to the ordinary one, but it would waste a
> lot of space imo. What is your take on that?
>

Replying to self: two per-cpu vfp_states, one for irq and one for
softirq, is probably the best approach here. I still need to add
kernel_neon_begin_partial() in this case, but the existing users can
remain unmodified.
I will do a v4 by end of next week.

Regards,
Ard.
