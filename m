From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 9 Jul 2018 15:45:00 -0500
Subject: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
In-Reply-To: <6074707.jx9F3QFrWC@aspire.rjw.lan>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <6074707.jx9F3QFrWC@aspire.rjw.lan>
Message-ID: <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First thanks for the patch..

On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
>> Hi,
>>
>> I'm experiencing two problems with commit 5088814a6e931 which is
>> "ACPICA: AML parser: attempt to continue loading table after error"
>>
>> The first is this boot failure on a thunderX2:
>>
>> [   10.770098] ACPI Error: Ignore error and continue table load

[trimming]

>> ]---
>>
>> Which does appear to be the result of some bad data in the table, but it
>> was working with 4.17, and reverting this commit solves the problem.
> 
> Does the patch below make any difference?
> 
> ---
>   drivers/acpi/acpica/psobject.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/acpi/acpica/psobject.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
> +++ linux-pm/drivers/acpi/acpica/psobject.c
> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
>   	ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
>   
>   	walk_state->aml = walk_state->parser_state.aml;
> +	if (!walk_state->aml)
> +		return AE_CTRL_PARSE_CONTINUE;
> +

Well this seems to avoid the crash, but now it hangs right after on the 
"Ignore error and continue table load" message. I would post the DSDT 
but I'm borrowing this machine, and I understand the firmware to be an 
early release, so...

Anyway, now that I have access again, i'm turning up the debug 
messaging, let me see if that points at whats causing the hang.


Thanks,
