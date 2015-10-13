From: james.morse@arm.com (James Morse)
Date: Tue, 13 Oct 2015 11:43:16 +0100
Subject: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <561C98C1.3090900@linaro.org>
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
 <561BB576.3060104@arm.com> <561C98C1.3090900@linaro.org>
Message-ID: <561CE044.8080401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/10/15 06:38, AKASHI Takahiro wrote:
> On 10/12/2015 10:28 PM, James Morse wrote:
>> On 29/05/15 06:38, AKASHI Takahiro wrote:
>>> The current kvm implementation on arm64 does cpu-specific initialization
>>> at system boot, and has no way to gracefully shutdown a core in terms of
>>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>>> core in EL2.
>>>
>>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>>> code into a separate function, kvm_arch_hardware_disable() and
>>> kvm_arch_hardware_enable() respectively.
>>> We don't need arm64-specific cpu hotplug hook any more.
>>
>> I think we do... on platforms where cpuidle uses psci to temporarily turn
>> off cores that aren't in use, we lose the el2 state. This hotplug hook
>> restores the state, even if there a no vms running.

I've just noticed there are two cpu notifiers - we may be referring to
different ones. (hyp_init_cpu_pm_nb and hyp_init_cpu_nb)


> If I understand you correctly, with or without my patch, kvm doesn't work
>  under cpuidle anyway. Right?

It works with, and without, v4.
This patch v5 causes the problem.


> If so, saving/restoring cpu states (or at least, kicking cpu hotplug hooks)
> is cpuidle driver's responsibility, isn't it?

Yes - but with v5, (at least one of) the hotplug hooks isn't having the
same effect as before:

Before v5, cpu_init_hyp_mode() is called via cpu_notify() each time
cpu_suspend() suspends/wakes-up the core.

Logically it should be the 'pm' notifier that does this work:
> 	if (cmd == CPU_PM_EXIT &&
> 	    __hyp_get_vectors() == hyp_default_vectors) {
> 		cpu_init_hyp_mode(NULL);
> 		return NOTIFY_OK;
>

With v5, kvm_arch_hardware_enable() isn't called each time cpu_suspend()
cycles the core.

The problem appears to be this hunk, affecting the above code:
> -       if (cmd == CPU_PM_EXIT &&
> -           __hyp_get_vectors() == hyp_default_vectors) {
> -               cpu_init_hyp_mode(NULL);
> +       if (cmd == CPU_PM_EXIT && kvm_arm_get_running_vcpu()) {
> +               kvm_arch_hardware_enable();

Changing this to just rename cpu_init_hyp_mode() to
kvm_arch_hardware_enable() solves the problem.

Presumably kvm_arm_get_running_vcpu() evaluates to false before the first
vm is started, meaning no vms can be started if pm events occur before
starting the first vm.

Sorry I blamed the wrong cpu notifier hook - I didn't realise there were two!


Thanks,

James


>> This patch prevents me from running vms on such a platform, qemu gives:
>>> kvm [1500]: Unsupported exception type: 6264688KVM internal error.
>> Suberror: 0
>>
>> kvmtool goes with a more dramatic:
>>> KVM exit reason: 17 ("KVM_EXIT_INTERNAL_ERROR")
>>
>> Disabling CONFIG_ARM_CPUIDLE solves this problem.
>>
>>
>> (Sorry to revive an old thread - I've been using v4 of this patch for the
>> hibernate/suspend-to-disk series).
>>
>>
>>> Since this patch modifies common part of code between arm and arm64, one
>>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>>> compiling errors.
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>>> index fd085ec..afe6263 100644
>>> --- a/arch/arm64/kvm/hyp.S
>>> +++ b/arch/arm64/kvm/hyp.S
>>> @@ -1136,6 +1136,11 @@ ENTRY(kvm_call_hyp)
>>>       ret
>>>   ENDPROC(kvm_call_hyp)
>>>
>>> +ENTRY(kvm_call_reset)
>>> +    hvc    #HVC_RESET
>>> +    ret
>>> +ENDPROC(kvm_call_reset)
>>> +
>>>   .macro invalid_vector    label, target
>>>       .align    2
>>>   \label:
>>> @@ -1179,10 +1184,27 @@ el1_sync:                    // Guest trapped
>>> into EL2
>>>       cmp    x18, #HVC_GET_VECTORS
>>>       b.ne    1f
>>>       mrs    x0, vbar_el2
>>> -    b    2f
>>> -
>>> -1:    /* Default to HVC_CALL_HYP. */
>>> +    b    do_eret
>>>
>>> +    /* jump into trampoline code */
>>> +1:    cmp    x18, #HVC_RESET
>>> +    b.ne    2f
>>> +    /*
>>> +     * Entry point is:
>>> +     *    TRAMPOLINE_VA
>>> +     *    + (__kvm_hyp_reset - (__hyp_idmap_text_start & PAGE_MASK))
>>> +     */
>>> +    adrp    x2, __kvm_hyp_reset
>>> +    add    x2, x2, #:lo12:__kvm_hyp_reset
>>> +    adrp    x3, __hyp_idmap_text_start
>>> +    add    x3, x3, #:lo12:__hyp_idmap_text_start
>>> +    and    x3, x3, PAGE_MASK
>>> +    sub    x2, x2, x3
>>> +    ldr    x3, =TRAMPOLINE_VA
>>> +    add    x2, x2, x3
>>> +    br    x2                // no return
>>> +
>>> +2:    /* Default to HVC_CALL_HYP. */
>>
>> What was the reason not to use kvm_call_hyp(__kvm_hyp_reset, ...)?
>> (You mentioned you wanted to at [0] - I can't find the details in the
>> archive)
>>
>>
>> Thanks,
>>
>> James
>>
>>
>> [0] http://lists.infradead.org/pipermail/kexec/2015-April/335533.html
