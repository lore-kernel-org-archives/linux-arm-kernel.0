From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 24 Nov 2014 16:01:24 +0100
Subject: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
In-Reply-To: <2301926.MWJ5MneAen@vostro.rjw.lan>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <6619034.gHDuQJ1A7y@vostro.rjw.lan> <5472ED90.5010803@linaro.org>
 <2301926.MWJ5MneAen@vostro.rjw.lan>
Message-ID: <54734844.1070505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.11.2014 16:16, Rafael J. Wysocki wrote:
> On Monday, November 24, 2014 09:34:24 AM Tomasz Nowicki wrote:
>> On 24.11.2014 02:45, Rafael J. Wysocki wrote:
>>> On Friday, October 17, 2014 09:36:59 PM Hanjun Guo wrote:
>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>
>>>> It is very useful to traverse all available table entries without max
>>>> number of expected entries type. Current acpi_parse_entries()
>>>> implementation gives that feature but it does not count those entries,
>>>> it returns 0 instead, so fix it to count matched and successfully
>>>> entries and return it.
>>>
>>> Hmm.  I guess that the goal is for count to only be incremented when the
>>> condition is satisfied entirely, while without the patch it may be incremented
>>> even if that isn't the case.
>>
>> That would be our goal if patch would look like:
>> -		    && (!max_entries || count++ < max_entries))
>> +		    && (!max_entries && count++ < max_entries)) {
>> but then we can not walk through all available entries (with max_entries==0)
>
> No, that's not what I was trying to say. :-)
>
>>>
>>> I'm not sure how that is related to the above paragraph, however.
>>>
>>
>> Previous changelog is not clear, let me rewrite it:
>>
>> acpi_parse_entries() allows to traverse all available table entries (aka
>> subtables) by passing max_entries parameter equal to 0. But for that use
>> case acpi_parse_entries() does not inform caller how many entries were
>> matched and for how many entries handler was run against. That patch is
>> going to fix it.
>
> Do I understand correctly that count is only ever incremented by current code
> if max_entries is different from 0?

Right. Currently "count" is incremented only if max_entries > 0.

Tomasz

>
>
>>>> NOTE: This change has no impact to x86 and ia64 archs since existing code
>>>> checks for error occurrence only (acpi_parse_entries(...,0) < 0).
>>>>
>>>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>    drivers/acpi/tables.c |    5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>>>> index 21ae521..b18e45e 100644
>>>> --- a/drivers/acpi/tables.c
>>>> +++ b/drivers/acpi/tables.c
>>>> @@ -225,10 +225,13 @@ acpi_parse_entries(unsigned long table_size,
>>>>    	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>>>>    	       table_end) {
>>>>    		if (entry->type == entry_id
>>>> -		    && (!max_entries || count++ < max_entries))
>>>> +		    && (!max_entries || count < max_entries)) {
>>>>    			if (handler(entry, table_end))
>>>>    				return -EINVAL;
>>>>
>>>> +			count++;
>>>> +		}
>>>> +
>>>>    		/*
>>>>    		 * If entry->length is 0, break from this loop to avoid
>>>>    		 * infinite loop.
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
