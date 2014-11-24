From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 24 Nov 2014 16:18:15 +0100
Subject: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
In-Reply-To: <1943415.qgIc2QypIM@vostro.rjw.lan>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <2301926.MWJ5MneAen@vostro.rjw.lan> <54734844.1070505@linaro.org>
 <1943415.qgIc2QypIM@vostro.rjw.lan>
Message-ID: <54734C37.1060208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.11.2014 16:37, Rafael J. Wysocki wrote:
> On Monday, November 24, 2014 04:01:24 PM Tomasz Nowicki wrote:
>> On 24.11.2014 16:16, Rafael J. Wysocki wrote:
>>> On Monday, November 24, 2014 09:34:24 AM Tomasz Nowicki wrote:
>>>> On 24.11.2014 02:45, Rafael J. Wysocki wrote:
>>>>> On Friday, October 17, 2014 09:36:59 PM Hanjun Guo wrote:
>>>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>>>
>>>>>> It is very useful to traverse all available table entries without max
>>>>>> number of expected entries type. Current acpi_parse_entries()
>>>>>> implementation gives that feature but it does not count those entries,
>>>>>> it returns 0 instead, so fix it to count matched and successfully
>>>>>> entries and return it.
>>>>>
>>>>> Hmm.  I guess that the goal is for count to only be incremented when the
>>>>> condition is satisfied entirely, while without the patch it may be incremented
>>>>> even if that isn't the case.
>>>>
>>>> That would be our goal if patch would look like:
>>>> -		    && (!max_entries || count++ < max_entries))
>>>> +		    && (!max_entries && count++ < max_entries)) {
>>>> but then we can not walk through all available entries (with max_entries==0)
>>>
>>> No, that's not what I was trying to say. :-)
>>>
>>>>>
>>>>> I'm not sure how that is related to the above paragraph, however.
>>>>>
>>>>
>>>> Previous changelog is not clear, let me rewrite it:
>>>>
>>>> acpi_parse_entries() allows to traverse all available table entries (aka
>>>> subtables) by passing max_entries parameter equal to 0. But for that use
>>>> case acpi_parse_entries() does not inform caller how many entries were
>>>> matched and for how many entries handler was run against. That patch is
>>>> going to fix it.
>>>
>>> Do I understand correctly that count is only ever incremented by current code
>>> if max_entries is different from 0?
>>
>> Right. Currently "count" is incremented only if max_entries > 0.
>
> So can you say that in the changelog, please?
>
> Something like:
>
> "acpi_parse_entries() allows to traverse all available table entries (aka
>   subtables) by passing max_entries parameter equal to 0, but since its count
>   variable is only incremented if max_entries is not 0, the function always
>   returns 0 for max_entries equal to 0.  It would be more useful if it returned
>   the number of entries matched instead, so make it increment count in that
>   case too".
>

Sure, thanks.

Tomasz
