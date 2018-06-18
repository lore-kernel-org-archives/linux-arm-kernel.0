From: geoff@infradead.org (Geoff Levand)
Date: Mon, 18 Jun 2018 11:04:02 -0700
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
Message-ID: <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thanks for all the comments, but my lack of access to an m400 platform, and
my lack of knowledge about the m400 limits what I can comment on and what I
can do.  

My motivation for submitting this fix was to enable CONFIG_ACPI_APEI in the
Debian 10 kernel (for the new Cavium ThunderX2 based systems).  The Debian
maintainers wanted to either have an upstream kernel fix for this m400 APEI
problem or to disable CONFIG_ACPI_APEI.  The later would be unfortunate.  It
means users would need to have custom kernels to get APEI support or go
without.

Comments follow.

On 06/18/2018 09:18 AM, James Morse wrote:
> On 15/06/18 18:17, Geoff Levand wrote:
> 
> From:
> https://bugzilla.redhat.com/show_bug.cgi?id=1574718
> 
> This is tripped by the ghes_probe() call, it finds an error has already occurred
> before ghes code is initialized.
> 
> Does this still happen if you compile without CONFIG_PCI? (that is easily half
> the dmesg that has happened before this point).
> Disabling CONFIG_EFIVAR_FS would be interesting too, as that is firmware-code we
> can't fix bugs in.

Sorry, no m400 to test these on, but looking at the code, I would say it doesn't
occur if CONFIG_PCI=n.

> Your argument here is the that the firmware-vendor only build-tested their code,
> and never noticed it notifies a fatal exception on startup. I find this hard to
> believe, especially as these systems don't have EL3.
> 
> It's much more likely a driver is causing this, possibly because of bad data in
> the firmware tables. I'd like to quirk the driver, so we can fix the next error
> like this, as opposed to blindly continuing.

That sounds OK, but which driver?

> If it really is firmware, what is it doing that causes this error, and where
> does it run? Disabling APEI is just reacting after the error has occurred, when
> we could prevent it happening.
> 
> I can't reproduce this on a Mustang. I assume its the different ACPI tables, not
> the kernel-config.

>From what I understand this is only on the m400, not the Mustang.

>> I just put together this patch to unify things and have a
>> common 'upstream' fix.
> 
> Wouldn't passing 'hest_disable' on the cmdline do the same for all kernel versions?

Yes, the current patch essentially just sets hest_disable when an m400 is
detected.  The cmdline work-around is what some have been using, but is
not an acceptable solution for the Debian maintainers.  See

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900581

>> On 06/15/2018 04:14 AM, James Morse wrote:
>>> On 13/06/18 19:22, Geoff Levand wrote:
>>>> Adds a new ACPI init routine acpi_fixup_m400_quirks that adds
>>>> a work-around for HPE ProLiant m400 APEI firmware problems.
>>>>
>>>> The work-around disables APEI when CONFIG_ACPI_APEI is set and
>>>> m400 firmware is detected.  Without this fixup m400 systems
>>>> experience errors like these on startup:
>>>>
>>>>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
>>>>   [Hardware Error]: event severity: fatal
>>>>   [Hardware Error]:  Error 0, type: fatal
>>>>   [Hardware Error]:   section_type: memory error
>>>>   [Hardware Error]:   error_status: 0x0000000000001300
>>>
>>> "Access to a memory address which is not mapped to any component"
>>>
>>>
>>>>   [Hardware Error]:   error_type: 10, invalid address
>>>>   Kernel panic - not syncing: Fatal hardware error!
>>>
>>> Why is this a problem?
>>>
>>> Surely this is a valid description of an error.
>>
>> The firmware bug causes this failure, not bad hardware.
> 
> I'm not talking about bad hardware here. What I think is happening is a software
> bug is causing the CPU to make a bad access, which the RAS mechanism is
> reporting like this because software would never be stupid enough to access an
> address which is not mapped to any component! The RAS stuff believes this must
> be address corruption.
> 
> I think this is a linux-driver bug, or a typo in the firmware tables, that cause
> $non_existent_address to be mapped and probed.

