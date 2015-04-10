From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 10 Apr 2015 15:15:26 +0900
Subject: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
In-Reply-To: <20150409150244.GG9648@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
 <20150408130520.GB5977@leverpostej> <552605CD.7000704@linaro.org>
 <20150409150244.GG9648@leverpostej>
Message-ID: <55276A7E.1080508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark
Cc: Marc, Geoff

On 04/10/2015 12:02 AM, Mark Rutland wrote:
> On Thu, Apr 09, 2015 at 05:53:33AM +0100, AKASHI Takahiro wrote:
>> Mark,
>>
>> On 04/08/2015 10:05 PM, Mark Rutland wrote:
>>> On Thu, Apr 02, 2015 at 06:40:13AM +0100, AKASHI Takahiro wrote:
>>>> The current kvm implementation keeps EL2 vector table installed even
>>>> when the system is shut down. This prevents kexec from putting the system
>>>> with kvm back into EL2 when starting a new kernel.
>>>>
>>>> This patch resolves this issue by calling a cpu tear-down function via
>>>> reboot notifier, kvm_reboot_notify(), which is invoked by
>>>> kernel_restart_prepare() in kernel_kexec().
>>>> While kvm has a generic hook, kvm_reboot(), we can't use it here because
>>>> a cpu teardown function will not be invoked, under current implementation,
>>>> if no guest vm has been created by kvm_create_vm().
>>>> Please note that kvm_usage_count is zero in this case.
>>>>
>>>> We'd better, in the future, implement cpu hotplug support and put the
>>>> arch-specific initialization into kvm_arch_hardware_enable/disable().
>>>> This way, we would be able to revert this patch.
>>>
>>> Why can't we use kvm_arch_hardware_enable/disable() currently?
>>
>> IIUC, kvm will call kvm_arch_hardware_enable() iff a new guest is being
>> created *and* cpus have not been initialized yet. kvm_usage_count==0
>> indicates this. Similarly, kvm will call kvm_arch_hardware_disable() whenever
>> a guest is being terminated (i.e. kvm_usage_count != 0).
>> Therefore if kvm_arch_hardware_enable/disable() also handle EL2 vector table
>> initialization, we don't have to have any particular operations, as my patch
>> does, for kexec case.
>> (a long-term solution)
>>
>> Since arm64 doesn't implement kvm_arch_hardware_enable() (I don't know why),
>> I'm trying to fix the problem by adding a minimum tear-down function, kvm_cpu_reset,
>> and invoking it via a reboot hook.
>> (an interim fix)
>
> What I don't understand is why we can't move the init and tear-down
> functions into kvm_arch_hardware_enable/disable(). They seem to be for
> precisely what you are implementing, with the only difference being the
> time that they are called.

I don't know, neither. I just followed the discussions between Marc and Geoff,
and their conclusion. I guessed that *refactoring* might be more complicated than
expected.

FYI, I gave a quick try to kvm_arch_hardware_enable() approach by removing
cpu_init_hyp_mode() from init_hyp_mode() and putting it into kvm_arch_hardware_enable(),
and it seems to work, at least, in my environment:
    boot => start a kvm guest => kexec reboot => start a kvm guest

> Either I'm missing something, or we can simply implement the existing
> hooks. I assume I'm missing something.

Marc, Geoff, any comments?


>>>> +static struct notifier_block kvm_reboot_nb = {
>>>> +	.notifier_call		= kvm_reboot_notify,
>>>> +	.next			= NULL,
>>>> +	.priority		= 0, /* FIXME */
>>>
>>> It would be helpful for the comment to explain why this is wrong, and
>>> what needs fixing.
>>
>> Thank for reminding me of this.
>>
>> *priority* enforces a calling order of registered hook functions.
>> If some hook returns NOTIFY_STOP_MASK, subsequent hooks won't be called.
>> (Nevertheless, reboot sequence will go ahead. See kernel_restart_prepare()/
>> notifier_call_chain().)
>>
>> So we should make sure that kvm_reboot_notify() be called
>> 1) after any hook functions which may depend on kvm, and
>
> Which hooks depend on KVM?

I think I answered this question below:
 >> But how can we guarantee this and determine a priority of kvm_reboot_notify()?
 >> Looking into all the occurrences of register_reboot_notifier(),
 >> 1) => nothing
 >> 2) => virt/kvm/kvm_main.c (priority: 0)
 >> 3) => drivers/cpufreq/s32416-cpufreq.c (priority: 0)
 >>        drivers/cpufreq/s5pv210-cpufreq.c (priority: 0)
 >>
 >> So a priority higher than zero might be safe and better, but exactly what?
 >> Some hooks use "INT_MAX."

Thanks,
-Takahiro AKASHI

>> 2) before any hook functions which kvm may depend on, and
>
> Which other hooks does KVM depend on?
>
>> 3) before any hook functions that may return NOTIFY_STOP_MASK
>
> I think this would be solved by using kvm_arch_hardware_enable/disable.
> As far as I can tell, the VMs would be destroyed earlier (and hence KVM
> disabled) before we got to the final teardown.
>
> Thanks,
> Mark.
>
