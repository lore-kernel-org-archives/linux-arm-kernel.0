From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 28 May 2014 16:47:08 +0100
Subject: [RFC v2 01/10] arm: fiq: Allow EOI to be communicated to the intc
In-Reply-To: <20140523150022.GW3693@n2100.arm.linux.org.uk>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
 <20140523150022.GW3693@n2100.arm.linux.org.uk>
Message-ID: <538604FC.8070102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 16:00, Russell King - ARM Linux wrote:
> On Fri, May 23, 2014 at 02:57:49PM +0100, Daniel Thompson wrote:
>> +void eoi_fiq(int fiq)
>> +{
>> +	struct irq_data *irq_data = irq_get_irq_data(fiq + fiq_start);
>> +	struct irq_chip *chip = irq_data_get_irq_chip(irq_data);
>> +
>> +	if (chip->irq_eoi)
>> +			chip->irq_eoi(irq_data);
>> +}
> 
> So what if the IRQ chip takes a spinlock?  You can't take spinlocks in
> FIQ context...  Who checks for that kind of stuff - just hoping that
> the IRQ driver doesn't take a spinlock sounds real fragile.

I'll certainly do a better code review before pushing on. I certainly
did overlook a spinlock in the GIC code which (I think) is actually
reachable on a Tegra platform. I'll have to do something about that.

I've spent a bit of time this week seeing whether lock dep can be
provoked into triggering if it sees a spin lock in this code but that
isn't turning out very well (it needs CONFIG_LOCKDEP_DEBUG, relies on
lockdep believing the FIQ handling state isn't a hardirq and still
doesn't work properly).

Fortunately architectures using EOI appear to be pretty rare (I count
five in drivers/irqchip/ and three in arch/arm/) so traditional code
review and yelling might be sufficient.


Daniel.
