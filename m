From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Aug 2015 14:41:42 +0100
Subject: [PATCH 4/6] irqchip: GIC: Use chip_data instead of handler_data
 for cascaded interrupts
In-Reply-To: <55C9C42E.8070602@linaro.org>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
 <1436447951-22357-5-git-send-email-marc.zyngier@arm.com>
 <55C9C42E.8070602@linaro.org>
Message-ID: <55CB4D16.9070608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/15 10:45, Eric Auger wrote:
> Hi Marc,
> On 07/09/2015 03:19 PM, Marc Zyngier wrote:
>> When used as a primary interrupt controller, the GIC driver uses
>> irq_data->chip_data to extract controller-specific information.
>>
>> When used as a secondary interrupt controller, it uses handler_data
>> instead. As this difference is relatively pointless and only creates
>> confusion, change the secondary path to match what the rest of the
>> driver does.
> not really related to this series' topic, is it?

It is. Or was. We use the handler_data field to hold the vcpu
information, but that's also used by the chained interrupt handler to
find out which secondary it is.

But this patch is wrong anyway, as it entirely breaks secondary GICs (I
found out when I merged this with a patch from Jon Hunter fixing some
other related stuff). Took me hours to get an EB up and running!

I have a working version now, which makes this patch irrelevant.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
