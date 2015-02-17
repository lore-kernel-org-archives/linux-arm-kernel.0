From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Tue, 17 Feb 2015 18:00:52 +0800
Subject: [PATCH v2 3/6] irqchip: gicv3-its: limit order of DT size to
 MAX_ORDER
In-Reply-To: <20150217091945.1c47e92f@arm.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
 <1423992723-5028-4-git-send-email-wuyun.wu@huawei.com>
 <20150217091945.1c47e92f@arm.com>
Message-ID: <54E31154.3020308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/17 17:19, Marc Zyngier wrote:

> On Sun, 15 Feb 2015 09:32:00 +0000
> Yun Wu <wuyun.wu@huawei.com> wrote:
> 
>> When required DT size is out of the kmalloc()'s capability, the whole
> 
> Nit: Using the DT acronym is very confusing here, as it means "Device
> Tree" to most people, including me. Please use "Device Table" instead.
> 
> Also, the reference to kmalloc is wrong, as we're really using the page
> allocator.

OK, I will get the description fixed in the next version.

> 
>> ITS will fail in probing. This actually is not the hardware's problem
>> and is mainly a limitation of the kernel memory allocator. This patch
>> will keep ITS going on to the next initializaion step with an explicit
>> warning.
>>
>> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>> b/drivers/irqchip/irq-gic-v3-its.c index f5bfa42..de36606 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -828,6 +828,12 @@ static int its_alloc_tables(struct its_node *its)
>>  			u32 ids = GITS_TYPER_DEVBITS(typer);
>>
>>  			order = get_order((1UL << ids) * entry_size);
>> +			if (order >= MAX_ORDER) {
>> +				pr_warn("%s: DT size too large,
>> reduce to %u pages\n",
>> +
>> its->msi_chip.of_node->full_name,
>> +					1 << order);
>> +				order = MAX_ORDER;
>> +			}
>>  		}
> 
> Something is wrong here. Either (order == MAX_ORDER) is acceptable, or
> it is not. Also, your warning says that you're reducing the size to a
> new value, but you're displaying the size you can't handle. That
> message should be fixed.
> 

Yes, my fault, I will fix them.

Thanks,
	Abel
