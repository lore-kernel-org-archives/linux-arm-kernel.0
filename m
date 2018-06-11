From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 11 Jun 2018 19:23:42 +0800
Subject: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
In-Reply-To: <0ebd8eef-1a86-3c7e-cd3b-f9580c497b5c@arm.com>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
 <0ebd8eef-1a86-3c7e-cd3b-f9580c497b5c@arm.com>
Message-ID: <5B1E5BBE.9010907@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marc

On 2018/6/11 17:31, Marc Zyngier wrote:
> On 06/06/18 03:40, Yang Yingliang wrote:
>> When the kernel booted with maxcpus=x, 'x' is smaller
>> than actual cpu numbers, the TAs of offline cpus won't
>> be set to its->collection.
>>
>> If LPI is bind to offline cpu, sync cmd will use zero TA,
>> it leads to ITS queue timeout.  Fix this by choosing a
>> online cpu, if there is no online cpu in cpu_mask.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5416f2b..d8b9539 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2309,7 +2309,9 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>>   		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>>   
>>   	/* Bind the LPI to the first possible CPU */
>> -	cpu = cpumask_first(cpu_mask);
>> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>> +	if (cpu >= nr_cpu_ids)
>> +		cpu = cpumask_first(cpu_online_mask);
> I've thought about this one a bit more, and apart from breaking TX1
> in a very bad way, I think it is actually correct. It is just that
> the commit message doesn't make much sense.
>
> The way I understand it is:
> - this is a NUMA system, with at least one node not online
> - the SRAT table indicates that this ITS is local to an offline node
Yes, your comment is more proper and correct. Mine describes how the BUG 
happens.
I will send a v3 later with proper comment.

Thanks,
Yang
>
> In that case, we need to pick an online CPU, and any will do (again,
> ignoring the silly Cavium erratum). Explained like this, the above
> hunk is sensible, and just needs to handle the TX1 quirk. Something like:
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5416f2b2ac21..21b7b5151177 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2309,7 +2309,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>   		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>   
>   	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first(cpu_mask);
> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	if (cpu >= nr_cpu_idx) {
> +		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
> +			return -EINVAL;
> +
> +		cpu = cpumask_first(cpu_online_mask);
> +	}
>   	its_dev->event_map.col_map[event] = cpu;
>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>   
>
>>   	its_dev->event_map.col_map[event] = cpu;
>>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   
>> @@ -2466,7 +2468,10 @@ static int its_vpe_set_affinity(struct irq_data *d,
>>   				bool force)
>>   {
>>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> -	int cpu = cpumask_first(mask_val);
>> +	int cpu = cpumask_first_and(mask_val, cpu_online_mask);
>> +
>> +	if (cpu >= nr_cpu_ids)
>> +		cpu = cpumask_first(cpu_online_mask);
>>   
>>   	/*
>>   	 * Changing affinity is mega expensive, so let's be as lazy as
>>
> This hunk, on the other hand, is completely useless. Look how this is
> called from vgic_v4_flush_hwstate():
>
> 	err = irq_set_affinity(irq, cpumask_of(smp_processor_id()));
>
> The mask is always that of the CPU we run on, and we're in a non-premptible
> section. So no way we can be targeting an offline CPU.
>
> If you quickly respin this patch with a decent commit log, I'll take it.
>
> Thanks,
>
> 	M.
