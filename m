From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 15 Dec 2015 16:51:29 +0900
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <566EFD64.9030209@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <566A8404.4020507@linaro.org>
 <566AF9BE.7090806@arm.com> <566E70C7.4070700@linaro.org>
 <566EFD64.9030209@arm.com>
Message-ID: <566FC681.2020900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2015 02:33 AM, Marc Zyngier wrote:
> On 14/12/15 07:33, AKASHI Takahiro wrote:
>> Marc,
>>
>> On 12/12/2015 01:28 AM, Marc Zyngier wrote:
>>> On 11/12/15 08:06, AKASHI Takahiro wrote:
>>>> Ashwin, Marc,
>>>>
>>>> On 12/03/2015 10:58 PM, Marc Zyngier wrote:
>>>>> On 02/12/15 22:40, Ashwin Chaugule wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 24 November 2015 at 17:25, Geoff Levand <geoff@infradead.org> wrote:
>>>>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>>
>>>>>>> The current kvm implementation on arm64 does cpu-specific initialization
>>>>>>> at system boot, and has no way to gracefully shutdown a core in terms of
>>>>>>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>>>>>>> core in EL2.
>>>>>>>
>>>>>>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>>>>>>> code into a separate function, kvm_arch_hardware_disable() and
>>>>>>> kvm_arch_hardware_enable() respectively.
>>>>>>> We don't need arm64-specific cpu hotplug hook any more.
>>>>>>>
>>>>>>> Since this patch modifies common part of code between arm and arm64, one
>>>>>>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>>>>>>> compiling errors.
>>>>>>>
>>>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>> ---
>>>>>>>     arch/arm/include/asm/kvm_host.h   | 10 ++++-
>>>>>>>     arch/arm/include/asm/kvm_mmu.h    |  1 +
>>>>>>>     arch/arm/kvm/arm.c                | 79 ++++++++++++++++++---------------------
>>>>>>>     arch/arm/kvm/mmu.c                |  5 +++
>>>>>>>     arch/arm64/include/asm/kvm_host.h | 16 +++++++-
>>>>>>>     arch/arm64/include/asm/kvm_mmu.h  |  1 +
>>>>>>>     arch/arm64/include/asm/virt.h     |  9 +++++
>>>>>>>     arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
>>>>>>>     arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
>>>>>>>     9 files changed, 138 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> [..]
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>     static struct notifier_block hyp_init_cpu_pm_nb = {
>>>>>>> @@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
>>>>>>>            }
>>>>>>>
>>>>>>>            /*
>>>>>>> -        * Execute the init code on each CPU.
>>>>>>> -        */
>>>>>>> -       on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>>>>>>> -
>>>>>>> -       /*
>>>>>>>             * Init HYP view of VGIC
>>>>>>>             */
>>>>>>>            err = kvm_vgic_hyp_init();
>>>>>>
>>>>>> With this flow, the cpu_init_hyp_mode() is called only at VM guest
>>>>>> creation, but vgic_hyp_init() is called at bootup. On a system with
>>>>>> GICv3, it looks like we end up with bogus values from the ICH_VTR_EL2
>>>>>> (to get the number of LRs), because we're not reading it from EL2
>>>>>> anymore.
>>>>
>>>> Thank you for pointing this out.
>>>> Recently I tested my kdump code on hikey, and as hikey(hi6220) has gic-400,
>>>> I didn't notice this problem.
>>>
>>> Because GIC-400 is a GICv2 implementation, which is entirely MMIO based.
>>> GICv3 uses some system registers that are only available at EL2, and KVM
>>> needs some information contained in these registers before being able to
>>> get initialized.
>>
>> I see.
>>
>>>>> Indeed, this is completely broken (I just reproduced the issue on a
>>>>> model). I wish this kind of details had been checked earlier, but thanks
>>>>> for pointing it out.
>>>>>
>>>>>> Whats the best way to fix this?
>>>>>> - Call kvm_arch_hardware_enable() before vgic_hyp_init() and disable later?
>>>>>> - Fold the VGIC init stuff back into hardware_enable()?
>>>>>
>>>>> None of that works - kvm_arch_hardware_enable() is called once per CPU,
>>>>> while vgic_hyp_init() can only be called once. Also,
>>>>> kvm_arch_hardware_enable() is called from interrupt context, and I
>>>>> wouldn't feel comfortable starting probing DT and allocating stuff from
>>>>> there.
>>>>
>>>> Do you think so?
>>>> How about the fixup! patch attached below?
>>>> The point is that, like Ashwin's first idea, we initialize cpus temporarily
>>>> before kvm_vgic_hyp_init() and then soon reset cpus again. Thus,
>>>> kvm cpu hotplug will still continue to work as before.
>>>> Now that cpu_init_hyp_mode() is revived as exactly the same as Marc's
>>>> original code, the change will not be a big jump.
>>>
>>> This seems quite complicated:
>>> - init EL2 on  all CPUs
>>> - do some initialization
>>> - tear all CPUs EL2 down
>>> - let KVM drive the vectors being set or not
>>>
>>> My questions are: why do we need to do this on *all* cpus? Can't that
>>> work on a single one?
>>
>> I did initialize all the cpus partly because using preempt_enable/disable
>> looked a bit ugly and partly because we may, in the future, do additional
>> per-cpu initialization in kvm_vgic_hyp_init() and/or kvm_timer_hyp_init().
>> But if you're comfortable with preempt_*() stuff, I don' care.
>>
>>
>>> Also, the simple fact that we were able to get some junk value is a sign
>>> that something is amiss. I'd expect a splat of some sort, because we now
>>> have a possibility of doing things in the wrong context.
>>>
>>>>
>>>> If kvm_hyp_call() in vgic_v3_probe()/kvm_vgic_hyp_init() is a *problem*,
>>>> I hope this should work. Actually I confirmed that, with this fixup! patch,
>>>> we could run a kvm guest and also successfully executed kexec on model w/gic-v3.
>>>>
>>>> My only concern is the following kernel message I saw when kexec shut down
>>>> the kernel:
>>>> (Please note that I was running one kvm quest (pid=961) here.)
>>>>
>>>> ===
>>>> sh-4.3# ./kexec -d -e
>>>> kexec version: 15.11.16.11.06-g41e52e2
>>>> arch_process_options:112: command_line: (null)
>>>> arch_process_options:114: initrd: (null)
>>>> arch_process_options:115: dtb: (null)
>>>> arch_process_options:117: port: 0x0
>>>> kvm: exiting hardware virtualization
>>>> kvm [961]: Unsupported exception type: 6248304    <== this message
>>>
>>> That makes me feel very uncomfortable. It looks like we've exited a
>>> guest with some horrible value in X0. How is that even possible?
>>>
>>> This deserves to be investigated.
>>
>> I guess the problem is that cpu tear-down function is called even if a kvm guest
>> is still running in kvm_arch_vcpu_ioctl_run().
>> So adding a check whether cpu has been initialized or not in every iteration of
>> kvm_arch_vcpu_ioctl_run() will, if necessary, terminate a guest safely without entering
>> a guest mode. Since this check is done while interrupt is disabled, it won't
>> interfere with kvm_arch_hardware_disable() called via IPI.
>> See the attached fixup patch.
>>
>> Again, I verified the code on model.
>>
>> Thanks,
>> -Takahiro AKASHI
>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>
>> ----8<----
>>   From 77f273ba5e0c3dfcf75a5a8d1da8035cc390250c Mon Sep 17 00:00:00 2001
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Date: Fri, 11 Dec 2015 13:43:35 +0900
>> Subject: [PATCH] fixup! arm64: kvm: allows kvm cpu hotplug
>>
>> ---
>>    arch/arm/kvm/arm.c |   45 ++++++++++++++++++++++++++++++++++-----------
>>    1 file changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 518c3c7..d7e86fb 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -573,7 +573,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>    		/*
>>    		 * Re-check atomic conditions
>>    		 */
>> -		if (signal_pending(current)) {
>> +		if (__hyp_get_vectors() == hyp_default_vectors) {
>> +			/* cpu has been torn down */
>> +			ret = -ENOEXEC;
>> +			run->exit_reason = KVM_EXIT_SHUTDOWN;
>
>
> That feels completely overkill (and very slow). Why don't you maintain a
> per-cpu variable containing the CPU states, which will avoid calling
> __hyp_get_vectors() all the time? You should be able to reuse that
> construct everywhere.

OK. Since I have introduced per-cpu variable, kvm_arm_hardware_enabled, against
cpuidle issue, we will be able to re-use it.

> Also, I'm not sure about KVM_EXIT_SHUTDOWN. This looks very x86 specific
> (called on triple fault).

No, I don't think so.
Looking at kvm_cpu_exec() in kvm-all.c of qemu, KVM_EXIT_SHUTDOWN
is handled in a generic way and results in a reset request.
On the other hand, KVM_EXIT_FAIL_ENTRY seems more arch-specific.
In addition, if kvm_vcpu_ioctl() returns a negative value, run->exit_reason
will never be examined.
So I think
    ret -> 0
    run->exit_reason -> KVM_EXIT_SHUTDOWN
or just
    ret -> -ENOEXEC
is the best.

In either way, a guest will have no good chance to gracefully shutdown itself
because we're kexec'ing (without waiting for threads' termination).

-Takahiro AKASHI

> KVM_EXIT_FAIL_ENTRY looks more appropriate,
> and the hardware_entry_failure_reason field should be populated (and
> documented).
>
> Thanks,
>
> 	M.
>
