From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Wed, 23 Mar 2016 08:36:14 -0400
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <56F26FF1.90002@arm.com>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
 <09ca2b70ae43432623cfbac374da1784@codeaurora.org> <56F26FF1.90002@arm.com>
Message-ID: <f33a9ea23bf426c138a9323e53703259@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-23 06:29, Marc Zyngier wrote:
> On 22/03/16 18:33, agustinv at codeaurora.org wrote:
>> On 2016-03-21 06:35, Mark Rutland wrote:
>>> On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
>>>> +/*
>>>> + * In some platforms interrupt resources might not come directly 
>>>> from
>>>> the GIC,
>>>> + * but from separate IRQ circuitry that signals a summary IRQ to 
>>>> the
>>>> GIC and
>>>> + * is handled by a secondary IRQ controller. This is problematic
>>>> under ACPI boot
>>>> + * because the ACPI core does not use the Resource Source field on
>>>> the Extended
>>>> + * Interrupt Descriptor, which in theory could be used to specify 
>>>> an
>>>> alternative
>>>> + * IRQ controller.
>>>> +
>>>> + * For this reason in these platforms we implement the secondary 
>>>> IRQ
>>>> controller
>>>> + * using the gpiolib and specify the IRQs as GpioInt resources, so
>>>> when getting
>>>> + * an IRQ from the device we first try platform_get_irq and if it
>>>> fails we try
>>>> + * devm_gpiod_get_index/gpiod_to_irq.
>>>> + */
>>>> +static
>>>> +int qcom_l3_cache_pmu_get_slice_irq(struct platform_device *pdev,
>>>> +				    struct platform_device *sdev)
>>>> +{
>>>> +	int virq = platform_get_irq(sdev, 0);
>>>> +	struct gpio_desc *desc;
>>>> +
>>>> +	if (virq >= 0)
>>>> +		return virq;
>>>> +
>>>> +	desc = devm_gpiod_get_index(&sdev->dev, NULL, 0, GPIOD_ASIS);
>>>> +	if (IS_ERR(desc))
>>>> +		return -ENOENT;
>>>> +
>>>> +	return gpiod_to_irq(desc);
>>>> +}
>>>> +
>>> 
>>> As Marc Zyngier pointed out in another thread, you should represent
>>> your
>>> interrupt controller as an interrupt controller rather than 
>>> pretending
>>> it is a
>>> GPIO controller.
>>> 
>>> Drivers should be able to remain blissfully unaware what the other 
>>> end
>>> of their
>>> interrupt line is wired up to, and shouldn't have to jump through 
>>> hoops
>>> like
>>> the above.
>>> 
>>> Thanks,
>>> Mark.
>> 
>> Given that this driver is ACPI-only we are leaning toward implementing
>> overflow signalling as ACPI events.
>> This will hide these details from the driver and use standard ACPI 
>> APIs.
>> 
>> Thoughts?
> 
> Please don't do that. The HW (whatever that is, and whatever the
> firmware is) provides you with an interrupt line, not an ACPI event.
> "Hiding the details" is always the wrong thing to do. How do we cope
> with CPU affinity, for example? How do we selectively disable this
> interrupt at the controller level?
> 
> Also, ACPI events will be signalled by (guess what?) an interrupt. So
> what are we actually gaining here?
> 
> I'd *really* advise you to stick to existing abstractions, as they:
> - accurately describe the way the HW works
> - are already supported in the kernel
> 
> The existing shortcomings of the ACPI layer should be addressed pretty
> easily (if the feature is not supported on x86, let's find out why - we
> can make it an arm64 feature if we really have to).
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...

ACPI events *are* existing abstractions within ACPI-based systems and 
the mechanism works across OSes.

If there was a one to one relationship between IRQs and events this 
would be hiding for the sake of hiding.
In this case I am proposing to demultiplex the IRQ in the ACPI layer 
just as a secondary IRQ driver/domain does in DT.

I have reached out to Rafael and Jeremy Pieralisi w.r.t. support of 
multiple IRQ domains via the Resource Source field.

On the other hand we had implemented the IRQ combiner driver as a GPIO 
chip because the hardware is not an interrupt controller, it is an 
"interrupt
combiner", which is very similar to a GPIO controller.

Consider how a GPIO controller works: it sends a summary interrupt when 
a GPIO is toggled, software reads a status register to determine
which pin was toggled.  These combiners do the *exact* same thing except 
it's based on internal chip wires instead of external pins: it
sends a summary interrupt when any wire is toggled and software checks a 
status register to determine which wire was toggled. That's pretty
similar if you ask me.

Given that we need to support other operating systems representing it as 
a GPIO controller was the most OS agnostic way to
implement something like this on ACPI based systems.

Thanks,
Agustin.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project.
