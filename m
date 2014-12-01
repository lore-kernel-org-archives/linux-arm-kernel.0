From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Dec 2014 11:31:05 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <20141201112302.GC3836@n2100.arm.linux.org.uk>
References: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
 <20141201104145.GY3836@n2100.arm.linux.org.uk>
 <20141201104612.GM828@e106497-lin.cambridge.arm.com>
 <20141201110358.GA3836@n2100.arm.linux.org.uk> <547C4ECD.20802@arm.com>
 <20141201112302.GC3836@n2100.arm.linux.org.uk>
Message-ID: <547C5179.5020505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/14 11:23, Russell King - ARM Linux wrote:
> On Mon, Dec 01, 2014 at 11:19:41AM +0000, Marc Zyngier wrote:
>> Hi Russell,
>>
>> On 01/12/14 11:03, Russell King - ARM Linux wrote:
>>> If all you want to do is to bypass the following check, what's wrong
>>> with actually doing that:
>>>
>>> -	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>>> +	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
>>> +	    type != IRQ_TYPE_EDGE_RISING)
>>> 		return -EINVAL;
>>>
>>
>> I think that will require some additional changes to gic_configure_irq
>> (in irq-gic-common.c).
> 
> I don't think so - gic_configure_irq() will treat it as a no-op as far
> as trying to configure the IRQ settings.

I agree. But that's following ARM's tradition of making PPIs
non-configurable. I seem to remember that there is at least one
occurrence of a GIC with configurable PPIs (Qualcomm, IIRC).

With this use case in mind, Liviu's patch allows an active-low interrupt
to be correctly configured as level, for example.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
