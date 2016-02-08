From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 14:29:12 +0000
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <20160208141754.GG4117@kwain>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <alpine.DEB.2.11.1602081125560.25254@nanos> <20160208141754.GG4117@kwain>
Message-ID: <56B8A638.1040903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 14:17, Antoine Tenart wrote:
> Thomas,
> 
> On Mon, Feb 08, 2016 at 11:31:47AM +0100, Thomas Gleixner wrote:
>> On Mon, 8 Feb 2016, Antoine Tenart wrote:
>>> +static int alpine_msix_set_affinity(struct irq_data *irq_data,
>>> +				    const struct cpumask *mask, bool force)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = irq_chip_set_affinity_parent(irq_data, mask, force);
>>> +	return ret == IRQ_SET_MASK_OK ? IRQ_SET_MASK_OK_DONE : ret;
>>
>> What's the point of this exercise? Why can't you just set the affinity
>> callback to irq_chip_set_affinity_parent() ?
> 
> That's what done in irq-gic-v2m.c. Besides that, I see no point. I'll
> update for v2.

That's because there is no need to do another compose_msi_msg/write_msg
in msi_domain_set_affinity() once the affinity has been updated at the
GIC level. Alternatively, updating the GIC driver to always return
IRQ_SET_MASK_OK_DONE would be perfectly acceptable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
