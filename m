From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 09 Apr 2015 13:53:33 +0900
Subject: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
In-Reply-To: <20150408130520.GB5977@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
 <20150408130520.GB5977@leverpostej>
Message-ID: <552605CD.7000704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 04/08/2015 10:05 PM, Mark Rutland wrote:
> On Thu, Apr 02, 2015 at 06:40:13AM +0100, AKASHI Takahiro wrote:
>> The current kvm implementation keeps EL2 vector table installed even
>> when the system is shut down. This prevents kexec from putting the system
>> with kvm back into EL2 when starting a new kernel.
>>
>> This patch resolves this issue by calling a cpu tear-down function via
>> reboot notifier, kvm_reboot_notify(), which is invoked by
>> kernel_restart_prepare() in kernel_kexec().
>> While kvm has a generic hook, kvm_reboot(), we can't use it here because
>> a cpu teardown function will not be invoked, under current implementation,
>> if no guest vm has been created by kvm_create_vm().
>> Please note that kvm_usage_count is zero in this case.
>>
>> We'd better, in the future, implement cpu hotplug support and put the
>> arch-specific initialization into kvm_arch_hardware_enable/disable().
>> This way, we would be able to revert this patch.
>
> Why can't we use kvm_arch_hardware_enable/disable() currently?

IIUC, kvm will call kvm_arch_hardware_enable() iff a new guest is being
created *and* cpus have not been initialized yet. kvm_usage_count==0
indicates this. Similarly, kvm will call kvm_arch_hardware_disable() whenever
a guest is being terminated (i.e. kvm_usage_count != 0).
Therefore if kvm_arch_hardware_enable/disable() also handle EL2 vector table
initialization, we don't have to have any particular operations, as my patch
does, for kexec case.
(a long-term solution)

Since arm64 doesn't implement kvm_arch_hardware_enable() (I don't know why),
I'm trying to fix the problem by adding a minimum tear-down function, kvm_cpu_reset,
and invoking it via a reboot hook.
(an interim fix)

This scheme of a interim fix and a long-term solution, I heard, has been agreed
by Marc and Geoff in LCU14. I just followed it.

Is this clear?

>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm/kvm/arm.c     |   21 +++++++++++++++++++++
>>   arch/arm64/kvm/Kconfig |    1 -
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 39df694..f64713e 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/fs.h>
>>   #include <linux/mman.h>
>> +#include <linux/reboot.h>
>>   #include <linux/sched.h>
>>   #include <linux/kvm.h>
>>   #include <trace/events/kvm.h>
>> @@ -1100,6 +1101,23 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
>>   	return NULL;
>>   }
>>
>> +static int kvm_reboot_notify(struct notifier_block *nb,
>> +			     unsigned long val, void *v)
>> +{
>> +	/*
>> +	 * Reset each CPU in EL2 to initial state.
>> +	 */
>> +	on_each_cpu(kvm_cpu_reset, NULL, 1);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block kvm_reboot_nb = {
>> +	.notifier_call		= kvm_reboot_notify,
>> +	.next			= NULL,
>> +	.priority		= 0, /* FIXME */
>
> It would be helpful for the comment to explain why this is wrong, and
> what needs fixing.

Thank for reminding me of this.

*priority* enforces a calling order of registered hook functions.
If some hook returns NOTIFY_STOP_MASK, subsequent hooks won't be called.
(Nevertheless, reboot sequence will go ahead. See kernel_restart_prepare()/
notifier_call_chain().)

So we should make sure that kvm_reboot_notify() be called
1) after any hook functions which may depend on kvm, and
2) before any hook functions which kvm may depend on, and
3) before any hook functions that may return NOTIFY_STOP_MASK

But how can we guarantee this and determine a priority of kvm_reboot_notify()?
Looking into all the occurrences of register_reboot_notifier(),
1) => nothing
2) => virt/kvm/kvm_main.c (priority: 0)
3) => drivers/cpufreq/s32416-cpufreq.c (priority: 0)
       drivers/cpufreq/s5pv210-cpufreq.c (priority: 0)

So a priority higher than zero might be safe and better, but exactly what?
Some hooks use "INT_MAX."

Thanks,
-Takahiro AKASHI

> Mark.
>
