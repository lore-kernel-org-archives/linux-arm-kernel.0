From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 28 Jan 2014 17:35:52 +0000
Subject: [Xen-devel] [PATCH] arm/xen: Initialize event channels earlier
In-Reply-To: <alpine.DEB.2.02.1401281651400.4373@kaball.uk.xensource.com>
References: <1390920842-21886-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1401281651400.4373@kaball.uk.xensource.com>
Message-ID: <52E7EA78.5020305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 05:13 PM, Stefano Stabellini wrote:
> On Tue, 28 Jan 2014, Julien Grall wrote:
>> Event channels driver needs to be initialized very early. Until now, Xen
>> initialization was done after all CPUs was bring up.
>>
>> We can safely move the initialization to an early initcall.
>>
>> Also use a cpu notifier to:
>>     - Register the VCPU when the CPU is prepared
>>     - Enable event channel IRQ when the CPU is running
>>
>> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> 
> Did you test this patch in Dom0 as well as in DomUs?
> 

Only try dom0. I will try domU.

> 
>>  arch/arm/xen/enlighten.c |   84 ++++++++++++++++++++++++++++++----------------
>>  1 file changed, 55 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 293eeea..39b668e 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/cpu.h>
>>  
>>  #include <linux/mm.h>
>>  
>> @@ -154,12 +155,11 @@ int xen_unmap_domain_mfn_range(struct vm_area_struct *vma,
>>  }
>>  EXPORT_SYMBOL_GPL(xen_unmap_domain_mfn_range);
>>  
>> -static void __init xen_percpu_init(void *unused)
>> +static void xen_percpu_init(int cpu)
>>  {
>>  	struct vcpu_register_vcpu_info info;
>>  	struct vcpu_info *vcpup;
>>  	int err;
>> -	int cpu = get_cpu();
>>  
>>  	pr_info("Xen: initializing cpu%d\n", cpu);
>>  	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
>> @@ -170,9 +170,11 @@ static void __init xen_percpu_init(void *unused)
>>  	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
>>  	BUG_ON(err);
>>  	per_cpu(xen_vcpu, cpu) = vcpup;
>> +}
>>  
>> +static void xen_interrupt_init(void)
>> +{
>>  	enable_percpu_irq(xen_events_irq, 0);
>> -	put_cpu();
>>  }
>>  
>>  static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
>> @@ -193,6 +195,36 @@ static void xen_power_off(void)
>>  		BUG();
>>  }
>>  
>> +static irqreturn_t xen_arm_callback(int irq, void *arg)
>> +{
>> +	xen_hvm_evtchn_do_upcall();
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int xen_cpu_notification(struct notifier_block *self,
>> +				unsigned long action,
>> +				void *hcpu)
>> +{
>> +	int cpu = (long)hcpu;
>> +
>> +	switch (action) {
>> +	case CPU_UP_PREPARE:
>> +		xen_percpu_init(cpu);
>> +		break;
>> +	case CPU_STARTING:
>> +		xen_interrupt_init();
>> +		break;
> 
> Is CPU_STARTING guaranteed to be called on the new cpu only?

Yes.

> If so, why not call both xen_percpu_init and xen_interrupt_init on
> CPU_STARTING?

Just in case that xen_vcpu is used somewhere else by a cpu notifier
callback CPU_STARTING. We don't know which callback is called first.

> As it stands I think you introduced a subtle change (that might be OK
> but I think is unintentional): xen_percpu_init might not be called from
> the same cpu as its target anymore.

No, xen_percpu_init and xen_interrupt_init are called on the boot cpu at
the end of xen_guest_init.

> 
> 
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block xen_cpu_notifier = {
>> +	.notifier_call = xen_cpu_notification,
>> +};
>> +
>>  /*
>>   * see Documentation/devicetree/bindings/arm/xen.txt for the
>>   * documentation of the Xen Device Tree format.
>> @@ -209,6 +241,7 @@ static int __init xen_guest_init(void)
>>  	const char *xen_prefix = "xen,xen-";
>>  	struct resource res;
>>  	phys_addr_t grant_frames;
>> +	int cpu;
>>  
>>  	node = of_find_compatible_node(NULL, NULL, "xen,xen");
>>  	if (!node) {
>> @@ -281,9 +314,27 @@ static int __init xen_guest_init(void)
>>  	disable_cpuidle();
>>  	disable_cpufreq();
>>  
>> +	xen_init_IRQ();
>> +
>> +	if (xen_events_irq < 0)
>> +		return -ENODEV;
> 
> Since you are moving this code to xen_guest_init, you can check for
> xen_events_irq earlier on, where we parse the irq from device tree.

Will do.


-- 
Julien Grall
