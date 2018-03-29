From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Mar 2018 13:36:44 +0200
Subject: [PATCH resend 2/2] arm64: assembler: add macros to conditionally
 yield the NEON under PREEMPT
In-Reply-To: <20180329111227.GQ16308@e103592.cambridge.arm.com>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
 <20180328124129.6459-3-ard.biesheuvel@linaro.org>
 <20180328171812.GN16308@e103592.cambridge.arm.com>
 <CAKv+Gu-FdndoFON3tJi0WP=+HsBtaoLY-uf6=0bd3e6jr1h-DQ@mail.gmail.com>
 <20180329093605.GP16308@e103592.cambridge.arm.com>
 <CAKv+Gu8o4R5JBseRt345OV5UVShFmGYiF4Wpxsnw_ZiRuch2AQ@mail.gmail.com>
 <20180329111227.GQ16308@e103592.cambridge.arm.com>
Message-ID: <978F38B1-BCAA-4E57-BFD4-3BB5D8AC0F19@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 29 Mar 2018, at 13:12, Dave Martin <Dave.Martin@arm.com> wrote:
> 
>> On Thu, Mar 29, 2018 at 10:59:28AM +0100, Ard Biesheuvel wrote:
>>> On 29 March 2018 at 10:36, Dave Martin <Dave.Martin@arm.com> wrote:
>>>> On Thu, Mar 29, 2018 at 10:02:18AM +0100, Ard Biesheuvel wrote:
>>>> On 28 March 2018 at 18:18, Dave Martin <Dave.Martin@arm.com> wrote:
> 
> [...]
> 
>>>> I should probably rephrase this to say that x0 .. x18 may be clobbered.
>>> 
>>> Sure, that would be simpler.  Or maybe just say that the set of clobbers
>>> is the same as for a function call -- this would cover NZCV for example.
>>> 
>> 
>> Even better.
> 
> [...]
> 
>>>>> Since the patchup sequences aren't likely to be many or large, it's
>>>>> not the end of the world if we don't do this discarding though.
>>>>> 
>>>> 
>>>> I chose not to bother. These are handcrafted assembly files that are
>>>> usually kept in modules, which means the .text footprint is a 4k
>>>> multiple anyway, and the code is complex enough as it is, so
>>>> discarding ~10 instructions that have been moved out of the hot path
>>>> already doesn't seem that useful to me.
>>> 
>>> Agreed.  Do you know who is building CONFIG_PREEMPT=n kernels these
>>> days?
>>> 
>> 
>> AFAIK most distro kernels use voluntary preemption, so they'd still
>> benefit from this.
> 
> OK, and given the size of the typical distro kernel, I doubt anyone will
> lose sleep over a couple of hundred extra bytes.
> 

My point was that this is /not/ dead code on typical distro kernels given that this approach should work equally under voluntary preemption.


> I might try to hack it up later just for fun, just to see whether it
> works.
> 
> [...]
> 
>>>>> Should you include
>>>>> 
>>>>>        .purgem do_cond_yield_neon
>>>>>        .purgem endif_yield_neon
>>>>> 
>>>>> here?
>>>>> 
>>>>> Otherwise, I think you would get macro redefinition errors if
>>>>> if_will_cond_yield_neon is used more than once in a given file.
>>>>> 
>>>> 
>>>> if_will_cond_yield_neon does not define any macros itself, so this
>>>> shouldn't be a problem.
>>> 
>>> You're right.  I skipped an .endm for some reason while reading and
>>> decided there were nested macros here.  But there aren't.
>>> 
>>> Protecting against misuse would be "nice", but people using them already
>>> need to know what they're doing, so it's low-priority and something that
>>> could be added in a later patch.  So I agree that there's no need to add
>>> that here.
>>> 
>> 
>> OK.
>> 
>> I will respin with the minor issues addressed and your R-b added, and
>> repost before the end of the day.
> 
> Sounds good to me.
> 
> Cheers
> ---Dave
> 
>> Will, hopefully you're still ok with picking this up for v4.17? I'd
>> hate to postpone the crypto pieces that depend on it to v4.19
> 
> [...]
