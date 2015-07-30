From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Jul 2015 16:37:47 +0100
Subject: [PATCH] irqchip/gic: Only allow the primary GIC to set the CPU map
In-Reply-To: <55BA3F2B.40500@nvidia.com>
References: <1438265479-15427-1-git-send-email-jonathanh@nvidia.com>
 <55BA35D2.5040307@arm.com> <55BA3D29.1000204@nvidia.com>
 <55BA3F2B.40500@nvidia.com>
Message-ID: <55BA44CB.4020007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/15 16:13, Jon Hunter wrote:
> 
> On 30/07/15 16:05, Jon Hunter wrote:
>>
>> On 30/07/15 15:33, Marc Zyngier wrote:
>>> On 30/07/15 15:11, Jon Hunter wrote:
>>>> The gic_init_bases() function initialises an array that stores the mapping
>>>> between the GIC and CPUs. This array is a global array that is
>>>> unconditionally initialised on every call to gic_init_bases(). Although,
>>>> it is not common for there to be more than one GIC instance, there are
>>>> some devices that do support nested GIC controllers and gic_init_bases()
>>>> can be called more than once.
>>>>
>>>> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
>>>> will only setup the mapping again for the CPU calling gic_init_bases().
>>>> Fix this by only allowing the CPU map to be configured for the primary GIC.
>>>>
>>>> For secondary GICs the CPU map is not relevant because these GICs do not
>>>> directly route the interrupts to the main CPU(s) but to other GICs or
>>>> devices.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>> This is a follow-up to the patch titled "irqchip: gic: Add a cpu map for
>>>> each GIC instance" and discussed here [1]. Based upon the discussion I have
>>>> re-worked and re-titled it approriately.
>>>>
>>>> [1] http://www.spinics.net/lists/kernel/msg2044421.html
>>>>
>>>>  drivers/irqchip/irq-gic.c | 43 +++++++++++++++++++++++++------------------
>>>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>>> index a530d9a9b810..7566fe259d27 100644
>>>> --- a/drivers/irqchip/irq-gic.c
>>>> +++ b/drivers/irqchip/irq-gic.c
>>>> @@ -416,19 +416,26 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>>>>  	int i;
>>>>  
>>>>  	/*
>>>> -	 * Get what the GIC says our CPU mask is.
>>>> +	 * Setting up the CPU map is only relevant for the primary GIC
>>>> +	 * because any nested/secondary GICs do not directly interface
>>>> +	 * with the CPU(s).
>>>>  	 */
>>>> -	BUG_ON(cpu >= NR_GIC_CPU_IF);
>>>> -	cpu_mask = gic_get_cpumask(gic);
>>>> -	gic_cpu_map[cpu] = cpu_mask;
>>>> +	if (gic == &gic_data[0]) {
>>>> +		/*
>>>> +		 * Get what the GIC says our CPU mask is.
>>>> +		 */
>>>> +		BUG_ON(cpu >= NR_GIC_CPU_IF);
>>>> +		cpu_mask = gic_get_cpumask(gic);
>>>> +		gic_cpu_map[cpu] = cpu_mask;
>>>>  
>>>> -	/*
>>>> -	 * Clear our mask from the other map entries in case they're
>>>> -	 * still undefined.
>>>> -	 */
>>>> -	for (i = 0; i < NR_GIC_CPU_IF; i++)
>>>> -		if (i != cpu)
>>>> -			gic_cpu_map[i] &= ~cpu_mask;
>>>> +		/*
>>>> +		 * Clear our mask from the other map entries in case they're
>>>> +		 * still undefined.
>>>> +		 */
>>>> +		for (i = 0; i < NR_GIC_CPU_IF; i++)
>>>> +			if (i != cpu)
>>>> +				gic_cpu_map[i] &= ~cpu_mask;
>>>> +	}
>>>>  
>>>>  	gic_cpu_config(dist_base, NULL);
>>>>  
>>>> @@ -977,13 +984,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>  	}
>>>>  
>>>>  	/*
>>>> -	 * Initialize the CPU interface map to all CPUs.
>>>> -	 * It will be refined as each CPU probes its ID.
>>>> -	 */
>>>> -	for (i = 0; i < NR_GIC_CPU_IF; i++)
>>>> -		gic_cpu_map[i] = 0xff;
>>>> -
>>>> -	/*
>>>>  	 * Find out how many interrupts are supported.
>>>>  	 * The GIC only supports up to 1020 interrupt sources.
>>>>  	 */
>>>> @@ -1028,6 +1028,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>  		return;
>>>>  
>>>>  	if (gic_nr == 0) {
>>>> +		/*
>>>> +		 * Initialize the CPU interface map to all CPUs.
>>>> +		 * It will be refined as each CPU probes its ID.
>>>> +		 * This is only necessary for the primary GIC.
>>>> +		 */
>>>> +		for (i = 0; i < NR_GIC_CPU_IF; i++)
>>>> +			gic_cpu_map[i] = 0xff;
>>>>  #ifdef CONFIG_SMP
>>>>  		set_smp_cross_call(gic_raise_softirq);
>>>>  		register_cpu_notifier(&gic_cpu_notifier);
>>>>
>>>
>>> Looks good.
>>>
>>> I think there is a another bug caused by 322895062 ("irqchip: gic:
>>> Preserve gic V2 bypass bits in cpu ctrl register"), where
>>> gic_cpu_if_up() only acts on the primary GIC. In the secondary GIC case,
>>> it will stay disabled.
>>>
>>> Mind fixing this while you're at it?
>>
>> Ah yes, I see. Ok, I will resend this with the other fix as a series.
> 
> Hmmm, what about gic_cpu_if_down()? Looks like the only user is
> vexpress-tc2. Ideally it should pass the gic_nr. I could make it pass 0
> by default.

Yeah, I saw it too. Not a big deal (TC2 has a single GIC anyway), but
it'd be nice to have some form of symmetry between up and down.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
