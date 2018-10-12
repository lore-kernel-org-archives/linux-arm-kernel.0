From: james.morse@arm.com (James Morse)
Date: Fri, 12 Oct 2018 18:18:28 +0100
Subject: [PATCH v6 07/18] arm64: KVM/mm: Move SEA handling behind a single
 'claim' interface
In-Reply-To: <20181012100212.GA580@zn.tnic>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-8-james.morse@arm.com> <20181012100212.GA580@zn.tnic>
Message-ID: <6cd00d26-df00-b5d9-5144-073672efe87a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 12/10/2018 11:02, Borislav Petkov wrote:
> On Fri, Sep 21, 2018 at 11:16:54PM +0100, James Morse wrote:
>> To split up APEIs in_nmi() path, we need the nmi-like callers to always
>> be in_nmi(). Add a helper to do the work and claim the notification.
>>
>> When KVM or the arch code takes an exception that might be a RAS
>> notification, it asks the APEI firmware-first code whether it wants
>> to claim the exception. We can then go on to see if (a future)
>> kernel-first mechanism wants to claim the notification, before
>> falling through to the existing default behaviour.
>>
>> The NOTIFY_SEA code was merged before we had multiple, possibly
>> interacting, NMI-like notifications and the need to consider kernel
>> first in the future. Make the 'claiming' behaviour explicit.
>>
>> As we're restructuring the APEI code to allow multiple NMI-like
>> notifications, any notification that might interrupt interrupts-masked
>> code must always be wrapped in nmi_enter()/nmi_exit(). This allows APEI
>> to use in_nmi() to use the right fixmap entries.
>>
>> We mask SError over this window to prevent an asynchronous RAS error
>> arriving and tripping 'nmi_enter()'s BUG_ON(in_nmi()).

>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index ed46dc188b22..a9b8bba014b5 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -257,3 +259,30 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>>  		return __pgprot(PROT_NORMAL_NC);
>>  	return __pgprot(PROT_DEVICE_nGnRnE);
>>  }
>> +
>> +/*
>> + * Claim Synchronous External Aborts as a firmware first notification.
>> + *
>> + * Used by KVM and the arch do_sea handler.
>> + * @regs may be NULL when called from process context.
>> + */
>> +int apei_claim_sea(struct pt_regs *regs)
>> +{
>> +	int err = -ENOENT;
>> +	unsigned long current_flags = arch_local_save_flags();
>> +
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_SEA))
>> +		return err;
> 
> I don't know what side effects arch_local_save_flags() has on ARM but if

It reads the current 'masked' state for IRQs, debug exceptions and 'SError'.


> we return here, it looks to me like useless work.

Yes. I lazily assume the compiler will rip that out as the value is never used.
But in this case it can't, because its wrapped in asm-volatile, so it doesn't
know it has no side-effects.

I'll move it further down.

Thanks!

James
