From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Thu, 5 Jan 2017 15:31:06 -0700
Subject: [PATCH V6 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <58594E62.3050003@arm.com>
References: <1481147303-7979-1-git-send-email-tbaicar@codeaurora.org>
 <1481147303-7979-6-git-send-email-tbaicar@codeaurora.org>
 <58594E62.3050003@arm.com>
Message-ID: <8b7fa162-0d44-025f-758d-d61cfa75c787@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2016 8:29 AM, James Morse wrote:
> Hi Tyler,
>
> On 07/12/16 21:48, Tyler Baicar wrote:
>> ARM APEI extension proposal added SEA (Synchrounous External
>> Abort) notification type for ARMv8.
>> Add a new GHES error source handling function for SEA. If an error
>> source's notification type is SEA, then this function can be registered
>> into the SEA exception handler. That way GHES will parse and report
>> SEA exceptions when they occur.
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 2acbc60..66ab3fd 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -767,6 +771,62 @@ static struct notifier_block ghes_notifier_sci = {
>>   	.notifier_call = ghes_notify_sci,
>>   };
>>   
>> +#ifdef CONFIG_HAVE_ACPI_APEI_SEA
>> +static LIST_HEAD(ghes_sea);
>> +
>> +static int ghes_notify_sea(struct notifier_block *this,
>> +				  unsigned long event, void *data)
>> +{
>> +	struct ghes *ghes;
>> +	int ret = NOTIFY_DONE;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
>> +		if (!ghes_proc(ghes))
>> +			ret = NOTIFY_OK;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
> What stops this from being re-entrant?
>
> ghes_copy_tofrom_phs() takes the ghes_ioremap_lock_irq spinlock, but there is
> nothing to stop a subsequent instruction fetch or memory access causing another
> (maybe different) Synchronous External Abort which deadlocks trying to take the
> same lock.
>
> ghes_notify_sea() looks to be based on ghes_notify_sci(), which (if I've found
> the right part of the ACPI spec) is a level-low interrupt. spin_lock_irqsave()
> would mask interrupts so there is no risk of a different notification firing on
> the same CPU, (it looks like they are almost all ultimately an irq).
>
> NMI is the odd one out because its not maskable like this, but ghes_notify_nmi()
> has:
>> 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>> 		return ret;
> To ensure there is only ever one thread poking around in this code.
>
> What happens if a system describes two GHES sources, one using an irq the other
> SEA? The SEA error can interrupt the irq error while its holding the above lock.
> I guess this is also why all the NMI code in that file is separate.
>
>
> Thanks,
>
> James
Hi James,

Let me see if I'm following you right :)
I should use spin_lock_irqsave() in ghes_notify_sea() to avoid 
ghes_notify_sci() from
interrupting this process and potentially causing the deadlock?

This race condition does seem valid. We are using the same 
acknowledgment for all our
HEST table entries, so our firmware will not populate more than one 
entry at a time. That
gets us around this race condition.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
