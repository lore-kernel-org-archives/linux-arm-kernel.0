From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 Aug 2017 10:44:53 +0100
Subject: [PATCH RFC] irqchip: gic-v3: Support forced cpu irq affinity
 setting
In-Reply-To: <a13295d7-40cc-24d7-a99a-3d349fbb91cb@samsung.com>
References: <CGME20170808091129epcas1p48d0523675178cb841d97e64d5baab75f@epcas1p4.samsung.com>
 <1502183093-30327-1-git-send-email-alim.akhtar@samsung.com>
 <7ea6b8d3-762a-d4e9-3b64-609b534c3960@arm.com>
 <a13295d7-40cc-24d7-a99a-3d349fbb91cb@samsung.com>
Message-ID: <c6720d49-e9d8-cbf8-88e1-8c94a09e0804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/17 10:27, Alim Akhtar wrote:
> 
> 
> On 08/08/2017 02:52 PM, Marc Zyngier wrote:
>> On 08/08/17 10:04, Alim Akhtar wrote:
>>> Skip check for online cpu mask when setting irq affinity of per cpu timer
>>> during early startup of not yet online cpu.
>>>
>>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>>> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   drivers/irqchip/irq-gic-v3.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> Currently when non boot CPUs comes up and if setting of IRQ affinity gets called
>>> before cpu online status gets updated, gic_mpidr_to_affinity() returns
>>> undesirable cpu number. Using __force__ flag ignore cpu_online_mask and setup
>>> the intended cpu affinity for the irq.
>>>
>>> The same approch is used in gicv2
>>> (commit: ffde1de64012c: irqchip: Gic: Support forced affinity setting)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index dbffb7a..c238c64 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -640,11 +640,16 @@ static void gic_smp_init(void)
>>>   static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>>   			    bool force)
>>>   {
>>> -	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>> +	unsigned int cpu;
>>>   	void __iomem *reg;
>>>   	int enabled;
>>>   	u64 val;
>>>   
>>> +	if (!force)
>>> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>> +	else
>>> +		cpu = cpumask_first(mask_val);
>>> +
>>>   	if (cpu >= nr_cpu_ids)
>>>   		return -EINVAL;
>>>   
>>>
>>
>> See
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.13&id=65a30f8b300107266f316d550f060ccc186201a3
>>
> 
> Thanks Marc for above link. Is this already queued in some tree? I can't 
> find this is linux-next.

It is queued as a fix for 4.13, bug tglx is offline for the time being,
so this has not hit -next yet.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
