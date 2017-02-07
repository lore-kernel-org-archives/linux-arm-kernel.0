From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 07 Feb 2017 12:03:06 +0000
Subject: [PATCH] arm64: kconfig: allow support for memory failure handling
In-Reply-To: <ec1f1a61-8569-58b8-a78f-972f43a5e8ca@codeaurora.org> (Tyler
 Baicar's message of "Mon, 6 Feb 2017 15:26:37 -0700")
References: <1485985115-27274-1-git-send-email-tbaicar@codeaurora.org>
 <8737fvqlxs.fsf@e105922-lin.cambridge.arm.com>
 <ec1f1a61-8569-58b8-a78f-972f43a5e8ca@codeaurora.org>
Message-ID: <87k292yzr9.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Baicar, Tyler" <tbaicar@codeaurora.org> writes:

> Hello Punit,
>
>
> On 2/3/2017 9:27 AM, Punit Agrawal wrote:
>> Tyler Baicar <tbaicar@codeaurora.org> writes:
>>
>>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>>>
>>> If ACPI_APEI and MEMORY_FAILURE is configured, select
>>> ACPI_APEI_MEMORY_FAILURE. This enables memory failure recovery
>>> when such memory failure is reported through ACPI APEI. APEI
>>> (ACPI Platform Error Interfaces) provides a means for the
>>> platform to convey error information to the kernel.
>>>
>>> Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
>>> memory failure recovery attempt.
>>>
>>> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>>> ---
>>>   arch/arm64/Kconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index f92778d..4cd12a0 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -15,6 +15,8 @@ config ARM64
>>>   	select ARCH_HAS_SG_CHAIN
>>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>   	select ARCH_USE_CMPXCHG_LOCKREF
>>> +	select ACPI_APEI_MEMORY_FAILURE if ACPI_APEI && MEMORY_FAILURE
>>> +	select ARCH_SUPPORTS_MEMORY_FAILURE
>> Although enabling support for memory failure handling makes sense in the
>> architecture config, it feels out of place to select
>> ACPI_APEI_MEMORY_FAILURE here.
>>
>> Maybe key it off of CONFIG_APEI?
> Yes, I can move it there.
>
> config ACPI_APEI
>         bool "ACPI Platform Error Interface (APEI)"
>         select MISC_FILESYSTEMS
>         select PSTORE
>         select UEFI_CPER
> +        select ACPI_APEI_MEMORY_FAILURE if MEMORY_FAILURE
>         depends on HAVE_ACPI_APEI
>

That's what I was suggesting - we'll see what the ACPI maintainers think
of the change.

> The ARCH_SUPPORTS_MEMORY_FAILURE should remain in arch/arm64/Kconfig
> though, correct?

Yes, that's right - as that's a feature the architecture is advertising
support for, it should stay in the arm64 Kconfig,

>
> Thanks,
> Tyler
