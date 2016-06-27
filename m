From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Jun 2016 10:50:39 +0100
Subject: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <576DA047.7080808@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-5-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon> <576DA047.7080808@linaro.org>
Message-ID: <5770F6EF.3080902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Daniel,

On 24/06/16 22:04, Daniel Lezcano wrote:

[...]

>>> +
>>> +    psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
>>> +    if (!psci_states)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < count; i++) {
>>> +        u32 state;
>>> +
>>> +        lpi = &pr->power.lpi_states[i + 1];
>>> +        state = lpi->address & 0xFFFFFFFF;
>
> Why is needed to mask 'address' ?
>

This is as per Section 3.1.1 FFH Usage in LPI state entry methods in [1]

[...]

>>>   int psci_cpu_init_idle(unsigned int cpu)
>>>   {
>>>       struct device_node *cpu_node;
>>>       int ret;
>>>
>>> +    if (!acpi_disabled)
>>> +        return psci_acpi_cpu_init_idle(cpu);
>
> Is it possible the case where there is information in both the DT and in
> ACPI ? So ACPI is enabled without idle information which is in the DT ?
>

No, as Rafael mentioned aready.

>>
>> Either you do this, or we have to add it somehow somewhere in
>> drivers/cpuidle to avoid duplicating it.
>>
>> @Daniel: do you have an opinion on this please ?
>
> Yes, this function should be added to avoid duplication.
>

So, I assume you are happy with the way it's handled in this patch ?
(I will rename the file as suggested by Lorenzo)

-- 
Regards,
Sudeep

[1] 
http://infocenter.arm.com/help/topic/com.arm.doc.den0048a/DEN0048A_ARM_FFH_Specification.pdf
