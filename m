From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 20:44:30 -0500
Subject: [PATCH 3/4] arm64: pmu: Add support for probing with ACPI
In-Reply-To: <56E5F7A6.3030905@codeaurora.org>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
 <1457911398-22412-4-git-send-email-jeremy.linton@arm.com>
 <56E5F7A6.3030905@codeaurora.org>
Message-ID: <56E6177E.6020702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2016 06:28 PM, Timur Tabi wrote:
> Jeremy Linton wrote:
>> +    int i, count, irq;
>> +
>> +    if (acpi_disabled)
>> +        return 0;
>> +
>> +    acpi_parse_boot_cpu();
>> +
>> +    /* Must have irq for boot boot cpu, at least */
>> +    if (pirq->gsi == 0)
>> +        return -EINVAL;
>> +
>> +    irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
>> +                ACPI_ACTIVE_HIGH);
>> +
>> +    if (irq_is_percpu(irq))
>> +        count = 1;
>> +    else
>> +        for (i = 1, count = 1; i < NR_CPUS; i++)
>> +            if (pmu_irqs[i].gsi)
>> +                ++count;
>
> You could more simply with:
>
>      int count = 1
>      ...
>      if (!irq_is_percpu(irq))
>          for (i = 1; i < NR_CPUS; i++)
>              if (pmu_irqs[i].gsi)
>                  ++count;

I think you will notice that the following patch rewrites a lot of this 
function.

I kept the original patches from Mark to identify/segment his 
contribution because they run/bisect by themselves. They should probably 
be squashed together for review purposes.
