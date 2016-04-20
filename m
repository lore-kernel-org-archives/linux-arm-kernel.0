From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 20 Apr 2016 11:20:59 +0100
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <CAGm_ybgNWyRXc3PmOE99=3q9A0Jpjm9taHww8p3oD3YRwfJDxA@mail.gmail.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
 <CAGm_ybgNWyRXc3PmOE99=3q9A0Jpjm9taHww8p3oD3YRwfJDxA@mail.gmail.com>
Message-ID: <5717580B.8060209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/04/16 10:59, Vikas Sajjan wrote:
> Hi Sudeep,
>
> On Tue, Apr 19, 2016 at 6:00 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> It also selects ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI is enabled
>> on ARM64.
>>

[...]

>> @@ -211,6 +214,37 @@ void __init acpi_boot_table_init(void)
>>          }
>>   }
>>
>> +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
>> +{
>> +       return arm_cpuidle_init(cpu);
>> +}
>> +
>
> This is generating warning as below:
>
> WARNING: vmlinux.o(.text+0x11024): Section mismatch in reference from
> the function acpi_processor_ffh_lpi_probe() to the function
> .init.text:arm_cpuidle_init()
> The function acpi_processor_ffh_lpi_probe() references
> the function __init arm_cpuidle_init().
> This is often because acpi_processor_ffh_lpi_probe lacks a __init
> annotation or the annotation of arm_cpuidle_init is wrong.
>

I am aware of this and needs to be fixed. I posted ARM64/PSCI related
patches for completeness.

We can't have __init annotation for ..ffh_lpi_probe as it can be called
from hotplug paths in ACPI. Only solution I see is to remove __init tag
for arm_cpuidle_init. I raised similar concern on the other thread
yesterday[1]

Thanks for looking at these patches, much appreciated.

>
>> +struct acpi_processor_lpi *lpi;
>> +int acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
>
> Wondering how are you handling with Resource Dependencies for Idle.
> I mean _RDI needs to be taken care, since the dependency between the
> power resources and the LPI state is described in _RDI.
>

Correct, right now I haven't considered RDI yet as I don't have proper
platform to test. IMO it can be added later as RDI is optional and not
used on all platforms.

-- 
Regards,
Sudeep

[1] http://lkml.iu.edu/hypermail/linux/kernel/1604.2/02181.html
