From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Tue, 22 Mar 2016 14:33:58 -0400
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20160321103507.GB17326@leverpostej>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
Message-ID: <09ca2b70ae43432623cfbac374da1784@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-21 06:35, Mark Rutland wrote:
> On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
>> +/*
>> + * In some platforms interrupt resources might not come directly from 
>> the GIC,
>> + * but from separate IRQ circuitry that signals a summary IRQ to the 
>> GIC and
>> + * is handled by a secondary IRQ controller. This is problematic 
>> under ACPI boot
>> + * because the ACPI core does not use the Resource Source field on 
>> the Extended
>> + * Interrupt Descriptor, which in theory could be used to specify an 
>> alternative
>> + * IRQ controller.
>> +
>> + * For this reason in these platforms we implement the secondary IRQ 
>> controller
>> + * using the gpiolib and specify the IRQs as GpioInt resources, so 
>> when getting
>> + * an IRQ from the device we first try platform_get_irq and if it 
>> fails we try
>> + * devm_gpiod_get_index/gpiod_to_irq.
>> + */
>> +static
>> +int qcom_l3_cache_pmu_get_slice_irq(struct platform_device *pdev,
>> +				    struct platform_device *sdev)
>> +{
>> +	int virq = platform_get_irq(sdev, 0);
>> +	struct gpio_desc *desc;
>> +
>> +	if (virq >= 0)
>> +		return virq;
>> +
>> +	desc = devm_gpiod_get_index(&sdev->dev, NULL, 0, GPIOD_ASIS);
>> +	if (IS_ERR(desc))
>> +		return -ENOENT;
>> +
>> +	return gpiod_to_irq(desc);
>> +}
>> +
> 
> As Marc Zyngier pointed out in another thread, you should represent 
> your
> interrupt controller as an interrupt controller rather than pretending 
> it is a
> GPIO controller.
> 
> Drivers should be able to remain blissfully unaware what the other end 
> of their
> interrupt line is wired up to, and shouldn't have to jump through hoops 
> like
> the above.
> 
> Thanks,
> Mark.

Given that this driver is ACPI-only we are leaning toward implementing 
overflow signalling as ACPI events.
This will hide these details from the driver and use standard ACPI APIs.

Thoughts?

Thanks,
Agustin
