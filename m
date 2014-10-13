From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Oct 2014 13:10:32 +0100
Subject: [PATCH v3 3/7] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <1413196996.23455.9.camel@mtksdaap41>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-4-git-send-email-yingjoe.chen@mediatek.com>
 <5436BF0C.1030508@arm.com> <1413196996.23455.9.camel@mtksdaap41>
Message-ID: <543BC138.3010109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/14 11:43, Joe.C wrote:
> On Thu, 2014-10-09 at 17:59 +0100, Marc Zyngier wrote:
>> On 09/10/14 15:29, Joe.C wrote
>>> @@ -952,7 +988,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>  
>>>  	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
>>>  
>>> -	if (of_property_read_u32(node, "arm,routable-irqs",
>>> +	if (IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) &&
>>> +		of_find_property(node, "arm,irq-domain-hierarchy", NULL))
>>> +		gic->domain = irq_domain_add_linear(node, gic_irqs,
>>> +					&gic_irq_domain_hierarchy_ops, gic);
>>
>> I really think that looking for a property is the wrong thing to do. If
>> "node" is non-NULL, then we're pretty sure that we're initializing from
>> DT, and that a pure linear domain should be the right thing, leaving the
>> legacy stuff for the few non-DT platforms that are still around.
>>
>> Thanks,
>>
>> 	M.
> 
> The only reason I introduce "arm,irq-domain-hierarchy" property is
> trying to keep original behavior when hierarchy irq domain is not used.
> Without this, when a board init GIC with DT, all driver will have to use
> devicetree. I'm not sure we want to break things like this.

I don't think we want to support a "middle of the road" setup, where the
GIC is probed by DT, but some devices have hardcoded interrupts.

> I will remove this and just use linear for all DT in my next version.

I came up with the attached patch, which allows me to boot my test
platform (together with the other fix I posted earlier).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fixup-irqchip-gic-Support-hierarchy-irq-domain.patch
Type: text/x-diff
Size: 3710 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/af3ac3cf/attachment.bin>
