From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 07 Aug 2014 18:28:31 +0800
Subject: [PATCH v2 07/18] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802650766@SHSMSX101.ccr.corp.intel.com>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-8-git-send-email-hanjun.guo@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E8802650766@SHSMSX101.ccr.corp.intel.com>
Message-ID: <53E354CF.1070800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-7 9:41, Zheng, Lv wrote:
> Hi,

Hi Lv,

> 
>> From: Hanjun Guo [mailto:hanjun.guo at linaro.org]
>> Sent: Monday, August 04, 2014 11:28 PM
>> To: Catalin Marinas; Rafael J. Wysocki; Mark Rutland
>>
>> When MADT is parsed, print GIC information to make the boot
>> log look pretty.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>  drivers/acpi/tables.c |   39 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 6d5a6cd..77f8bb1 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -183,6 +183,44 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>  		}
>>  		break;
>>
>> +	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
>> +		{
>> +			struct acpi_madt_generic_interrupt *p =
>> +				(struct acpi_madt_generic_interrupt *)header;
>> +			pr_info("GICC (acpi_id[0x%04x] address[0x%08llx] MPDIR[0x%llx] %s)\n",
>> +				p->uid, p->base_address, p->arm_mpidr,
> 
> Just reminders.
> The acpi_id looks vague, is it a UID for the processor?

Yes, it is the UID of processor object in DSDT, How about use
acpi_uid instead?

> Should 0x%08llx for base_address be %p?

Yes, %p should be better, I will update the code and all the
address field you pointed out below.

> 
>> +				(p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>> +
>> +		}
>> +		break;
>> +
>> +	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
>> +		{
>> +			struct acpi_madt_generic_distributor *p =
>> +				(struct acpi_madt_generic_distributor *)header;
>> +			pr_info("GIC Distributor (gic_id[0x%04x] address[0x%08llx] gsi_base[%d])\n",
>> +				p->gic_id, p->base_address, p->global_irq_base);
>> +		}
>> +		break;
> 
> Same question for base_address.
> 
>> +
>> +	case ACPI_MADT_TYPE_GENERIC_MSI_FRAME:
>> +		{
>> +			struct acpi_madt_generic_msi_frame *p =
>> +				(struct acpi_madt_generic_msi_frame *)header;
>> +			pr_info("GIC MSI Frame (msi_fame_id[%d] address[0x%08llx])\n",
>> +				p->msi_frame_id, p->base_address);
> 
> Ditto.
> 
>> +		}
>> +		break;
>> +
>> +	case ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR:
>> +		{
>> +			struct acpi_madt_generic_redistributor *p =
>> +				(struct acpi_madt_generic_redistributor *)header;
>> +			pr_info("GIC Redistributor (address[0x%08llx] region_size[0x%x])\n",
>> +				p->base_address, p->length);
> 
> Ditto.
> 
>> +		}
>> +		break;
>> +
>>  	default:
>>  		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>>  			header->type);
>> @@ -190,7 +228,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>  	}
>>  }
>>
>> -
>>  int __init
>>  acpi_table_parse_entries(char *id,
>>  			     unsigned long table_size,
> 
> This block shouldn't be a part of this patch.

Ok, I will remove that from this patch.

Thanks
Hanjun
