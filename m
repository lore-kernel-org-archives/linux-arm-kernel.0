From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 26 Nov 2014 15:48:47 +0000
Subject: [PATCH 3.18-rc3 v9 3/5] irqchip: gic: Introduce plumbing for
 IPI FIQ
In-Reply-To: <1678979.dHizJmHVtD@dabox>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-1-git-send-email-daniel.thompson@linaro.org>
 <1416936401-5147-4-git-send-email-daniel.thompson@linaro.org>
 <1678979.dHizJmHVtD@dabox>
Message-ID: <5475F65F.4030905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/14 15:09, Tim Sander wrote:
> I would be quite happy if grouping support for gic would be mainlined.
> Then only the dance to get the old gic version 1 working with fiqs would be 
> needed...

You mention "the dance"...

Are you familiar with this work from Marek Vasut?
  https://lkml.org/lkml/2014/7/15/550

Marek blushed a bit when it was written and it wasn't very popular in
code review... however it does arranges memory to mapped in a manner
that allows FIQ to be deployed by the kernel on early gic v1 devices.


>> +/*
>> + * Shift an interrupt between Group 0 and Group 1.
>> + *
>> + * In addition to changing the group we also modify the priority to
>> + * match what "ARM strongly recommends" for a system where no Group 1
>> + * interrupt must ever preempt a Group 0 interrupt.
>> + *
>> + * If is safe to call this function on systems which do not support
>> + * grouping (it will have no effect).
>> + */
>> +static void gic_set_group_irq(void __iomem *base, unsigned int hwirq,
>> +				int group)
>> +{
>> +	unsigned int grp_reg = hwirq / 32 * 4;
>> +	u32 grp_mask = BIT(hwirq % 32);
>> +	u32 grp_val;
>> +
>> +	unsigned int pri_reg = (hwirq / 4) * 4;
>> +	u32 pri_mask = BIT(7 + ((hwirq % 4) * 8));
>> +	u32 pri_val;
>> +
>> +	/*
>> +	 * Systems which do not support grouping will have not have
>> +	 * the EnableGrp1 bit set.
>> +	 */
>> +	if (!(GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL)))
>> +		return;
>> +
>> +	raw_spin_lock(&irq_controller_lock);
>> +
> Assumption: The interrupt in question is not masked over here?

At present this function is called only during initialization and all
interrupts are globally disabled at that stage in the boot.


>> +	grp_val = readl_relaxed(base + GIC_DIST_IGROUP + grp_reg);
>> +	pri_val = readl_relaxed(base + GIC_DIST_PRI + pri_reg);
>> +
>> +	if (group) {
>> +		grp_val |= grp_mask;
>> +		pri_val |= pri_mask;
>> +	} else {
>> +		grp_val &= ~grp_mask;
>> +		pri_val &= ~pri_mask;
>> +	}
>> +
>> +	writel_relaxed(grp_val, base + GIC_DIST_IGROUP + grp_reg);
> If the assumption is true, then there is a race if the interrupt in question 
> hits here with undefined priority setting. Recomended workaround would be
> masking the interrupt in question.

An interesting question!

Firstly, as mentioned above, such a race is impossible with the code
proposed so far.

I do have some code sitting written by untested that makes it possible
to set the group based on a flag passed during request_irq() (something
requested by tglx in a review from a month or two back). That also means
the interrupt is disabled during the call.

I think that means that neither now nor in the immediate future would
such a race be possible.


Daniel.
