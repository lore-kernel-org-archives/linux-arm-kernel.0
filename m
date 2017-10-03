From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 3 Oct 2017 16:07:38 +0100
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <877ewcz3bv.fsf@linaro.org>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
 <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
 <3c249a68-45e3-a3a5-7d05-4cfc2d97713b@arm.com>
 <CAMJs5B8hYTJBxKa8Wu3Bw7EjaG4UZ56QQyVYx1E_4kJzkPhN+Q@mail.gmail.com>
 <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
 <CAMJs5B-i4h63Hx68b6z-DxDphXieoNGJcLTfi2zLuq0CnU_S3g@mail.gmail.com>
 <3d7d2b36-da2f-04dc-611e-d7aab7666c29@arm.com>
 <CAMJs5B8F9VffM3pDQxbk-qfUmvvqdvbVOt8WZgFX2Q4Ud3eJrA@mail.gmail.com>
 <9bc5abc2-ab03-3137-82bd-e8afa62624eb@arm.com>
 <CAMJs5B9iVYGE2mODE1raHzGQ+Mz7V_kT+bJiWm0zUHfmLN1-DQ@mail.gmail.com>
 <861b4e4f-0fbe-cbc6-39ad-4660065449de@arm.com> <877ewcz3bv.fsf@linaro.org>
