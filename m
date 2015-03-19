From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 19 Mar 2015 11:45:35 +0800
Subject: [PATCH v10 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC
 and register device's gsi
In-Reply-To: <20150318184114.GL10863@arm.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-16-git-send-email-hanjun.guo@linaro.org>
 <20150318184114.GL10863@arm.com>
Message-ID: <550A465F.50701@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2015/3/19 2:41, Will Deacon wrote:
> On Wed, Mar 11, 2015 at 12:39:41PM +0000, Hanjun Guo wrote:
>> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
>> used, and then register device's gsi with the core IRQ subsystem.
>>
>> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
>> since gsi is unique in the system, so use hwirq number directly
>> for the mapping.
>>
>> We are going to implement stacked domains when GICv2m, GICv3, ITS
>> support are added.
>>
>> CC: Marc Zyngier <marc.zyngier@arm.com>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c       |  3 ++
>>  include/linux/acpi.h     |  1 +
>>  3 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index c9203c0..dec6f8a 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -76,6 +76,12 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>>  }
>>  
>>  /*
>> + * Since we're on ARM, the default interrupt routing model
>> + * clearly has to be GIC.
>> + */
>> +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
>> +
>> +/*
>>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
>>   * or early_memremap() should be called here to for ACPI table mapping.
>>   */
>> @@ -218,6 +224,73 @@ void __init acpi_init_cpus(void)
>>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>>  }
>>  
>> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>> +{
>> +	*irq = irq_find_mapping(NULL, gsi);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>> +
>> +/*
>> + * success: return IRQ number (>0)
>> + * failure: return =< 0
>> + */
>> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
>> +{
>> +	unsigned int irq;
>> +	unsigned int irq_type;
>> +
>> +	/*
>> +	 * ACPI have no bindings to indicate SPI or PPI, so we
>> +	 * use different mappings from DT in ACPI.
>> +	 *
>> +	 * For FDT
>> +	 * PPI interrupt: in the range [0, 15];
>> +	 * SPI interrupt: in the range [0, 987];
>> +	 *
>> +	 * For ACPI, GSI should be unique so using
>> +	 * the hwirq directly for the mapping:
>> +	 * PPI interrupt: in the range [16, 31];
>> +	 * SPI interrupt: in the range [32, 1019];
>> +	 */
>> +
>> +	if (trigger == ACPI_EDGE_SENSITIVE &&
>> +				polarity == ACPI_ACTIVE_LOW)
>> +		irq_type = IRQ_TYPE_EDGE_FALLING;
>> +	else if (trigger == ACPI_EDGE_SENSITIVE &&
>> +				polarity == ACPI_ACTIVE_HIGH)
>> +		irq_type = IRQ_TYPE_EDGE_RISING;
>> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
>> +				polarity == ACPI_ACTIVE_LOW)
>> +		irq_type = IRQ_TYPE_LEVEL_LOW;
>> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
>> +				polarity == ACPI_ACTIVE_HIGH)
>> +		irq_type = IRQ_TYPE_LEVEL_HIGH;
>> +	else
>> +		irq_type = IRQ_TYPE_NONE;
>> +
>> +	/*
>> +	 * Since only one GIC is supported in ACPI 5.0, we can
>> +	 * create mapping refer to the default domain
>> +	 */
>> +	irq = irq_create_mapping(NULL, gsi);
>> +	if (!irq)
>> +		return irq;
>> +
>> +	/* Set irq type if specified and different than the current one */
>> +	if (irq_type != IRQ_TYPE_NONE &&
>> +		irq_type != irq_get_trigger_type(irq))
>> +		irq_set_irq_type(irq, irq_type);
>> +	return irq;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> I see you've still got this buried in the arch code. Is there any plan to
> move it out, as I moaned about this in the last version of the series and
> nothing seems to have changed?

Ah, sorry. Last time when I was in Hongkong for LCA this Feb, I discussed with Lorenzo
and he had a look into that too, he also met some obstacles to do that, so Lorenzo
said that he will talk to you about this (Lorenzo, correct me if I'm wrong due to hearing
problems of much noise in that room where we were talking).

Anyway, if we move those functions to core code, such as irqdomain code, which will be
compiled for x86 too, we can only set those functions as _weak, or we guard with them
as #ifdef CONFIG_ARM64 ... #endif, so for me, it's really not a big deal to move those code
out of arch/arm64, but I'm still open for suggestions if you can do that in a proper way.

Thanks
Hanjun
