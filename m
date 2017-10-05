From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Oct 2017 19:00:44 +0100
Subject: [PATCH v2] irqchip/gicv3: Add support for Range Selector (RS)
 feature
In-Reply-To: <fe4195c9-8e3d-59a7-aa1b-34e1bd9506d4@codeaurora.org>
References: <1505877666-15497-1-git-send-email-shankerd@codeaurora.org>
 <e672dddd-8b8b-d708-da30-d721c29a6f32@arm.com>
 <fe4195c9-8e3d-59a7-aa1b-34e1bd9506d4@codeaurora.org>
Message-ID: <c640ec66-8a8c-f435-c1a9-33816f5c366d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/17 18:49, Shanker Donthineni wrote:
> Hi Marc,
> 
> On 10/05/2017 05:43 AM, Marc Zyngier wrote:
>> On 20/09/17 04:21, Shanker Donthineni wrote:
>>> A new feature Range Selector (RS) has been added to GIC specification
>>> in order to support more than 16 CPUs at affinity level 0. New fields
>>> are introduced in SGI system registers (ICC_SGI0R_EL1, ICC_SGI1R_EL1
>>> and ICC_ASGI1R_EL1) to relax an artificial limit of 16 at level 0.
>>>
>>> - A new RSS field in ICC_CTLR_EL3, ICC_CTLR_EL1 and ICV_CTLR_EL1:
>>>   [18] - Range Selector Support (RSS)
>>>   0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
>>>   0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.
>>>
>>> - A new RS field in ICC_SGI0R_EL1, ICC_SGI1R_EL1 and ICC_ASGI1R_EL1:
>>>   [47:44] - RangeSelector (RS) which group of 16 TargetList[n] field
>>>             TargetList[n] represents aff0 value ((RS*16)+n)
>>>             When ICC_CTLR_EL3.RSS==0 or ICC_CTLR_EL1.RSS==0, RS is RES0.
>>>
>>> - A new RSS field in GICD_TYPER:
>>>   [26] - Range Selector Support (RSS)
>>>   0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
>>>   0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.
>>>
>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>> ---
>>> Changes since v1:
>>>    - Addrssed Marc's review comments on RSS validation checks.
>>>    - Apply code changes to gic_compute_target_list() to support RSS feature.
>>>    - Fix the compilation on ARM32.
>>>
>>>  arch/arm/include/asm/arch_gicv3.h   |  5 ++++
>>>  arch/arm64/include/asm/arch_gicv3.h |  5 ++++
>>>  drivers/irqchip/irq-gic-v3.c        | 60 +++++++++++++++++++++++++++++++------
>>>  include/linux/irqchip/arm-gic-v3.h  |  4 +++
>>>  4 files changed, 65 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
>>> index 2747590..4a3b3c2 100644
>>> --- a/arch/arm/include/asm/arch_gicv3.h
>>> +++ b/arch/arm/include/asm/arch_gicv3.h
>>> @@ -196,6 +196,11 @@ static inline void gic_write_ctlr(u32 val)
>>>  	isb();
>>>  }
>>>  
>>> +static inline u32 gic_read_ctlr(void)
>>> +{
>>> +	return read_sysreg(ICC_CTLR);
>>> +}
>>> +
>>>  static inline void gic_write_grpen1(u32 val)
>>>  {
>>>  	write_sysreg(val, ICC_IGRPEN1);
>>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
>>> index 8cef47f..aa2c795 100644
>>> --- a/arch/arm64/include/asm/arch_gicv3.h
>>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>>> @@ -87,6 +87,11 @@ static inline void gic_write_ctlr(u32 val)
>>>  	isb();
>>>  }
>>>  
>>> +static inline u32 gic_read_ctlr(void)
>>> +{
>>> +	return read_sysreg_s(SYS_ICC_CTLR_EL1);
>>> +}
>>> +
>>>  static inline void gic_write_grpen1(u32 val)
>>>  {
>>>  	write_sysreg_s(val, SYS_ICC_IGRPEN1_EL1);
>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>> index 984c3ec..2d56f2b 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -55,6 +55,7 @@ struct gic_chip_data {
>>>  	struct irq_domain	*domain;
>>>  	u64			redist_stride;
>>>  	u32			nr_redist_regions;
>>> +	bool			has_rss;
>>>  	unsigned int		irq_nr;
>>>  	struct partition_desc	*ppi_descs[16];
>>>  };
>>> @@ -63,7 +64,9 @@ struct gic_chip_data {
>>>  static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
>>>  
>>>  static struct gic_kvm_info gic_v3_kvm_info;
>>> +static DEFINE_PER_CPU(bool, has_rss);
>>>  
>>> +#define MPIDR_RS(mpidr)			(((mpidr) & 0xF0UL) >> 4)
>>>  #define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
>>>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>>>  #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)
>>> @@ -483,6 +486,10 @@ static int gic_populate_rdist(void)
>>>  
>>>  static void gic_cpu_sys_reg_init(void)
>>>  {
>>> +	int i, cpu = smp_processor_id();
>>> +	u64 mpidr = cpu_logical_map(cpu);
>>> +	bool need_rss = false;
>>> +
>>>  	/*
>>>  	 * Need to check that the SRE bit has actually been set. If
>>>  	 * not, it means that SRE is disabled at EL2. We're going to
>>> @@ -514,6 +521,40 @@ static void gic_cpu_sys_reg_init(void)
>>>  
>>>  	/* ... and let's hit the road... */
>>>  	gic_write_grpen1(1);
>>> +
>>> +	/* Keep the RSS capability status in per_cpu variable */
>>> +	per_cpu(has_rss, cpu) = !!(gic_read_ctlr() & ICC_CTLR_EL1_RSS);
>>> +
>>> +	/* Check all the CPUs have capable of sending SGIs to other CPUs */
>>> +	for_each_online_cpu(i) {
>>> +		if (cpu == i)
>>> +			continue;
>>> +
>>> +		if (MPIDR_RS(mpidr) && (!per_cpu(has_rss, i))) {
>>> +			pr_crit("CPU%d has no RSS, SGIs aren't reachable to CPU%d",
>>> +				i, cpu);
>>> +			continue;
>>> +		}
>>> +
>>> +		if (MPIDR_RS(cpu_logical_map(i)) && (!per_cpu(has_rss, cpu))) {
>>> +			pr_crit("CPU%d has no RSS, SGIs aren't reachable to CPU%d",
>>> +				cpu, i);
>>> +			continue;
>>> +		}
>>> +
>>> +		if (MPIDR_RS(mpidr) || MPIDR_RS(cpu_logical_map(i)))
>>> +			need_rss = true;
>>> +	}
>>
>> The logic feels a bit clumsy, and fails to warn if the first CPU needs 
>> RSS while the distributor doesn't have it. Yes, that's the ultimate 
>> corner case, but hey, we might as well do the right thing... ;-)
>>
> 
> Agree with you it won't warn on systems booted with a single core. In case of
> multicore boot it warns while booting the secondary cores and covers all
> the combination of CPUs. Anyway I like simplified idea with a fewer lines of
> code that does the same purpose.
> 
> 
>> How about something like:
>>
>> 	for_each_online_cpu(i) {
>> 		bool have_rss = per_cpu(has_rss, i) || per_cpu(has_rss, cpu);
>> 		need_rss = MPIDR_RS(mpidr) || MPIDR_RS(cpu_logical_map(i);
>>
>> 		if (need_rss != have_rss)
>> 			pr_crit("CPU%d (%lx) can't SGI CPU%d (%lx), no RSS\n",
>> 				cpu, mpidr, i, cpu_logical_map(i));
>> 	}
>>
> 
> This code should work with minor changes on top of the above code snippet.
> 
>  	for_each_online_cpu(i) {
>  		bool have_rss = per_cpu(has_rss, i) && per_cpu(has_rss, cpu);
>  		need_rss = MPIDR_RS(mpidr) || MPIDR_RS(cpu_logical_map(i)) || need_rss;

Ah, I managed to kill a single character that made it work.
At some point, it said:

		need_rss |= MPIDR_RS(mpidr) || MPIDR_RS(cpu_logical_map(i);

And looking at it a bit more closely, you can init need_rss to
MPIDR_RS(mpidr) at the beginning of the function, and make this

		need_rss |= MPIDR_RS(cpu_logical_map(i);

Have a play with it anyway, I haven't looked too closely at it...

>  		if (need_rss != have_rss)
>  			pr_crit("CPU%d (%lx) can't SGI CPU%d (%lx), no RSS\n",
>  				cpu, mpidr, i, cpu_logical_map(i));
>  	}
> 
>> which is informative enough.
>>
>>> +
>>> +	/**
>>> +	 * GIC spec says, when ICC_CTLR_EL1.RSS==1 and GICD_TYPER.RSS==0,
>>> +	 * writing ICC_ASGI1R_EL1 register with RS != 0 is a CONSTRAINED
>>> +	 * UNPREDICTABLE choice of :
>>> +	 *   - The write is ignored.
>>> +	 *   - The RS field is treated as 0.
>>> +	 */
>>> +	if (need_rss && (!gic_data.has_rss))
>>> +		pr_crit("RSS support is required but GICD doesn't support it\n");
>>
>> This can be turn to a pr_crit_once, as there is no need to scream for
>> each CPU (the thing is dead anyway).
>>
> 
> I'll fix in v3.

Great, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