Message-ID: <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/17 15:57, Alex Benn?e wrote:
> 
> Julien Thierry <julien.thierry@arm.com> writes:
> 
>> On 31/08/17 15:01, Christoffer Dall wrote:
>>> On Thu, Aug 31, 2017 at 3:57 PM, Julien Thierry <julien.thierry@arm.com> wrote:
>>>> On 31/08/17 14:28, Christoffer Dall wrote:
>>>>> On Thu, Aug 31, 2017 at 2:56 PM, Julien Thierry <julien.thierry@arm.com>
>>>>> wrote:
>>>>>> On 31/08/17 11:53, Christoffer Dall wrote:
>>>>>>> On Thu, Aug 31, 2017 at 11:37 AM, Julien Thierry
>>>>>>> <julien.thierry@arm.com>
>>>>>>> wrote:
>>>>>>>> On 31/08/17 09:54, Christoffer Dall wrote:
>>>>>>>>> On Thu, Aug 31, 2017 at 10:45 AM, Julien Thierry
>>>>>>>>> <julien.thierry@arm.com>
>>>>>>>>> wrote:
>>>>>>>>>> Hi Christoffer,
>>>>>>>>>> On 30/08/17 19:53, Christoffer Dall wrote:
>>>>>>>>>>> Hi Julien,
>>>>>>>>>>>
>>>>>>>>>>> [cc'ing Alex Benn?e here who wrote the debug code for arm64]
>>>>>>>>>>>
>>>>>>>>>>> On Wed, Aug 30, 2017 at 11:01 AM, Julien Thierry
>>>>>>>>>>> <julien.thierry@arm.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Software Step exception is missing after trapping instruction from
>>>>>>>>>>>> the
>>>>>>>>>>>> guest.
>>>>>>>>>>>>
>>>>>>>>>>>> We need to set the PSR.SS to 0 for the guest vcpu before resuming
>>>>>>>>>>>> guest
>>>>>>>>>>>> execution.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>>>>>>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>>>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        arch/arm64/include/asm/kvm_asm.h     |  2 ++
>>>>>>>>>>>>        arch/arm64/include/asm/kvm_emulate.h |  2 ++
>>>>>>>>>>>>        arch/arm64/kvm/debug.c               | 12 +++++++++++-
>>>>>>>>>>>>        arch/arm64/kvm/hyp/switch.c          | 12 ++++++++++++
>>>>>>>>>>>>        4 files changed, 27 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/arch/arm64/include/asm/kvm_asm.h
>>>>>>>>>>>> b/arch/arm64/include/asm/kvm_asm.h
>>>>>>>>>>>> index 26a64d0..398bbaa 100644
>>>>>>>>>>>> --- a/arch/arm64/include/asm/kvm_asm.h
>>>>>>>>>>>> +++ b/arch/arm64/include/asm/kvm_asm.h
>>>>>>>>>>>> @@ -32,6 +32,8 @@
>>>>>>>>>>>>
>>>>>>>>>>>>        #define KVM_ARM64_DEBUG_DIRTY_SHIFT    0
>>>>>>>>>>>>        #define KVM_ARM64_DEBUG_DIRTY          (1 <<
>>>>>>>>>>>> KVM_ARM64_DEBUG_DIRTY_SHIFT)
>>>>>>>>>>>> +#define KVM_ARM64_DEBUG_INST_SKIP_SHIFT        1
>>>>>>>>>>>> +#define KVM_ARM64_DEBUG_INST_SKIP      (1 <<
>>>>>>>>>>>> KVM_ARM64_DEBUG_INST_SKIP_SHIFT)
>>>>>>>>>>>>
>>>>>>>>>>>>        #define kvm_ksym_ref(sym)
>>>>>>>>>>>> \
>>>>>>>>>>>>               ({
>>>>>>>>>>>> \
>>>>>>>>>>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h
>>>>>>>>>>>> b/arch/arm64/include/asm/kvm_emulate.h
>>>>>>>>>>>> index fe39e68..d401c64 100644
>>>>>>>>>>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>>>>>>>>>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>>>>>>>>>>> @@ -95,6 +95,8 @@ static inline void kvm_skip_instr(struct kvm_vcpu
>>>>>>>>>>>> *vcpu, bool is_wide_instr)
>>>>>>>>>>>>                       kvm_skip_instr32(vcpu, is_wide_instr);
>>>>>>>>>>>>               else
>>>>>>>>>>>>                       *vcpu_pc(vcpu) += 4;
>>>>>>>>>>>> +       /* Let debug engine know we skipped an instruction */
>>>>>>>>>>>> +       vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_INST_SKIP;
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Why do we need to defer this action until later?
>>>>>>>>>>>
>>>>>>>>>>> Can't we simply do clear DBG_SPSR_SS here?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That was my first intention, but it turns out that the current state
>>>>>>>>>> of
>>>>>>>>>> things (without this patch) is that every time we enter a guest,
>>>>>>>>>> kvm_arm_setup_debug gets called and if single step is requested for
>>>>>>>>>> the
>>>>>>>>>> guest it will set the flag in the SPSR (ignoring the fact that we
>>>>>>>>>> cleared
>>>>>>>>>> it).
> 
> So to be clear kvm_arm_setup_debug only sets SS if we are about to
> single-step. This is controlled by the debug ioctl which is done outside
> of the main KVM run loop.
> 
>>>>>>>>>
>>>>>>>>> Ah, right, duh.
>>>>>>>>>
>>>>>>>>>> This happens even if we exit the guest because of a data abort.
>>>>>>>>>>
>>>>>>>>>> For normal single step execution, we do need to reset SPSR.SS to 1
>>>>>>>>>> before
>>>>>>>>>> running the guest since completion of a step should clear that bit
>>>>>>>>>> before
>>>>>>>>>> taking a software step exception. So what kvm_arm_setup_debug does
>>>>>>>>>> seems
>>>>>>>>>> correct to me but missed the case for trapped/emulated instructions.
>>>>>>>>>>
>>>>>>>>>> So even if we just clear DBG_SPSR_SS here, we would still need to
>>>>>>>>>> tell
>>>>>>>>>> kvm_arm_setup_debug not to change the bit. Or resetting SPSR.SS to 1
>>>>>>>>>> for
>>>>>>>>>> normal single stepping needs to be done before we skip instructions
>>>>>>>>>> in
>>>>>>>>>> KVM
>>>>>>>>>> but that doesn't sound right to me...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So I'm wondering if we're going about this wrong.  Perhaps we need to
>>>>>>>>> discover at the end of the run loop that we were asked to single step
>>>>>>>>> execution and simply return to userspace, setting the debug exit
>>>>>>>>> reason etc., instead of entering the guest with PSTATE.SS==0 and
>>>>>>>>> relying on another trap back in to the guest just to set two fields on
>>>>>>>>> the kvm_run structure and exit to user space ?
>>>>>>>>>
>>>>>>>>
>>>>>>>> So if I understand correctly, the suggestion is that when we trap an
>>>>>>>> instruction we check whether it was supposed to be single stepped, if
>>>>>>>> it
>>>>>>>> was
>>>>>>>> we set up the vcpu registers as if it had taken a software step
>>>>>>>> exception
>>>>>>>> and return from kvm_arch_vcpu_ioctl_run. Is that right?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> yes, that's the idea.  If there's a lot of complexity in setting up
>>>>>>> CPU register state, then it may not be a good idea, but if it's
>>>>>>> relatively clean, I think it can be preferred over the "let's keep a
>>>>>>> flag aroudn for later" approach.
>>>>>>>
>>>>>>
>>>>>> So I looked a bit into it.
>>>>>>
>>>>>> One annoying thing is that the single step mechanic is specific to arm64.
>>>>>> MMU and MMIO code is shared between arm and arm64 and do some handling of
>>>>>> traps.
> 
> This is because the ARMv7 support isn't complete (and also ARMv7
> hardware is slightly more complex in its corner cases if we were to do it).
> 
>>>>>>
>>>>>> So cleanest way I can think of doing this would be to clear SPSR.SS in
>>>>>> arm64::kvm_skip_instr, then have some function (e.g.
>>>>>> kvm_handle/manage_debug_state) at the end of the run loop. For arm, the
>>>>>> function is empty. For arm64, the function,  if we are in an active
>>>>>> pending
>>>>>> state (SPSR.D == 0 && SPSR.SS == 0 && MDSCR_EL1.SS == 1) and not about to
>>>>>> return to userland, returns with a "fake debug exception".
>>>>>>
>>>>>> So instead of a flag, we would just use SPSR.SS (or more generally the
>>>>>> vcpu
>>>>>> state) to know if we need to exit with a debug exception or not. And the
>>>>>> kvm_arm_setup_debug would be left untouched (always setting SPSR.SS when
>>>>>> requested by userland).
>>>>>>
>>>>>> Does that sound like what you had in mind? Or does it seem better than
>>>>>> the
>>>>>> current patch?
>>>>>>
>>>>> I was thinking to change the skip_instruction function to return an
>>>>> int, and then call kvm_handle_debug_ss() from skip_instruction, which
>>>>> would update the kvm_run structure and exit here and then.
>>>>>
>>>>
>>>> Setting up the debug exception from within kvm_skip_instruction seem to
>>>> change a bit too much its semantic from arm to arm64. I would find this
>>>> easily confusing.
>>>>
>>>>> However, I'm now thinking that this doesn't really work either,
>>>>> because we could have to emulate a trapped MMIO instruction in user
>>>>> space, and then it's not clear how to exit with a debug exception at
>>>>> the same time.
> 
> A debug exception at guest exit point is (IIRC) just having the
> appropriate status in the run->exit_reason (KVM_EXIT_DEBUG). If you need
> to exit for MMIO emulation (i.e. the instruction has not run yet) you
> shouldn't do that. Exit, emulate and return. We could handle the ioctl
> to clear SS in userspace but I guess that gets just as messy.
> 
>>>>>
>>>>> So perhaps we should stick with your original approach.
>>>>>
>>>>
>>>> I had not realized that was possible. This makes things more complicated for
>>>> avoiding a back and forth with the guest for trapped exceptions. Out of
>>>> luck, having the debug flag does look like single stepping would work as
>>>> expected for userland MMIOs.
>>>
>>> Yes, I think your approach is the best choice now, considering.
>>>
>>>>
>>>> I can try to detail the comment in kvm_arm_setup_debug when we set SPSR,
>>>> hopefully making things clearer when seeing that part of the code.
>>>>
>>>
>>> I also think we need to improve the comment in the world-switch return
>>> path, and I'd like Alex to weigh in here before we merge this.   He's
>>> back from holiday on Monday.
>>>
>>
>> Ping Alex?
> 
> Sorry for the delay getting back to you. I had flagged the email but
> with holidays and conferences in the way it fell off my queue.
> 

No problem, thanks for looking at it.

> So to summarise as I understand things:
> 
>   Host User Space   |      Host KVM   |   Host Hyp    |  Guest VM      |
> 
>   Enable Debug(SS)
>   KVM_RUN ----------->
>                       Guest SPSR.SS set
>                                     --> World Switch ->
>                                                        Insn Trap to Hyp
>                                         World Switch <-
>                                         (SS not cleared)
>                                     <--
>                       Insn Emulated
>                       pc += 4
>                                     -->
>                                         World Switch
>                                         (SS still set)
>                                                       ->
>                                                        Insn +4 SS
>                                                      <-
>                                         World Switch
>                                         (SS cleared)
> 
>                                      <--
>                       Guest exit (debug)
>                    <--
>    See SS did 2 insns?
> 
> Do I understand the problem you are trying to fix correctly?

Yes that's the issue. The debugger is not made aware of the 
emulated/skipped instruction and the hypervisor jumps back into the guest.

Clearing SS before jumping back to the guest will simply trigger a debug 
exception as soon as we ERET from EL2 to EL1 (so we end up just getting 
back to EL2).

Cheers,

-- 
Julien Thierry
