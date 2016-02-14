From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 14 Feb 2016 16:06:23 +0800
Subject: [PATCH V3 06/10] irqchip, GICv3, ITS: Refator ITS dt init code to
 prepare for ACPI.
In-Reply-To: <56BB1548.5050402@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-7-git-send-email-tn@semihalf.com> <56BB1548.5050402@arm.com>
Message-ID: <56C0357F.9010904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/2/10 18:47, Marc Zyngier wrote:
> On 19/01/16 13:11, Tomasz Nowicki wrote:
>> Similarly to GICv3 core, we need to extract common code before adding
>> ACPI support. No functional changes.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 82 +++++++++++++++++++++++---------------
>>   drivers/irqchip/irq-gic-v3.c       |  6 +--
>>   include/linux/irqchip/arm-gic-v3.h |  2 +-
>>   3 files changed, 52 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 2bbed18..fecb7a6 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -813,7 +813,7 @@ static void its_free_tables(struct its_node *its)
>>   	}
>>   }
>>
>> -static int its_alloc_tables(const char *node_name, struct its_node *its)
>> +static int its_alloc_tables(struct its_node *its)
>>   {
>>   	int err;
>>   	int i;
>> @@ -868,8 +868,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>   				    order);
>>   			if (order >= MAX_ORDER) {
>>   				order = MAX_ORDER - 1;
>> -				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
>> -					node_name, order);
>> +				pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u\n",
>> +					its->phys_base, order);
>>   			}
>>   		}
>>
>> @@ -878,8 +878,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>   		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>>   			alloc_pages = GITS_BASER_PAGES_MAX;
>>   			order = get_order(GITS_BASER_PAGES_MAX * psz);
>> -			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
>> -				node_name, order, alloc_pages);
>> +			pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u (%u pages)\n",
>> +				its->phys_base, order, alloc_pages);
>>   		}
>>
>>   		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> @@ -948,8 +948,8 @@ retry_baser:
>>   		}
>>
>>   		if (val != tmp) {
>> -			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
>> -			       node_name, i,
>> +			pr_err("ITS at 0x%lx: GITS_BASER%d doesn't stick: %lx %lx\n",
>> +			       its->phys_base, i,
>>   			       (unsigned long) val, (unsigned long) tmp);
>>   			err = -ENXIO;
>>   			goto out_free;
>> @@ -1424,10 +1424,11 @@ static void its_enable_quirks(struct its_node *its)
>>   	gic_enable_quirks(iidr, its_quirks, its);
>>   }
>>
>> -static int __init its_probe(struct device_node *node,
>> -			    struct irq_domain *parent)
>> +static int __init its_probe_one(phys_addr_t phys_base, unsigned long size,
>> +				struct irq_domain *parent,
>> +				bool is_msi_controller,
>
> I really question the fact that you are keeping this msi_controller
> thing. Let's face it: if this is not an MSI controller, then the whole
> thing is absolutely pointless.
>
> So I'd rather you simplify the whole in a separate patch, and just don't
> bother initializing the ITS if it cannot be used for MSIs.

Agree, that will simplify the code a lot.

Thanks
Hanjun
