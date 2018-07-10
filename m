From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 9 Jul 2018 22:44:05 -0500
Subject: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
In-Reply-To: <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <6074707.jx9F3QFrWC@aspire.rjw.lan>
 <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
 <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com>
Message-ID: <218e4339-477d-eb0d-6007-764c8e24229f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/09/2018 04:28 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 9, 2018 at 10:45 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> Hi,
>>
>> First thanks for the patch..
>>
>> On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
>>>
>>> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm experiencing two problems with commit 5088814a6e931 which is
>>>> "ACPICA: AML parser: attempt to continue loading table after error"
>>>>
>>>> The first is this boot failure on a thunderX2:
>>>>
>>>> [   10.770098] ACPI Error: Ignore error and continue table load
>>
>>
>> [trimming]
>>
>>>> ]---
>>>>
>>>> Which does appear to be the result of some bad data in the table, but it
>>>> was working with 4.17, and reverting this commit solves the problem.
>>>
>>>
>>> Does the patch below make any difference?
>>>
>>> ---
>>>    drivers/acpi/acpica/psobject.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> Index: linux-pm/drivers/acpi/acpica/psobject.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
>>> +++ linux-pm/drivers/acpi/acpica/psobject.c
>>> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
>>>          ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
>>>          walk_state->aml = walk_state->parser_state.aml;
>>> +       if (!walk_state->aml)
>>> +               return AE_CTRL_PARSE_CONTINUE;
>>> +
>>
>>
>> Well this seems to avoid the crash, but now it hangs right after on the
>> "Ignore error and continue table load" message.
> 
> Well, maybe we should just abort in that case.
> 
> I'm wondering what happens if you replace the return statement in the
> patch above with
> 
> return_ACPI_STATUS(AE_AML_BAD_OPCODE)

Yes, that is where I went when I applied the patch but I used 
AE_CTRL_TERMINATE, which terminates the loop in acpi_ps_parse_loop() and 
that appears to successfully finish/terminate the initial parsing pass. 
But, it then crashes in acpi_ns_lookup called via the 
acpi_walk_resources sequences that goes through ut_evalute_object() due 
to the path/scope_info->scope.node being ACPI_ROOT_OBJECT (-1) and 
bypassing the null check. Adding a ACPI_ROOT_OBJECT check as well as the 
null checks in acpi_ns_lookup results in a successful boot. Tracking 
down how the terminate (or whatever) is leaving the info->prefix_node 
(in acpi_ns_evaluate) set to ROOT_OBJECT instead of null, is something I 
don't yet understand.

Anyway, I tried Using BAD_OPCODE rather than TERMINATE and it seems to 
have the same basic result as PARSE_CONTINUE.
