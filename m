From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 11:27:34 +0000
Subject: [PATCH v10 3/4] irqchip:create irq domain for each mbigen device
In-Reply-To: <20151218110253.GC29219@leverpostej>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <1450353397-47668-4-git-send-email-majun258@huawei.com>
 <20151218110253.GC29219@leverpostej>
Message-ID: <5673EDA6.5090902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 11:02, Mark Rutland wrote:
> On Thu, Dec 17, 2015 at 07:56:36PM +0800, MaJun wrote:
>> From: Ma Jun <majun258@huawei.com>
>>
>> For peripheral devices which connect to mbigen,mbigen is a interrupt
>> controller. So, we create irq domain for each mbigen device and add
>> mbigen irq domain into irq hierarchy structure.
>>
>> Signed-off-by: Ma Jun <majun258@huawei.com>
>> ---
>>  drivers/irqchip/irq-mbigen.c |  138 ++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 138 insertions(+), 0 deletions(-)
> 
> [...]
> 
>> +static int mbigen_domain_translate(struct irq_domain *d,
>> +				    struct irq_fwspec *fwspec,
>> +				    unsigned long *hwirq,
>> +				    unsigned int *type)
>> +{
>> +	if (is_of_node(fwspec->fwnode)) {
>> +		if (fwspec->param_count != 2)
>> +			return -EINVAL;
>> +
>> +		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
>> +			(fwspec->param[0] < RESERVED_IRQ_PER_MBIGEN_CHIP))
>> +			return -EINVAL;
>> +		else
>> +			*hwirq = fwspec->param[0];
>> +
>> +		/* If there is no valid irq type, just use the default type */
>> +		if ((fwspec->param[1] == IRQ_TYPE_EDGE_RISING) ||
>> +			(fwspec->param[1] == IRQ_TYPE_LEVEL_HIGH))
>> +			*type = fwspec->param[1];
>> +		else
>> +			*type = IRQ_TYPE_NONE;
> 
> That does not seem like a good idea. The binding requires one of two
> types, and the DT is clearly wrong in the else case. 
> 
> I think for the else case we should return -EINVAL.

Ah, nicely spotted. I'll fix that in my tree too.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
