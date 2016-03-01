From: dave.long@linaro.org (David Long)
Date: Mon, 29 Feb 2016 21:55:50 -0500
Subject: [PATCH 5/8] arm64: kprobes instruction simulation support
In-Reply-To: <56CDCA6B.7000207@arm.com>
References: <1455839301-26464-1-git-send-email-dave.long@linaro.org>
 <1455839301-26464-6-git-send-email-dave.long@linaro.org>
 <56C720F0.9080108@arm.com> <56CD5434.30108@linaro.org>
 <20160224090530.5e86e867@arm.com> <56CDC734.4000201@linaro.org>
 <56CDCA6B.7000207@arm.com>
Message-ID: <56D504B6.7010305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2016 10:21 AM, Marc Zyngier wrote:
> On 24/02/16 15:07, David Long wrote:
>> On 02/24/2016 04:05 AM, Marc Zyngier wrote:
>>> On Wed, 24 Feb 2016 01:56:52 -0500
>>> David Long <dave.long@linaro.org> wrote:
>>>
>>>> On 02/19/2016 09:04 AM, Marc Zyngier wrote:
>>>>> Hi David,
>>>>>
>>>>> On 18/02/16 23:48, David Long wrote:
>>>>>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>>>>
>>>>>> Kprobes needs simulation of instructions that cannot be stepped
>>>>>> from different memory location, e.g.: those instructions
>>>>>> that uses PC-relative addressing. In simulation, the behaviour
>>>>>> of the instruction is implemented using a copy of pt_regs.
>>>>>>
>>>>>> Following instruction catagories are simulated:
>>>>>>     - All branching instructions(conditional, register, and immediate)
>>>>>>     - Literal access instructions(load-literal, adr/adrp)
>>>>>>
>>>>>> Conditional execution is limited to branching instructions in
>>>>>> ARM v8. If conditions at PSTATE do not match the condition fields
>>>>>> of opcode, the instruction is effectively NOP. Kprobes considers
>>>>>> this case as 'miss'.
>>>>>>
>>>>>> This code also replaces the use of arch/arm/opcodes.c for
>>>>>> arm_check_condition().
>>>>>>
>>>>>> Thanks to Will Cohen for assorted suggested changes.
>>>>>>
>>>>>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>>>> Signed-off-by: William Cohen <wcohen@redhat.com>
>>>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>
>>> [...]
>>>
>>>>>> +};
>>>>>> +
>>>>>> +asmlinkage unsigned int __kprobes arm_check_condition(u32 opcode, u32 psr)
>>>>>
>>>>> Why asmlinkage? This function is never called from assembly code on arm64.
>>>>>
>>>>
>>>> This comes from the 32-bit ARM code that tests the condition from
>>>> entry.S.  We include arch/arm/include/asm/opcodes.h in
>>>> arch/arm64/include/asm/opcodes.h so it gets declared there with
>>>> asmlinkage. I can remove the asmlinkage in the actual function
>>>> definition and it still compiles but I'm not sure that is kosher.
>>>
>>> asmlinkage is only meaningful if you're calling it from assembly code.
>>> As you seem to only call it from C code, having asmlinkage is both
>>> pointless and confusing.
>>>
>>>> Will Deacon was advocating getting rid of the include of the 32-bit header
>>>> file but it looked to me like this would mean a lot of duplicated
>>>> defines and the work would be mostly unrelated to kprobes.
>>>
>>> Arguably, arm_check_condition() (which only matters to 32bit code,
>>> hence userspace) is also completely unrelated to kprobes. I still think
>>> Will's point stands.
>>>
>>
>> Yes, I would not argue about that cross-architecture include needing to
>> be fixed.  Can I assume you agree that need not be a part of this
>> kprobes patch though, nor a prerequisite patch for it?
>
> My usual stand on this kind of issue is that if you start digging in the
> middle of the road, you're also responsible for cleaning the pavement
> (sorry if that's a bad analogy).
>
> In the end, this is the arm64 maintainers that decide what they want to
> see, and by the look of it, Will has made his point clear...
>
> Thanks,
>
> 	M.
>

Just to close the loop on this, after working on this it does make sense 
to me to bundle this change when considering just opcodes.c (and not its 
associated include file).  My patch patch now removes 
arm/kernel/opcodes.c from the arm64 build. I still don't see a way to 
get rid of the cross-architecture include except by making a copy of 
opcodes.h, which seems to me the greater of two evils.

-dl
