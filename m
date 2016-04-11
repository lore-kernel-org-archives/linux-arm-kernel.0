From: julien.grall@arm.com (Julien Grall)
Date: Mon, 11 Apr 2016 15:03:15 +0100
Subject: [PATCH v5 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <570868EE.9090200@codeaurora.org>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-7-git-send-email-julien.grall@arm.com>
 <570868EE.9090200@codeaurora.org>
Message-ID: <570BAEA3.5090007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/16 03:29, Shanker Donthineni wrote:
> Hi Julien,

Hello Shanker,

> On 04/04/2016 06:37 AM, Julien Grall wrote:
>> +static int __init gic_acpi_parse_virt_madt_gicc(struct
>> acpi_subtable_header *header,
>> +						const unsigned long end)
>> +{
>> +	struct acpi_madt_generic_interrupt *gicc =
>> +		(struct acpi_madt_generic_interrupt *)header;
>> +	int maint_irq_mode;
>> +	static int first_madt = true;
>> +
>> +	maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
>> +		ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +
> Do you think GICC parameters are valid for an unusable processor?

Good point. We don't know if the value will be valid when the processor 
is unusable.

> If not we need a validation check here, some thing like this to skip
> GICC subtable entry.
>
>              if (!(gicc->flags & ACPI_MADT_ENABLED))
>                  return 0;

I will add this check.

Regards,

-- 
Julien Grall
