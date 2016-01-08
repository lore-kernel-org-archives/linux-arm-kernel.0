From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 08 Jan 2016 09:07:50 +0000
Subject: [PATCH v3 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <alpine.DEB.2.11.1601080942270.3575@nanos>
References: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
 <1452162428-26839-2-git-send-email-qnguyen@apm.com>
 <alpine.DEB.2.11.1601080942270.3575@nanos>
Message-ID: <568F7C66.2050000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/16 08:45, Thomas Gleixner wrote:
> On Thu, 7 Jan 2016, Quan Nguyen wrote:
>> -static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
>> +static void xgene_gpio_sb_irq_ack(struct irq_data *d)
>> +{
>> +	struct irq_data *irqdata;
>> +	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
>> +
>> +	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
>> +	if (!irqdata || !irqdata->chip)
>> +		return;
> 
> What the heck is this? Why are you looking up some random other irq and fiddle
> with its irq chip?
> 
> This is a 1:1 mapping from your gpio irq to a gic irq. We have hierarchical
> interrupt domains for this.

I've said the exact same thing back in October:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381996.html

but obviously I wasn't clear enough...

	M.
-- 
Jazz is not dead. It just smells funny...
