From: julien.grall@arm.com (Julien Grall)
Date: Tue, 22 Mar 2016 12:02:29 +0000
Subject: [PATCH v3 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <20160322112728.GA2486@xora-haswell.xora.org.uk>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-7-git-send-email-julien.grall@arm.com>
 <20160322112728.GA2486@xora-haswell.xora.org.uk>
Message-ID: <56F13455.2000703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Graeme,

On 22/03/16 11:27, Graeme Gregory wrote:
> On Tue, Mar 08, 2016 at 11:29:30AM +0000, Julien Grall wrote:
>> @@ -1020,6 +1060,13 @@ gic_acpi_parse_madt_gicc(struct acpi_subtable_header *header,
>>   		return -ENOMEM;
>>
>>   	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>> +
>> +	acpi_data.maint_irq = gicc->vgic_interrupt;
>> +	acpi_data.maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
>> +				    ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +	acpi_data.vctrl_base = gicc->gich_base_address;
>> +	acpi_data.vcpu_base = gicc->gicv_base_address;
>> +
>>   	return 0;
>>   }
>
> Placing this here means that it will not collect the info in the case
> where there is a Generic Interrupt Redistributor structure in the MADT.
>
> I guess collecting this info should not be a side effect of happening to
> pass GICC for redistributor base. Which unfortuneately probably means we
> do need to parse the GICCs specifically for this information.

I noticed it while testing on some platform. It's now fixed and will be 
in the next version.

Regards,

-- 
Julien Grall
