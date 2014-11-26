From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 26 Nov 2014 09:42:08 +0800
Subject: [PATCH v5 02/18] ACPI / table: Add new function to get table
 entries
In-Reply-To: <1591450.lUZUanAOs6@vostro.rjw.lan>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1581499.U8906vqSiO@vostro.rjw.lan> <5473F99D.6090505@huawei.com>
 <1591450.lUZUanAOs6@vostro.rjw.lan>
Message-ID: <54752FF0.7080602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/26 5:20, Rafael J. Wysocki wrote:
> On Tuesday, November 25, 2014 11:38:05 AM Hanjun Guo wrote:
>> On 2014/11/24 22:51, Rafael J. Wysocki wrote:
>>> On Monday, November 24, 2014 07:03:54 PM Hanjun Guo wrote:
>>>> On 2014-11-24 9:27, Rafael J. Wysocki wrote:
>>>>> On Friday, October 17, 2014 09:36:58 PM Hanjun Guo wrote:
>>>>>> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>>>
>>>>>> The acpi_table_parse() function has a callback that
>>>>>> passes a pointer to a table_header. Add a new function
>>>>>> which takes this pointer and parses its entries. This
>>>>>> eliminates the need to re-traverse all the tables for
>>>>>> each call. e.g. as in acpi_table_parse_madt() which is
>>>>>> normally called after acpi_table_parse().
>>>>>>
>>>>>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>>>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>>>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>> ---
>>>>>>  drivers/acpi/tables.c |   67 ++++++++++++++++++++++++++++++++++---------------
>>>>>>  include/linux/acpi.h  |    4 +++
>>>>>>  2 files changed, 51 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>>>>>> index 6d5a6cd..21ae521 100644
>>>>>> --- a/drivers/acpi/tables.c
>>>>>> +++ b/drivers/acpi/tables.c
>>>>>> @@ -192,17 +192,14 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>>>>>  
>>>>>>  
>>>>>>  int __init
>>>>>> -acpi_table_parse_entries(char *id,
>>>>>> -			     unsigned long table_size,
>>>>>> -			     int entry_id,
>>>>>> -			     acpi_tbl_entry_handler handler,
>>>>>> -			     unsigned int max_entries)
>>>>>> +acpi_parse_entries(unsigned long table_size,
>>>>>> +		acpi_tbl_entry_handler handler,
>>>>>> +		struct acpi_table_header *table_header,
>>>>>> +		int entry_id, unsigned int max_entries)
>>>>>>  {
>>>>>> -	struct acpi_table_header *table_header = NULL;
>>>>>>  	struct acpi_subtable_header *entry;
>>>>>> -	unsigned int count = 0;
>>>>>> +	int count = 0;
>>>>>>  	unsigned long table_end;
>>>>>> -	acpi_size tbl_size;
>>>>>>  
>>>>>>  	if (acpi_disabled)
>>>>>>  		return -ENODEV;
>>>>>> @@ -210,13 +207,11 @@ acpi_table_parse_entries(char *id,
>>>>>>  	if (!handler)
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>> -	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
>>>>>> -		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
>>>>>> -	else
>>>>>> -		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
>>>>>> +	if (!table_size)
>>>>>> +		return -EINVAL;
>>>>>>  
>>>>>>  	if (!table_header) {
>>>>>> -		pr_warn("%4.4s not present\n", id);
>>>>>> +		pr_warn("Table header not present\n");
>>>>> The message doesn't make sense any more if the table signature is not printed.
>> For this message, since no table id is passed, and this message is printed in
>> acpi_table_parse_entries() before this function is called, I think we can check
>> the table_header before call this function and remove the printed message here.
> table_header needs to be checked against NULL in the caller and the message
> printed from there to my eyes.

ok, I think table id should pass to this function, I will rework this patch
and resend.

Thanks
Hanjun
