From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 31 Aug 2017 12:53:39 +0200
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
 <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
 <3c249a68-45e3-a3a5-7d05-4cfc2d97713b@arm.com>
 <CAMJs5B8hYTJBxKa8Wu3Bw7EjaG4UZ56QQyVYx1E_4kJzkPhN+Q@mail.gmail.com>
 <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
Message-ID: <CAMJs5B-i4h63Hx68b6z-DxDphXieoNGJcLTfi2zLuq0CnU_S3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 11:37 AM, Julien Thierry <julien.thierry@arm.com> wrote:
>
>
> On 31/08/17 09:54, Christoffer Dall wrote:
>>
>> On Thu, Aug 31, 2017 at 10:45 AM, Julien Thierry <julien.thierry@arm.com>
>> wrote:
>>>
>>> Hi Christoffer,
>>>
>>>
>>> On 30/08/17 19:53, Christoffer Dall wrote:
>>>>
>>>>
>>>> Hi Julien,
>>>>
>>>> [cc'ing Alex Benn?e here who wrote the debug code for arm64]
>>>>
>>>> On Wed, Aug 30, 2017 at 11:01 AM, Julien Thierry
>>>> <julien.thierry@arm.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Software Step exception is missing after trapping instruction from the
>>>>> guest.
>>>>>
>>>>> We need to set the PSR.SS to 0 for the guest vcpu before resuming guest
>>>>> execution.
>>>>>
>>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>
>>>>> ---
>>>>>    arch/arm64/include/asm/kvm_asm.h     |  2 ++
>>>>>    arch/arm64/include/asm/kvm_emulate.h |  2 ++
>>>>>    arch/arm64/kvm/debug.c               | 12 +++++++++++-
>>>>>    arch/arm64/kvm/hyp/switch.c          | 12 ++++++++++++
>>>>>    4 files changed, 27 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/kvm_asm.h
>>>>> b/arch/arm64/include/asm/kvm_asm.h
>>>>> index 26a64d0..398bbaa 100644
>>>>> --- a/arch/arm64/include/asm/kvm_asm.h
>>>>> +++ b/arch/arm64/include/asm/kvm_asm.h
>>>>> @@ -32,6 +32,8 @@
>>>>>
>>>>>    #define KVM_ARM64_DEBUG_DIRTY_SHIFT    0
>>>>>    #define KVM_ARM64_DEBUG_DIRTY          (1 <<
>>>>> KVM_ARM64_DEBUG_DIRTY_SHIFT)
>>>>> +#define KVM_ARM64_DEBUG_INST_SKIP_SHIFT        1
>>>>> +#define KVM_ARM64_DEBUG_INST_SKIP      (1 <<
>>>>> KVM_ARM64_DEBUG_INST_SKIP_SHIFT)
>>>>>
>>>>>    #define kvm_ksym_ref(sym)
>>>>> \
>>>>>           ({
>>>>> \
>>>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h
>>>>> b/arch/arm64/include/asm/kvm_emulate.h
>>>>> index fe39e68..d401c64 100644
>>>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>>>> @@ -95,6 +95,8 @@ static inline void kvm_skip_instr(struct kvm_vcpu
>>>>> *vcpu, bool is_wide_instr)
>>>>>                   kvm_skip_instr32(vcpu, is_wide_instr);
>>>>>           else
>>>>>                   *vcpu_pc(vcpu) += 4;
>>>>> +       /* Let debug engine know we skipped an instruction */
>>>>> +       vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;
>>>>
>>>>
>>>>
>>>> Why do we need to defer this action until later?
>>>>
>>>> Can't we simply do clear DBG_SPSR_SS here?
>>>>
>>>
>>> That was my first intention, but it turns out that the current state of
>>> things (without this patch) is that every time we enter a guest,
>>> kvm_arm_setup_debug gets called and if single step is requested for the
>>> guest it will set the flag in the SPSR (ignoring the fact that we cleared
>>> it).
>>
>>
>> Ah, right, duh.
>>
>>> This happens even if we exit the guest because of a data abort.
>>>
>>> For normal single step execution, we do need to reset SPSR.SS to 1 before
>>> running the guest since completion of a step should clear that bit before
>>> taking a software step exception. So what kvm_arm_setup_debug does seems
>>> correct to me but missed the case for trapped/emulated instructions.
>>>
>>> So even if we just clear DBG_SPSR_SS here, we would still need to tell
>>> kvm_arm_setup_debug not to change the bit. Or resetting SPSR.SS to 1 for
>>> normal single stepping needs to be done before we skip instructions in
>>> KVM
>>> but that doesn't sound right to me...
>>>
>>
>> So I'm wondering if we're going about this wrong.  Perhaps we need to
>> discover at the end of the run loop that we were asked to single step
>> execution and simply return to userspace, setting the debug exit
>> reason etc., instead of entering the guest with PSTATE.SS==0 and
>> relying on another trap back in to the guest just to set two fields on
>> the kvm_run structure and exit to user space ?
>>
>
> So if I understand correctly, the suggestion is that when we trap an
> instruction we check whether it was supposed to be single stepped, if it was
> we set up the vcpu registers as if it had taken a software step exception
> and return from kvm_arch_vcpu_ioctl_run. Is that right?

yes, that's the idea.  If there's a lot of complexity in setting up
CPU register state, then it may not be a good idea, but if it's
relatively clean, I think it can be preferred over the "let's keep a
flag aroudn for later" approach.

>
> Interesting idea, I can try to explore that possibility.
>
> Thanks for the suggestion,
>
Thanks!
-Christoffer
