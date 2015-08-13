From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 13 Aug 2015 10:00:38 -0600
Subject: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <20150812234756.GO26614@codeaurora.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
 <20150812234756.GO26614@codeaurora.org>
Message-ID: <20150813160038.GP52339@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12 2015 at 17:47 -0600, Stephen Boyd wrote:
>On 08/04, Lina Iyer wrote:
>> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>  	}
>>
>> -
>
>Remove noise please.
>
OK

>>  	memset(&secondary_data, 0, sizeof(secondary_data));
>>  	return ret;
>>  }
>> @@ -205,6 +205,9 @@ int __cpu_disable(void)
>>  	unsigned int cpu = smp_processor_id();
>>  	int ret;
>>
>> +	/* We dont need the CPU device anymore. */
>> +	pm_runtime_put_sync(get_cpu_device(cpu));
>
>This is all very generic. Any reason it can't be done at a higher
>level for all architectures? It certainly seems like
>cpu_startup_entry() could be modifed to do the
>pm_runtime_get_sync().
>
I am suspecting, when the concept of CPU PM domains are finalized, they
would probably move out of the ARM domain and into generic.  Will keep
that in mind.

>> +
>>  	ret = platform_cpu_disable(cpu);
>>  	if (ret)
>>  		return ret;
>> @@ -272,6 +275,13 @@ void __ref cpu_die(void)
>>  {
>>  	unsigned int cpu = smp_processor_id();
>>
>> +	/*
>> +	 * We dont need the CPU device anymore.
>> +	 * Lets do this before IRQs are disabled to allow
>> +	 * runtime PM to suspend the domain as well.
>> +	 */
>> +	pm_runtime_put_sync(get_cpu_device(cpu));
>
>The two put calls is confusing. __cpu_disable() is called on the
>CPU that's dying, and cpu_die() is called on the CPU that's doing
>the takedown.
>
Is that right? Looking at the code and the comments, I can only imagine
that they must be called on the CPU going down. If thats not the case,
then I need to fix this.

>That would be two decrements but only one increment
>in secondary_start_kernel()? How is this properly balanced?
>
I dont see __cpu_disable() ending up at cpu_die(). These seem two
different exit points. I will check again.

>> +
>>  	idle_task_exit();
>>
>>  	local_irq_disable();
>> @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
>>  	local_irq_enable();
>>  	local_fiq_enable();
>>
>> +	/* We are running, enable runtime PM for the CPU. */
>> +	cpu_dev = get_cpu_device(cpu);
>> +	if (cpu_dev)
>> +		pm_runtime_get_sync(cpu_dev);
>
>Also, where would the dev->power.irq_safe flag be set if we
>aren't using the genpd DT stuff? It looks like we're going to
>start causing warnings on devices that don't have the DT magic.
>
Not necessarily. I have added _get and _put at points, when the
interrupts are still enabled. So there should not be a need for the CPU
devices to be IRQ safe. They will operate as regular devices. If they
are attached to a non-IRQ safe domain, they would effect power savings
on the domain.

>Please add a hotplug test with some device that isn't using this
>genpd code to catch problems. Also please turn on lockdep and RCU
>lockdep, touching the idle code like this
>
Good idea. Will add and test.

Thanks Stephen for the review.

Thanks,
Lina
