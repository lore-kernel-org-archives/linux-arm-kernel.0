From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Sep 2018 11:39:03 +0100
Subject: [PATCH 04/10] irqchip/gic-v3-its: Move pending table allocation
 to init time
In-Reply-To: <7cdac0d7-a256-5e75-5a19-8eb0fb1cf6a5@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-5-marc.zyngier@arm.com>
 <7cdac0d7-a256-5e75-5a19-8eb0fb1cf6a5@arm.com>
Message-ID: <637c7af3-cce7-4e0b-e049-366ea4b17e25@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 24/09/18 12:58, Julien Thierry wrote:
> Hi Marc,
> 
> On 21/09/18 20:59, Marc Zyngier wrote:
>> Pending tables for the redistributors are currently allocated
>> one at a time as each CPU boots. This is causing some grief
>> for Linux/RT (allocation from within a CPU hotplug notifier is
>> frown upon).
>>
>> Let's more this allocation to take place at init time, when we
>> only have a single CPU. It means we're allocating memory for CPUs
>> that are not online yet, but most system will boot all of their
>> CPUs anyway, so that's not completely wasted.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>    drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++-----------
>>    include/linux/irqchip/arm-gic-v3.h |  1 +
>>    2 files changed, 53 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 7ef6baea2d78..462bba422189 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -173,6 +173,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
>>    static DEFINE_IDA(its_vpeid_ida);
>>    
>>    #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
>> +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
>>    #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>>    #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>>    
>> @@ -1625,7 +1626,7 @@ static void its_free_prop_table(struct page *prop_page)
>>    		   get_order(LPI_PROPBASE_SZ));
>>    }
>>    
>> -static int __init its_alloc_lpi_tables(void)
>> +static int __init its_alloc_lpi_prop_table(void)
> 
> A bit of a nit, but there is already a function called
> "its_allocate_prop_table" which I find very easy to confuse with this one.
> 
> And patch 3 factored the initialization out of its_allocate_prop_table.
> So I was wondering whether it would not actually be better to open-code
> it here and get rid of that function. Otherwise I'd suggest having more
> distinct names.

its_allocate_prop_table is also used by the VLPI code to allocate guest 
property tables, so I'd rather not open-code it.

How about renaming this function to its_setup_lpi_prop_table?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
