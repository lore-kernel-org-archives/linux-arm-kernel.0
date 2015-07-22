From: eric@anholt.net (Eric Anholt)
Date: Wed, 22 Jul 2015 11:02:44 -0700
Subject: [PATCH v2 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <55AEFB57.6030902@wwwdotorg.org>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
 <1436837718-956-5-git-send-email-eric@anholt.net>
 <55AEFB57.6030902@wwwdotorg.org>
Message-ID: <87egk0gjej.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 07/13/2015 07:35 PM, Eric Anholt wrote:
>> This interrupt controller is the new root interrupt controller with
>> the timer, PMU events, and IPIs, and the bcm2835's interrupt
>> controller is chained off of it to handle the peripherals.
>
>> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
>
>> +static void bcm2836_arm_irqchip_mask_pmu_irq(struct irq_data *d)
>> +{
>> +	pr_err("%d: mask PMU\n", smp_processor_id());
>> +	writel(1 << smp_processor_id(), intc.base + LOCAL_PM_ROUTING_CLR);
>> +}
>> +
>> +static void bcm2836_arm_irqchip_unmask_pmu_irq(struct irq_data *d)
>> +{
>> +	pr_err("%d: unmask PMU\n", smp_processor_id());
>> +	writel(1 << smp_processor_id(), intc.base + LOCAL_PM_ROUTING_SET);
>> +}
>
> Are those pr_err() calls left-over debug, or is there some reason it's
> an error to call those functions?

Yeah, I was trying to figure out whether the PMU bits worked.  We're
failing before the point of IRQ probe, though (I don't see anything that
would set arm_pmu->supported_cpus for us).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150722/77c9390a/attachment.sig>