>From what I know about it the problem is in the access of the firmware tables,
and that corrupted data is retrieved.  But I am not sure, as there are so many
reported m400 firmware problems it is hard to tell what exactly is what.

>>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>>> index 7b09487ff8fb..3c315c2c7476 100644
>>>> --- a/arch/arm64/kernel/acpi.c
>>>> +++ b/arch/arm64/kernel/acpi.c
> 
>>>> +
>>>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI) || hest_disable != HEST_ENABLED)
>>>> +		return;
>>>> +
>>>> +	status = acpi_get_table(ACPI_SIG_HEST, 0, &header);
>>>> +
>>>> +	if (ACPI_SUCCESS(status) && !strncmp(header->oem_id, "HPE   ", 6) &&
>>>> +		!strncmp(header->oem_table_id, "ProLiant", 8) &&
> 
>>> You should match the affected range of OEM table revisions too, that way a
>>> firmware upgrade should start working, instead of being permanently disabled
>>> because we think its unlikely.
>>
>> The m400 has reached end of life. No one really expects to see any firmware
>> update.  I don't know what the effected OEM table revisions are, and I don't
>> think there is an active platform maintainer who could give that info either.
>>
>> If someone can provide the info. I'll update the fix.
> 
> We can start with the version you have. You mention distro's have their own
> fixes, hopefully they can supply the missing range of values.

It seems you are living in a dream world...

>>>> +		MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
>>>
>>> How is the CPU implementer relevant?
>>
>> That was just a copy of what other fixes had.  Should I remove it?
> 
> The conclusion in the rest of this thread was HPE also produces ProLiant boxes
> with a (presumably) identical HEST, but a totally different architecture.
> 
> Matching the DMI platform name as well would work round this. (or somewhere only
> arm64 builds, with an appropriate comment in case we move it).
> 
> 
>>> Nothing arch-specific here. You're adding this to arch/arm64 because
>>> drivers/acpi/apei doesn't have an existing quirks table?
>>
>> There was a fix submitted that had it in drivers/acpi/scan.c, but the
>> ACPI maintainer said he didn't want the fix in the main ACPI code.
> 
> Specifically about a HID-hack in the core device enumeration code, as opposed to
> in the driver that claims it.
> 
> 
>> See:
>>
>>   https://lkml.org/lkml/2018/4/19/1020 (ACPI / scan: Fix regression related to X-Gene UARTs)
> 
> | 'some X-Gene based platforms (Mustang and M400) with invalid DSDT.'
> 
> ... sounds familiar ...
> 
> And:
> https://bugzilla.redhat.com/attachment.cgi?id=1144903&action=diff
> 
> Fixes a typo in firmware description of the GIC.
> 
> Why do we think this is a new kind of firmware bug, and not a repeat of the last
> two? The only difference is this is being caught by the RAS code.

It could very well be.

>> The m400 is an arm64 platform, so it seems most appropriate to
>> have it in arch/arm64/kernel/acpi.c.
> 
> We don't keep all drivers under arch/arm64, I'd really like to find the driver
> that is causing this, and quirk it there.
> 
> If we have to bolt the hest-stable-door, drivers/acpi/apei/hest.c looks better,
> it at least doesn't have to bodge around hest_disabled not being exposed in a
> compatible way. If the maintainer objects, (as x86 hasn't had to do this yet),
> then we can try drivers/acpi/arm64/hest_quirks.c.

We need to call acpi_fixup_m400_quirks early enough to get hest_disable set
before it is used.  To do that from drivers/acpi/ code we would need have
it as arch_initcall, or still call it from acpi_boot_table_init.  I think
having it as a static routine and the call in arch/arm64/kernel/acpi.c is
cleaner.

> When only once architecture had to quirk stuff based on the ACPI tables, the
> arch-code was a suitable dumping ground. Now there is more than one, we should
> do things in a way they are useful to both architectures.

As I mentioned in the opening, I don't have access to m400 equipment.  There is
little I can do.  I could move acpi_fixup_m400_quirks into
drivers/acpi/apei/hest.c and submit that to the ACPI maintainer, but based on
https://lkml.org/lkml/2018/4/19/1020, I don't think it would be accepted.

-Geoff
