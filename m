From: james.morse@arm.com (James Morse)
Date: Wed, 15 Feb 2017 12:13:09 +0000
Subject: [PATCH V8 06/10] acpi: apei: panic OS with fatal error status
 block
In-Reply-To: <5b06372d-e389-5157-ccb4-a7b023990d4d@codeaurora.org>
References: <1485969413-23577-1-git-send-email-tbaicar@codeaurora.org>
 <1485969413-23577-7-git-send-email-tbaicar@codeaurora.org>
 <589C490A.9080109@arm.com>
 <5b06372d-e389-5157-ccb4-a7b023990d4d@codeaurora.org>
Message-ID: <58A445D5.7030501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 13/02/17 22:45, Baicar, Tyler wrote:
> On 2/9/2017 3:48 AM, James Morse wrote:
>> On 01/02/17 17:16, Tyler Baicar wrote:
>>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>>
>>> Even if an error status block's severity is fatal, the kernel does not
>>> honor the severity level and panic.
>>>
>>> With the firmware first model, the platform could inform the OS about a
>>> fatal hardware error through the non-NMI GHES notification type. The OS
>>> should panic when a hardware error record is received with this
>>> severity.
>>>
>>> Call panic() after CPER data in error status block is printed if
>>> severity is fatal, before each error section is handled.

>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 8756172..86c1f15 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -687,6 +689,13 @@ static int ghes_ack_error(struct acpi_hest_generic_v2
>>> *generic_v2)
>>>       return rc;
>>>   }
>>>   +static void __ghes_call_panic(void)
>>> +{
>>> +    if (panic_timeout == 0)
>>> +        panic_timeout = ghes_panic_timeout;
>>> +    panic("Fatal hardware error!");
>>> +}
>>> +

>> __ghes_panic() also has:
>>>     __ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
>> Which prints this estatus regardless of rate limiting and cache-ing.

[...]

>>>               ghes_estatus_cache_add(ghes->generic, ghes->estatus);
>>>       }
>>> +    if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
>>> +        __ghes_call_panic();
>>> +    }

>> I think this ghes_severity() then panic() should go above the:
>>>     if (!ghes_estatus_cached(ghes->estatus)) {
>> and we should call __ghes_print_estatus() here too, to make sure the message
>> definitely got out!


> Okay, that makes sense. If we move this up, is there a problem with calling
> __ghes_panic() instead of making the __ghes_print_estatus() and
> __ghes_call_panic() calls here? It looks like that will just add a call to
> oops_begin() and ghes_print_queued_estatus() as well, but this is what
> ghes_notify_nmi() does if the severity is panic.


I don't think the queued stuff is relevant, isn't that just for x86-NMI messages
that it doesn't print out directly?

A quick grep shows arm64 doesn't have oops_begin(), you may have to add some
equivalent mechanism. Lets try and avoid that rabbit hole!

Given __ghes_panic() calls __ghes_print_estatus() too, you could try moving that
into your new __ghes_call_panic().... or whatever results in the least lines
changed!


Thanks,

James
