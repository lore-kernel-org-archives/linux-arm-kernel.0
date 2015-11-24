From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 24 Nov 2015 11:08:23 +0800
Subject: [PATCH v3 25/62] acpi/table: Introduce acpi_get_entry to get
 specified entry
In-Reply-To: <5653541E02000078000B8079@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-26-git-send-email-shannon.zhao@linaro.org>
 <5653541E02000078000B8079@prv-mh.provo.novell.com>
Message-ID: <5653D4A7.2090204@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/24 0:59, Jan Beulich wrote:
>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>> --- a/xen/drivers/acpi/tables.c
>> +++ b/xen/drivers/acpi/tables.c
>> @@ -221,6 +221,51 @@ void __init acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>  	}
>>  }
>>  
>> +struct acpi_subtable_header * __init
>> +acpi_get_entry(char *id, unsigned long table_size,
>> +	       struct acpi_table_header *table_header, int entry_id,
>> +	       unsigned int entry_index)
>> +{
>> +	struct acpi_subtable_header *entry;
>> +	unsigned int count = 0;
>> +	unsigned long table_end;
>> +
>> +	if ( !table_size )
> 
> Linux coding style please in this file.
> 
Sure.

>> +		return NULL;
>> +
>> +	if ( !table_header )
>> +	{
>> +		printk("Table header not present\n");
>> +		return NULL;
>> +	}
>> +
>> +	table_end = (unsigned long)table_header + table_header->length;
> 
> So here you use ->length, ...
> 
>> +	/* Parse all entries looking for a match. */
>> +	entry = (struct acpi_subtable_header *)
>> +	    ((unsigned long)table_header + table_size);
> 
> ... but here table_size. Why?
> 
Here it just skips the main table size at the beginning. Then it could
point to the start of sub-table.
For example, to MADT table, the table_size is sizeof(struct
acpi_table_madt).

Thanks,
-- 
Shannon
