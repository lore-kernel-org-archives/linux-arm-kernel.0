From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Aug 2016 15:51:35 +0100
Subject: [PATCH v10 7/7] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <828911ef-fbc6-5db1-acce-239117b62fd0@codeaurora.org>
References: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
 <1468950779-21745-8-git-send-email-sudeep.holla@arm.com>
 <579BA8DE.3050802@codeaurora.org>
 <4963f55a-d014-ec7b-2d9d-471fb3f29204@arm.com>
 <828911ef-fbc6-5db1-acce-239117b62fd0@codeaurora.org>
Message-ID: <ccf9be5c-bf5b-181f-ed36-4f72c4d79da5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 15/08/16 15:47, Christopher Covington wrote:
> Hi Sudeep,
>
> On 08/02/2016 09:00 AM, Sudeep Holla wrote:
>>
>> On 29/07/16 20:05, Christopher Covington wrote:
>>> Hi Sudeep,
>>>
>>> On 07/19/2016 01:52 PM, Sudeep Holla wrote:
>>>> Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
>>>> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>>>>
>>>> This patch just removes the IA64 and X86 dependency on
>>>> ACPI_PROCESSOR_IDLE
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>  drivers/acpi/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index 1358fb7d7a68..d74275c0f374 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -238,7 +238,7 @@ config ACPI_CPPC_LIB
>>>>  config ACPI_PROCESSOR
>>>>      tristate "Processor"
>>>>      depends on X86 || IA64 || ARM64
>>>> -    select ACPI_PROCESSOR_IDLE if X86 || IA64
>>>> +    select ACPI_PROCESSOR_IDLE
>>>>      select ACPI_CPU_FREQ_PSS if X86 || IA64
>>>>      default y
>>>>      help
>>>>
>>>
>>> This causes a boot hang on QDF2432. cpuidle.off=1 works around the
>>> problem. I understand you're working on a fix to the problem in GICv3
>>> code. If there's anything I can do to help, please let me know.
>>
>> Sorry for the late response, I was away. Yes it's to do with GICv3 and
>> retention states. I exchanged mails with QCOM guys in private. To
>> summarize:
>>
>> We don't need any additional support in Linux to support that. Infact we
>> need to remove disabling the redistributor in the powerdown path. PSCI
>> implementation also do the same for Group0(aka secure/EL3 interrupts)
>> and we currently do that for Group1(aka EL1N interrupts) in Linux. The
>> plan was to move that to EL3 code, to align with GICv2 code.
>>
>> Hence the changes in Linux is just removal of the GICv3 PM notifier
>> partially. I will need to check with Trusted Firmware team and do some
>> testing before I post that change. I will plan to do that later this week.
>
> Have you been able to make progress on the fix? If there's anything we
> can do to help, please let us know. If the fix is going to take a while,
> would it be appropriate to revert the Kconfig change until it is in place?
>

Thanks for the remainder. Yes I will post this week, I posted arm
trusted firmware patch first and was waiting it to be pulled.

-- 
Regards,
Sudeep
