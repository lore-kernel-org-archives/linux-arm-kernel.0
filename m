From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 18:09:48 +0100
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <55EDC12E.8000408@arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55EDC12E.8000408@arm.com>
Message-ID: <55EDC4DC.4040405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/15 17:54, Suzuki K. Poulose wrote:
> On 14/08/15 19:28, Robert Richter wrote:
>> From: Robert Richter <rrichter@cavium.com>
>>
>> This patch implements Cavium ThunderX erratum 23154.
>>
>> The gicv3 of ThunderX requires a modified version for reading the IAR
>> status to ensure data synchronization. Since this is in the fast-path
>> and called with each interrupt, runtime patching is used using jump
>> label patching for smallest overhead (no-op). This is the same
>> technique as used for tracepoints.
>>
>> v4:
>>   * simplify code to only use cpus_have_cap() in gicv3_enable_quirks()
>>
>> v3:
>>   * fix erratum to be dependend from midr
>>   * use arm64 errata framework
>>
>> v2:
>>   * implement code in a single asm() to keep instruction sequence
>>   * added comment to the code that explains the erratum
>>   * apply workaround also if running as guest, thus check MIDR
>>
>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>> ---
>>   arch/arm64/Kconfig                  | 11 ++++++++++
>>   arch/arm64/include/asm/cpufeature.h |  3 ++-
>>   arch/arm64/include/asm/cputype.h    | 18 +++++++++-------
>>   arch/arm64/kernel/cpu_errata.c      |  9 ++++++++
>>   drivers/irqchip/irq-gic-v3.c        | 42 ++++++++++++++++++++++++++++++++++++-
>>   5 files changed, 74 insertions(+), 9 deletions(-)
>>
> 
> ...
> 
>>   };
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index c52f7ba205b4..4211c39b8744 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -107,7 +107,7 @@ static void gic_redist_wait_for_rwp(void)
> 
> ...
> 
>> +}
>> +
>>   static void __maybe_unused gic_write_pmr(u64 val)
>>   {
>>   	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
>> @@ -766,6 +798,12 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>>   	.free = gic_irq_domain_free,
>>   };
>>
>> +static void gicv3_enable_quirks(void)
>> +{
>> +	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
>> +		static_key_slow_inc(&is_cavium_thunderx);
> 
> May be you could use the enable() method added to struct arm64_cpu_capability
> here to perform the above operation, added by James :
> 
> commit 1c0763037f1e1caef739e36e09c6d41ed7b61b2d
> Author: James Morse <james.morse@arm.com>
> Date:   Tue Jul 21 13:23:28 2015 +0100
> 
>      arm64: kernel: Add cpufeature 'enable' callback
> 
> 
>> +}
>> +
>>   static int __init gic_of_init(struct device_node *node, struct device_node *parent)
>>   {
>>   	void __iomem *dist_base;
>> @@ -825,6 +863,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
>>   	gic_data.nr_redist_regions = nr_redist_regions;
>>   	gic_data.redist_stride = redist_stride;
>>
>> +	gicv3_enable_quirks();
>> +
> 
> than adding a hook here ?

It feels like a good idea, except that it creates a weird dependency
between the core arch code and the GIC driver. Can you think of an
elegant way to deal with this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
