From: james.morse@arm.com (James Morse)
Date: Wed, 20 Apr 2016 12:19:38 +0100
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <20160420102944.GD1234@linaro.org>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
 <571656E9.5050402@arm.com> <57166CC9.4030804@arm.com>
 <20160420102944.GD1234@linaro.org>
Message-ID: <571765CA.1070009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/04/16 11:29, AKASHI Takahiro wrote:
> On Tue, Apr 19, 2016 at 06:37:13PM +0100, James Morse wrote:
>> On 19/04/16 17:03, Marc Zyngier wrote:
>>> On 01/04/16 17:53, James Morse wrote:
>>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>>> index b5384311dec4..962904a443be 100644
>>>> --- a/arch/arm/kvm/arm.c
>>>> +++ b/arch/arm/kvm/arm.c
>>>> @@ -591,7 +587,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>>  		/*
>>>>  		 * Re-check atomic conditions
>>>>  		 */
>>>> -		if (signal_pending(current)) {
>>>> +		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
>>>> +			/* cpu has been torn down */
>>>> +			ret = 0;
>>>> +			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
>>>> +			run->fail_entry.hardware_entry_failure_reason
>>>> +					= (u64)-ENOEXEC;
>>>
>>> This hunk makes me feel a bit uneasy. Having to check something that
>>> critical on the entry path is at least a bit weird. If we've reset EL2
>>> already, it means that we must have forced an exit on the guest to do so.
>>
>> (To save anyone else digging: the story comes from v12 of the kexec copy of this
>> patch [0])
>>
>>
>>> So why do we hand the control back to KVM (or anything else) once we've
>>> nuked a CPU? I'd expect it to be put on some back-burner, never to
>>> return in this lifetime...
>>
>> This looks like the normal reboot code being called in the middle of a running
>> system. Kexec calls kernel_restart_prepare(), which kicks each reboot notifier,
>> one of which is kvm_reboot(), which calls:
>>> on_each_cpu(hardware_disable_nolock, NULL, 1);
>>
>> We have to give the CPU back as there may be other reboot notifiers, and kexec
>> hasn't yet shuffled onto the boot cpu.
> 
> Right, and this kvm reboot notifier can be executed via IPI at any time
> while interrupted is enabled, and so the check must be done between
> local_irq_disable() and local_irq_enable().

Good point, this makes it really nasty!


>> How about moving this check into handle_exit()[1]?
>> Currently this sees ARM_EXCEPTION_IRQ, and tries to re-enter the guest, we can
>> test for kvm_rebooting, which is set by kvm's reboot notifier .... but this
>> would still break if another vcpu wakes from cond_resched() and sprints towards
>> __kvm_vcpu_run(). Can we move cond_resched() to immediately before handle_exit()?
> 
> I don't think that it would break as reboot process is *one-directional*,
> and any cpu should be torn down sooner or later.

I think we can schedule quite a few vcpus in the meantime though:
The CPU that called kvm_reboot() will wait until each cpu has returned from
hardware_disable_nolock(), eventually it will call disable_non_boot_cpus(), in
the meantime the scheduler is free to pick threads to run.


> I'm not quite sure about Marc's point, but if he has concern on overhead
> of checking per-cpu kvm_arm_hardware_enabled, we may, instead, check on
> kvm_rebooting.

> (And this check won't make sense for VHE-enabled platform.)

Gah, VHE. I think Marc's suggestion to make it an exception returned from the
hyp-stub is best. I need to switch over to kexec to test it though....


Thanks,

James
