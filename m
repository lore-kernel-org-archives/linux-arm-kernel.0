From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 24 Nov 2015 01:04:32 -0700
Subject: [PATCH v3 25/62] acpi/table: Introduce acpi_get_entry to
 get specified entry
In-Reply-To: <56541668.9090201@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-26-git-send-email-shannon.zhao@linaro.org>
 <5653541E02000078000B8079@prv-mh.provo.novell.com>
 <5653D4A7.2090204@huawei.com>
 <56541E4002000078000B8304@prv-mh.provo.novell.com>
 <56541668.9090201@huawei.com>
Message-ID: <5654282002000078000B8396@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 24.11.15 at 08:48, <zhaoshenglong@huawei.com> wrote:
> On 2015/11/24 15:22, Jan Beulich wrote:
>>>>> On 24.11.15 at 04:08, <zhaoshenglong@huawei.com> wrote:
>>> On 2015/11/24 0:59, Jan Beulich wrote:
>>>>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>>>>> +	if ( !table_header )
>>>>> +	{
>>>>> +		printk("Table header not present\n");
>>>>> +		return NULL;
>>>>> +	}
>>>>> +
>>>>> +	table_end = (unsigned long)table_header + table_header->length;
>>>>
>>>> So here you use ->length, ...
>>>>
>>>>> +	/* Parse all entries looking for a match. */
>>>>> +	entry = (struct acpi_subtable_header *)
>>>>> +	    ((unsigned long)table_header + table_size);
>>>>
>>>> ... but here table_size. Why?
>>>>
>>> Here it just skips the main table size at the beginning. Then it could
>>> point to the start of sub-table.
>>> For example, to MADT table, the table_size is sizeof(struct
>>> acpi_table_madt).
>> 
>> Well, but for one then the parameter name is kind of wrong, and
>> second - is it really reasonable for the caller to tell the function?
>>  
> I think the caller knows which table it wants to parse and could
> calculate the size. But within this function, there is no clue to get
> the main table size.

Well, yes and no: acpi_table_parse_entries() also gets table_size
passed in, but all its callers live under xen/drivers/acpi/. Hence it's
basically an internal ACPI interface with its declaration misplaced.
Thus the question is where the callers of the new interface you add
will end up living. If this is going to be a similarly internal interface,
then I'm fine. If you mean to add callers under xen/arch/arm/, then
I'm afraid I'm going to NAK this patch.

(And yes, I'd welcome a patch to introduce an internal header under
xen/drivers/acpi/ to hold declarations and definitions which aren't
supposed to be used outside that sub-tree.)

Jan
